import 'dart:io';

import 'package:dio/dio.dart';
import 'package:gps_tracker/data/repositories/auth_repository.dart';
import 'package:gps_tracker/domain/entities/result.dart';
import 'package:gps_tracker/domain/entities/user.dart';
import 'package:gps_tracker/presentation/misc/api_client.dart';
import 'package:gps_tracker/presentation/misc/token_helper.dart';

class ApiAuthRepository implements AuthRepository {
  late final ApiClient _apiClient;

  ApiAuthRepository({ApiClient? apiClient}) : _apiClient = apiClient ?? ApiClient();

  @override
  Future<bool> getLoggedInUser() async {
    final result = await getSession();
    if (result.isSuccess) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<Result<User>> getSession() async {
    try {
      final token = await TokenHelper().getToken();
      final response = await _apiClient.get("/session",
          queryParams: {"token": token},
          options: Options(
            headers: {
              HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded",
            },
          ));
      final result = User.fromJson(response.data);

      return Result.success(result);
    } on DioException catch (e) {
      // printIfDebug(e.error.toString());
      return Result.failed(e.response?.data['message'].toString() ?? "");
    }
  }

  @override
  Future<Result<User>> login({required String email, required String password}) async {
    try {
      final response = await _apiClient.post("/session",
          data: {
            "email": email,
            "password": password,
          },
          options: Options(
            headers: {
              HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded",
            },
          ));

      if (response.statusCode == 200) {
        // Mendapatkan cookie JSESSIONID dari header Set-Cookie
        final cookies = response.headers[HttpHeaders.setCookieHeader];
        String? jsessionid;
        if (cookies != null && cookies.isNotEmpty) {
          jsessionid = cookies
              .firstWhere(
                (cookie) => cookie.contains("JSESSIONID"),
                orElse: () => '',
              )
              .split(';')
              .first;

          if (jsessionid.isNotEmpty) {
            final tokenResult = await generateToken(cookies: jsessionid);

            if (tokenResult.isSuccess) {
              final responseUser = await getSession();

              if (responseUser.isSuccess) {
                final user = User.fromJson(response.data);
                return Result.success(user);
              } else {
                return Result.failed(responseUser.errorMessage ?? "");
              }
            } else {
              return Result.failed(tokenResult.errorMessage.toString());
            }
          } else {
            return const Result.failed("JSESSIONID not found in cookies.");
          }
        } else {
          return const Result.failed("Failed to retrieve cookies from login response.");
        }
      } else {
        return const Result.failed("Failed to create token.");
      }
    } on DioException catch (e) {
      return Result.failed(e.response?.data['message'] ?? "");
    }
  }

  @override
  Future<Result<void>> logout() async {
    try {
      final token = await TokenHelper().getToken();
      final response = await _apiClient.delete("/session", authorization: true, token: token);
      if (response.statusCode == HttpStatus.noContent) {
        TokenHelper().setToken(null);
        return const Result.success(null);
      }
      return Result.failed(response.data['message']);
    } on DioException catch (e) {
      return Result.failed(e.response?.data['message'] ?? "");
    }
  }

  @override
  Future<Result<String>> generateToken({required String cookies}) async {
    try {
      final expiration = DateTime.now().add(const Duration(days: 7)).toUtc().toIso8601String();

      final response = await _apiClient.post(
        "/session/token",
        data: {
          "expiration": expiration,
        },
        options: Options(
          responseType: ResponseType.plain,
          headers: {
            HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded",
            HttpHeaders.cookieHeader: cookies,
          },
        ),
      );

      if (response.statusCode == 200) {
        final token = response.data.toString();
        TokenHelper().setToken(token);
        return Result.success(token);
      }
      return Result.failed(response.statusMessage ?? "");
    } on DioException catch (e) {
      return Result.failed(e.response?.statusMessage ?? "");
    }
  }
}
