import 'package:gps_tracker/domain/entities/device.dart';
import 'package:gps_tracker/domain/entities/result.dart';

abstract interface class DeviceRepository {
  Future<Result<List<Device>>> getDevices();
}
