import 'package:gps_tracker/data/repositories/device_repository.dart';
import 'package:gps_tracker/domain/entities/device.dart';
import 'package:gps_tracker/domain/entities/result.dart';

class DummyDeviceRepository implements DeviceRepository {
  @override
  Future<Result<List<Device>>> getDevices() async {
    await Future.delayed(const Duration(seconds: 1));
    List<Device> results = [
      Device(
        id: 1,
        name: "BEAT D 3133 UEY",
        uniqueId: "1122345678",
        status: "Active",
        model: "GPS",
        category: "Motor",
        disabled: false,
      )
    ];
    return Result.success(results);
  }
}
