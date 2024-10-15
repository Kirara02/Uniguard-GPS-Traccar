import 'package:dio/dio.dart';
import 'package:gps_tracker/data/repositories/device_repository.dart';
import 'package:gps_tracker/domain/entities/device.dart';
import 'package:gps_tracker/domain/entities/result.dart';
import 'package:gps_tracker/presentation/misc/api_client.dart';
import 'package:gps_tracker/presentation/misc/token_helper.dart';

class ApiDeviceRepository implements DeviceRepository {
  late final ApiClient _apiClient;

  ApiDeviceRepository({ApiClient? apiClient}) : _apiClient = apiClient ?? ApiClient();

  @override
  Future<Result<List<Device>>> getDevices() async {
    try {
      final token = await TokenHelper().getToken();
      final response = await _apiClient.get("/devices",
          authorization: true,
          token: token,
          options: Options(
            headers: {"Content-Type": "application/json"},
          ));

      final result = (response.data as List).map((data) => Device.fromJson(data)).toList();

      return Result.success(result);
    } on DioException catch (e) {
      return Result.failed(e.response?.data['message'] ?? "");
    }
  }
}
