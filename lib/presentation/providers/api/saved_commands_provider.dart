import 'package:gps_tracker/domain/entities/command.dart';
import 'package:gps_tracker/domain/entities/result.dart';
import 'package:gps_tracker/domain/usecase/get_saved_commands/get_saved_commands.dart';
import 'package:gps_tracker/presentation/providers/usecases/get_saved_commands_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'saved_commands_provider.g.dart';

@riverpod
class SavedCommands extends _$SavedCommands {
  @override
  FutureOr<List<Command>> build() => [];

  Future<void> getSavedCommands({required int deviceId}) async {
    state = const AsyncLoading();
    GetSavedCommands getSavedCommands = ref.read(getSavedCommandsProvider);

    var result = await getSavedCommands(deviceId);
    
    switch (result) {
      case Success(value: final data):
        state = AsyncData(data);
      case Failed(message: _):
        state = const AsyncData([]);
    }
  }
}
