// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'command.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommandImpl _$$CommandImplFromJson(Map<String, dynamic> json) =>
    _$CommandImpl(
      id: (json['id'] as num).toInt(),
      attributes: json['attributes'] == null
          ? null
          : Attributes.fromJson(json['attributes'] as Map<String, dynamic>),
      deviceId: (json['deviceId'] as num).toInt(),
      type: json['type'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$CommandImplToJson(_$CommandImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'attributes': instance.attributes,
      'deviceId': instance.deviceId,
      'type': instance.type,
      'description': instance.description,
    };
