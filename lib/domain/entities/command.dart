import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gps_tracker/domain/entities/attributes.dart';

part 'command.freezed.dart';
part 'command.g.dart';

@freezed
class Command with _$Command {
  factory Command({
    required int id,
    Attributes? attributes,
    required int deviceId,
    String? type,
    String? description,
  }) = _Command;

  factory Command.fromJson(Map<String, dynamic> json) => _$CommandFromJson(json);
}
