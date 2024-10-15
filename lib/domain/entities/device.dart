import 'package:freezed_annotation/freezed_annotation.dart';

part 'device.freezed.dart';
part 'device.g.dart';

@freezed
class Device with _$Device {
  factory Device({
    required int id,
    required String name,
    required String uniqueId,
    required String status,
    String? phone,
    String? contact,
    String? model,
    String? category,
    bool? disabled,
    String? lastUpdate,
  }) = _Device;

  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);
}
