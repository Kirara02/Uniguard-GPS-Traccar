// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'command.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Command _$CommandFromJson(Map<String, dynamic> json) {
  return _Command.fromJson(json);
}

/// @nodoc
mixin _$Command {
  int get id => throw _privateConstructorUsedError;
  Attributes? get attributes => throw _privateConstructorUsedError;
  int get deviceId => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CommandCopyWith<Command> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommandCopyWith<$Res> {
  factory $CommandCopyWith(Command value, $Res Function(Command) then) =
      _$CommandCopyWithImpl<$Res, Command>;
  @useResult
  $Res call(
      {int id,
      Attributes? attributes,
      int deviceId,
      String? type,
      String? description});

  $AttributesCopyWith<$Res>? get attributes;
}

/// @nodoc
class _$CommandCopyWithImpl<$Res, $Val extends Command>
    implements $CommandCopyWith<$Res> {
  _$CommandCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? attributes = freezed,
    Object? deviceId = null,
    Object? type = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      attributes: freezed == attributes
          ? _value.attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as Attributes?,
      deviceId: null == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as int,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AttributesCopyWith<$Res>? get attributes {
    if (_value.attributes == null) {
      return null;
    }

    return $AttributesCopyWith<$Res>(_value.attributes!, (value) {
      return _then(_value.copyWith(attributes: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CommandImplCopyWith<$Res> implements $CommandCopyWith<$Res> {
  factory _$$CommandImplCopyWith(
          _$CommandImpl value, $Res Function(_$CommandImpl) then) =
      __$$CommandImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      Attributes? attributes,
      int deviceId,
      String? type,
      String? description});

  @override
  $AttributesCopyWith<$Res>? get attributes;
}

/// @nodoc
class __$$CommandImplCopyWithImpl<$Res>
    extends _$CommandCopyWithImpl<$Res, _$CommandImpl>
    implements _$$CommandImplCopyWith<$Res> {
  __$$CommandImplCopyWithImpl(
      _$CommandImpl _value, $Res Function(_$CommandImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? attributes = freezed,
    Object? deviceId = null,
    Object? type = freezed,
    Object? description = freezed,
  }) {
    return _then(_$CommandImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      attributes: freezed == attributes
          ? _value.attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as Attributes?,
      deviceId: null == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as int,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CommandImpl implements _Command {
  _$CommandImpl(
      {required this.id,
      this.attributes,
      required this.deviceId,
      this.type,
      this.description});

  factory _$CommandImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommandImplFromJson(json);

  @override
  final int id;
  @override
  final Attributes? attributes;
  @override
  final int deviceId;
  @override
  final String? type;
  @override
  final String? description;

  @override
  String toString() {
    return 'Command(id: $id, attributes: $attributes, deviceId: $deviceId, type: $type, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommandImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.attributes, attributes) ||
                other.attributes == attributes) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, attributes, deviceId, type, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CommandImplCopyWith<_$CommandImpl> get copyWith =>
      __$$CommandImplCopyWithImpl<_$CommandImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommandImplToJson(
      this,
    );
  }
}

abstract class _Command implements Command {
  factory _Command(
      {required final int id,
      final Attributes? attributes,
      required final int deviceId,
      final String? type,
      final String? description}) = _$CommandImpl;

  factory _Command.fromJson(Map<String, dynamic> json) = _$CommandImpl.fromJson;

  @override
  int get id;
  @override
  Attributes? get attributes;
  @override
  int get deviceId;
  @override
  String? get type;
  @override
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$$CommandImplCopyWith<_$CommandImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
