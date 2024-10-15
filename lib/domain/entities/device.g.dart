// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DeviceImpl _$$DeviceImplFromJson(Map<String, dynamic> json) => _$DeviceImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      uniqueId: json['uniqueId'] as String,
      status: json['status'] as String,
      phone: json['phone'] as String?,
      contact: json['contact'] as String?,
      model: json['model'] as String?,
      category: json['category'] as String?,
      disabled: json['disabled'] as bool?,
      lastUpdate: json['lastUpdate'] as String?,
    );

Map<String, dynamic> _$$DeviceImplToJson(_$DeviceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'uniqueId': instance.uniqueId,
      'status': instance.status,
      'phone': instance.phone,
      'contact': instance.contact,
      'model': instance.model,
      'category': instance.category,
      'disabled': instance.disabled,
      'lastUpdate': instance.lastUpdate,
    };
