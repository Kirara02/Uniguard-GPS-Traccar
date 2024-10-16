import 'package:dio/dio.dart';
import 'package:gps_tracker/data/repositories/command_repository.dart';
import 'package:gps_tracker/domain/entities/command.dart';
import 'package:gps_tracker/domain/entities/result.dart';
import 'package:gps_tracker/presentation/extensions/command_extension.dart';
import 'package:gps_tracker/presentation/misc/api_client.dart';
import 'package:gps_tracker/presentation/misc/token_helper.dart';

class ApiCommandRepository implements CommandRepository {
  late final ApiClient _apiClient;

  ApiCommandRepository({ApiClient? apiClient}) : _apiClient = apiClient ?? ApiClient();

  @override
  Future<Result<List<Command>>> fetchSavedCommand({required int deviceId}) async {
    try {
      final token = await TokenHelper().getToken();
      final response = await _apiClient.get(
        "/commands/send",
        queryParams: {"deviceId": deviceId},
        authorization: true,
        token: token,
        options: Options(
          headers: {"Content-Type": "application/json"},
        ),
      );
      final results = (response.data as List).map((data) => Command.fromJson(data)).toList();
      return Result.success(results);
    } on DioException catch (e) {
      return Result.failed(e.response?.statusMessage.toString() ?? "");
    }
  }

  @override
  Future<Result<Command>> sendCommand({required Command command}) async {
    try {
      final token = await TokenHelper().getToken();
      final response = await _apiClient.post(
        "/commands/send",
        authorization: true,
        token: token,
        data: command.toMap(),
      );
      final result = Command.fromJson(response.data);
      return Result.success(result);
    } on DioException catch (e) {
      return Result.failed(e.response?.statusMessage.toString() ?? "");
    }
  }
}
