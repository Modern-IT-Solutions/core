// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'option_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

OptionModel _$OptionModelFromJson(Map<String, dynamic> json) {
  return _OptionModel.fromJson(json);
}

/// @nodoc
mixin _$OptionModel {
  /// standard model field
  @ModelRefSerializer()
  ModelRef get ref => throw _privateConstructorUsedError;
  @TimestampDateTimeSerializer()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @TimestampDateTimeSerializer()
  DateTime get updatedAt => throw _privateConstructorUsedError;
  @NullableTimestampDateTimeSerializer()
  DateTime? get deletedAt => throw _privateConstructorUsedError;

  /// option model field
  String? get name => throw _privateConstructorUsedError;
  String? get details => throw _privateConstructorUsedError;
  String get key => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OptionModelCopyWith<OptionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OptionModelCopyWith<$Res> {
  factory $OptionModelCopyWith(
          OptionModel value, $Res Function(OptionModel) then) =
      _$OptionModelCopyWithImpl<$Res, OptionModel>;
  @useResult
  $Res call(
      {@ModelRefSerializer() ModelRef ref,
      @TimestampDateTimeSerializer() DateTime createdAt,
      @TimestampDateTimeSerializer() DateTime updatedAt,
      @NullableTimestampDateTimeSerializer() DateTime? deletedAt,
      String? name,
      String? details,
      String key,
      String value,
      String type});
}

/// @nodoc
class _$OptionModelCopyWithImpl<$Res, $Val extends OptionModel>
    implements $OptionModelCopyWith<$Res> {
  _$OptionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ref = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? name = freezed,
    Object? details = freezed,
    Object? key = null,
    Object? value = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      ref: null == ref
          ? _value.ref
          : ref // ignore: cast_nullable_to_non_nullable
              as ModelRef,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      details: freezed == details
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as String?,
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OptionModelImplCopyWith<$Res>
    implements $OptionModelCopyWith<$Res> {
  factory _$$OptionModelImplCopyWith(
          _$OptionModelImpl value, $Res Function(_$OptionModelImpl) then) =
      __$$OptionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@ModelRefSerializer() ModelRef ref,
      @TimestampDateTimeSerializer() DateTime createdAt,
      @TimestampDateTimeSerializer() DateTime updatedAt,
      @NullableTimestampDateTimeSerializer() DateTime? deletedAt,
      String? name,
      String? details,
      String key,
      String value,
      String type});
}

/// @nodoc
class __$$OptionModelImplCopyWithImpl<$Res>
    extends _$OptionModelCopyWithImpl<$Res, _$OptionModelImpl>
    implements _$$OptionModelImplCopyWith<$Res> {
  __$$OptionModelImplCopyWithImpl(
      _$OptionModelImpl _value, $Res Function(_$OptionModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ref = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? name = freezed,
    Object? details = freezed,
    Object? key = null,
    Object? value = null,
    Object? type = null,
  }) {
    return _then(_$OptionModelImpl(
      ref: null == ref
          ? _value.ref
          : ref // ignore: cast_nullable_to_non_nullable
              as ModelRef,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      details: freezed == details
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as String?,
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OptionModelImpl implements _OptionModel {
  _$OptionModelImpl(
      {@ModelRefSerializer() required this.ref,
      @TimestampDateTimeSerializer() required this.createdAt,
      @TimestampDateTimeSerializer() required this.updatedAt,
      @NullableTimestampDateTimeSerializer() this.deletedAt,
      this.name,
      this.details,
      required this.key,
      required this.value,
      required this.type});

  factory _$OptionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$OptionModelImplFromJson(json);

  /// standard model field
  @override
  @ModelRefSerializer()
  final ModelRef ref;
  @override
  @TimestampDateTimeSerializer()
  final DateTime createdAt;
  @override
  @TimestampDateTimeSerializer()
  final DateTime updatedAt;
  @override
  @NullableTimestampDateTimeSerializer()
  final DateTime? deletedAt;

  /// option model field
  @override
  final String? name;
  @override
  final String? details;
  @override
  final String key;
  @override
  final String value;
  @override
  final String type;

  @override
  String toString() {
    return 'OptionModel(ref: $ref, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, name: $name, details: $details, key: $key, value: $value, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OptionModelImpl &&
            (identical(other.ref, ref) || other.ref == ref) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.details, details) || other.details == details) &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, ref, createdAt, updatedAt,
      deletedAt, name, details, key, value, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OptionModelImplCopyWith<_$OptionModelImpl> get copyWith =>
      __$$OptionModelImplCopyWithImpl<_$OptionModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OptionModelImplToJson(
      this,
    );
  }
}

abstract class _OptionModel implements OptionModel {
  factory _OptionModel(
      {@ModelRefSerializer() required final ModelRef ref,
      @TimestampDateTimeSerializer() required final DateTime createdAt,
      @TimestampDateTimeSerializer() required final DateTime updatedAt,
      @NullableTimestampDateTimeSerializer() final DateTime? deletedAt,
      final String? name,
      final String? details,
      required final String key,
      required final String value,
      required final String type}) = _$OptionModelImpl;

  factory _OptionModel.fromJson(Map<String, dynamic> json) =
      _$OptionModelImpl.fromJson;

  @override

  /// standard model field
  @ModelRefSerializer()
  ModelRef get ref;
  @override
  @TimestampDateTimeSerializer()
  DateTime get createdAt;
  @override
  @TimestampDateTimeSerializer()
  DateTime get updatedAt;
  @override
  @NullableTimestampDateTimeSerializer()
  DateTime? get deletedAt;
  @override

  /// option model field
  String? get name;
  @override
  String? get details;
  @override
  String get key;
  @override
  String get value;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$OptionModelImplCopyWith<_$OptionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
