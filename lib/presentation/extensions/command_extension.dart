import 'package:gps_tracker/domain/entities/command.dart';

extension CommandToMap on Command {
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'attributes': attributes?.toJson(),
      'deviceId': deviceId,
      'type': type,
      'description': description,
    };
  }
}
