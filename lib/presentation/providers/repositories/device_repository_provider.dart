import 'package:gps_tracker/data/api/api_device_repository.dart';
import 'package:gps_tracker/data/repositories/device_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_repository_provider.g.dart';

@riverpod
DeviceRepository deviceRepository(DeviceRepositoryRef ref) => ApiDeviceRepository();
