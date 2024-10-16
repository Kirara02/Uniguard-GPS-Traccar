import 'package:gps_tracker/domain/entities/command.dart';
import 'package:gps_tracker/domain/entities/result.dart';

abstract interface class CommandRepository {
  Future<Result<List<Command>>> fetchSavedCommand({required int deviceId});
  Future<Result<Command>> sendCommand({required Command command});
}
