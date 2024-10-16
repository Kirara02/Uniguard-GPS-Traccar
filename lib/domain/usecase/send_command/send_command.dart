import 'package:gps_tracker/data/repositories/command_repository.dart';
import 'package:gps_tracker/domain/entities/command.dart';
import 'package:gps_tracker/domain/entities/result.dart';
import 'package:gps_tracker/domain/usecase/send_command/send_command_params.dart';
import 'package:gps_tracker/domain/usecase/usecase.dart';

class SendCommand implements UseCase<Result<Command>, SendCommandParams> {
  final CommandRepository _commandRepository;

  SendCommand({required CommandRepository commandRepository}) : _commandRepository = commandRepository;

  @override
  Future<Result<Command>> call(SendCommandParams params) async {
    final result = await _commandRepository.sendCommand(command: params.command);

    return switch (result) {
      Success(:final value) => Result.success(value),
      Failed(:final message) => Result.failed(message)
    };
  }
}
