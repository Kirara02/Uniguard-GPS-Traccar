import 'package:gps_tracker/data/repositories/command_repository.dart';
import 'package:gps_tracker/domain/entities/command.dart';
import 'package:gps_tracker/domain/entities/result.dart';
import 'package:gps_tracker/domain/usecase/usecase.dart';

class GetSavedCommands implements UseCase<Result<List<Command>>, int> {
  final CommandRepository _commandRepository;

  GetSavedCommands({required CommandRepository commandRepository}) : _commandRepository = commandRepository;

  @override
  Future<Result<List<Command>>> call(int deviceId) async {
    final result = await _commandRepository.fetchSavedCommand(deviceId: deviceId);

    return switch (result) {
      Success(:final value) => Result.success(value),
      Failed(:final message) => Result.failed(message)
    };
  }
}
