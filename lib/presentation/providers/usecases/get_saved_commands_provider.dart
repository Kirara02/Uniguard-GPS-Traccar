import 'package:gps_tracker/domain/usecase/get_saved_commands/get_saved_commands.dart';
import 'package:gps_tracker/presentation/providers/repositories/command_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_saved_commands_provider.g.dart';

@riverpod
GetSavedCommands getSavedCommands(GetSavedCommandsRef ref) =>
    GetSavedCommands(commandRepository: ref.watch(commandRepositoryProvider));
