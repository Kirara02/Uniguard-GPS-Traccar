import 'package:gps_tracker/data/api/api_command_repository.dart';
import 'package:gps_tracker/data/repositories/command_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'command_repository_provider.g.dart';

@riverpod
CommandRepository commandRepository(CommandRepositoryRef ref) => ApiCommandRepository();
