import 'package:flutter/foundation.dart';
import 'package:gps_tracker/domain/entities/command.dart';
import 'package:gps_tracker/domain/entities/result.dart';
import 'package:gps_tracker/domain/usecase/send_command/send_command.dart';
import 'package:gps_tracker/domain/usecase/send_command/send_command_params.dart';
import 'package:gps_tracker/presentation/providers/usecases/send_command_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_command_provider.g.dart';

@riverpod
class DeviceCommand extends _$DeviceCommand {
  @override
  FutureOr<Command?> build() => null;

  Future<void> sendCommand({required Command command}) async {
    state = const AsyncLoading();
    SendCommand sendCommand = ref.read(sendCommandProvider);

    final result = await sendCommand(SendCommandParams(command: command));

    switch (result) {
      case Success(value: final data):
        state = AsyncData(data);
      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = const AsyncData(null);
    }
  }
}
