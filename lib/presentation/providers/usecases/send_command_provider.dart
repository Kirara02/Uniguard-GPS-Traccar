import 'package:gps_tracker/domain/usecase/send_command/send_command.dart';
import 'package:gps_tracker/presentation/providers/repositories/command_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'send_command_provider.g.dart';

@riverpod
SendCommand sendCommand(SendCommandRef ref) => SendCommand(commandRepository: ref.watch(commandRepositoryProvider));
