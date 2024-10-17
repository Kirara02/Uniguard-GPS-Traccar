import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:gps_tracker/presentation/misc/constants.dart';
import 'package:gps_tracker/presentation/misc/utils.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiClient {
  late Dio _dio;

  ApiClient({
    String? baseUrl,
    String? defaultToken,
  }) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl ?? "${Constants.BASEURL}/api",
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        responseType: ResponseType.json,
      ),
    );

    if (defaultToken?.isNotEmpty ?? false) {
      _dio.options.headers['Authorization'] = "Bearer $defaultToken";
    }

    if (kDebugMode) {
      _dio.interceptors.add(PrettyDioLogger(
        error: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        request: true,
      ));
    }
  }

  Dio get dio => _dio;

  // Fungsi GET
  Future<Response> get(
    String endpoint, {
    Options? options,
    bool authorization = false,
    String? token,
    Map<String, dynamic>? queryParams,
    ResponseType responseType = ResponseType.json, // Default ke JSON
  }) async {
    try {
      if (authorization) _setAuthorization(token);

      final response = await _dio.get(endpoint, queryParameters: queryParams);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Fungsi POST
  Future<Response> post(
    String endpoint, {
    dynamic data,
    bool authorization = false,
    String? token,
    Map<String, dynamic>? queryParams,
    Options? options,
  }) async {
    try {
      if (authorization) _setAuthorization(token);

      final response = await _dio.post(
        endpoint,
        data: data,
        options: options, // Tambahkan ini
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Fungsi PUT
  Future<Response> put(
    String endpoint, {
    Options? options,
    dynamic data,
    bool authorization = false,
    String? token,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      if (authorization) _setAuthorization(token);

      final response = await _dio.put(
        endpoint,
        data: data,
        options: options,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Fungsi DELETE
  Future<Response> delete(
    String endpoint, {
    Options? options,
    Map<String, dynamic>? queryParams,
    bool authorization = false,
    String? token,
  }) async {
    try {
      if (authorization) _setAuthorization(token);

      final response = await _dio.delete(
        endpoint,
        queryParameters: queryParams,
        options: options,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Fungsi PATCH
  Future<Response> patch(
    String endpoint, {
    Options? options,
    dynamic data,
    bool authorization = false,
    String? token,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      if (authorization) _setAuthorization(token);

      final response = await _dio.patch(
        endpoint,
        data: data,
        options: options,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Fungsi DOWNLOAD
  Future<void> download(String url, String savePath) async {
    try {
      await _dio.download(url, savePath);
    } catch (e) {
      rethrow;
    }
  }

  void _setAuthorization(String? token) {
    if (token != null && token.isNotEmpty) {
      printIfDebug("Authorization");

      _dio.options.headers['Authorization'] = 'Bearer $token';
    }
  }
}
