import 'package:freezed_annotation/freezed_annotation.dart';

part 'attributes.freezed.dart';
part 'attributes.g.dart';

@freezed
class Attributes with _$Attributes {
  factory Attributes({
     int? index,
     String? data,
  }) = _Attributes;

  factory Attributes.fromJson(Map<String, dynamic> json) => _$AttributesFromJson(json);
}
