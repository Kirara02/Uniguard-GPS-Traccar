import 'package:gps_tracker/domain/usecase/get_devices/get_devices.dart';
import 'package:gps_tracker/presentation/providers/repositories/device_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_devices_provider.g.dart';

@riverpod
GetDevices getDevices(GetDevicesRef ref) => GetDevices(deviceRepository: ref.watch(deviceRepositoryProvider));
