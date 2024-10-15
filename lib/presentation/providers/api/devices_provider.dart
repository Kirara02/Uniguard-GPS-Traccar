import 'package:gps_tracker/domain/entities/device.dart';
import 'package:gps_tracker/domain/entities/result.dart';
import 'package:gps_tracker/domain/usecase/get_devices/get_devices.dart';
import 'package:gps_tracker/domain/usecase/get_devices/get_devices_params.dart';
import 'package:gps_tracker/presentation/providers/usecases/get_devices_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'devices_provider.g.dart';

@Riverpod(keepAlive: true)
class Devices extends _$Devices {
  @override
  FutureOr<List<Device>> build() => [];

  Future<void> getDevices() async {
    state = const AsyncLoading();
    GetDevices getDevices = ref.read(getDevicesProvider);

    var result = await getDevices(GetDevicesParams());

    switch (result) {
      case Success(value: final data):
        state = AsyncData(data);
      case Failed(message: _):
        state = const AsyncData([]);
    }
  }
}
