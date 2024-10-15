import 'package:gps_tracker/data/repositories/device_repository.dart';
import 'package:gps_tracker/domain/entities/device.dart';
import 'package:gps_tracker/domain/entities/result.dart';
import 'package:gps_tracker/domain/usecase/get_devices/get_devices_params.dart';
import 'package:gps_tracker/domain/usecase/usecase.dart';

class GetDevices implements UseCase<Result<List<Device>>, GetDevicesParams> {
  final DeviceRepository _deviceRepository;

  GetDevices({required DeviceRepository deviceRepository}) : _deviceRepository = deviceRepository;

  @override
  Future<Result<List<Device>>> call(GetDevicesParams params) async {
    var result = await _deviceRepository.getDevices();

    return switch (result) {
      Success(:final value) => Result.success(value),
      Failed(:final message) => Result.failed(message)
    };
  }
}
