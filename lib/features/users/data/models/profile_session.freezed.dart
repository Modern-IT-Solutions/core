// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProfileSession _$ProfileSessionFromJson(Map<String, dynamic> json) {
  return _ProfileSession.fromJson(json);
}

/// @nodoc
mixin _$ProfileSession {
  String get token => throw _privateConstructorUsedError;
  @TimestampDateTimeSerializer()
  DateTime get createdAt => throw _privateConstructorUsedError;
  bool get valid => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProfileSessionCopyWith<ProfileSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileSessionCopyWith<$Res> {
  factory $ProfileSessionCopyWith(
          ProfileSession value, $Res Function(ProfileSession) then) =
      _$ProfileSessionCopyWithImpl<$Res, ProfileSession>;
  @useResult
  $Res call(
      {String token,
      @TimestampDateTimeSerializer() DateTime createdAt,
      bool valid});
}

/// @nodoc
class _$ProfileSessionCopyWithImpl<$Res, $Val extends ProfileSession>
    implements $ProfileSessionCopyWith<$Res> {
  _$ProfileSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? createdAt = null,
    Object? valid = null,
  }) {
    return _then(_value.copyWith(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      valid: null == valid
          ? _value.valid
          : valid // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProfileSessionImplCopyWith<$Res>
    implements $ProfileSessionCopyWith<$Res> {
  factory _$$ProfileSessionImplCopyWith(_$ProfileSessionImpl value,
          $Res Function(_$ProfileSessionImpl) then) =
      __$$ProfileSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String token,
      @TimestampDateTimeSerializer() DateTime createdAt,
      bool valid});
}

/// @nodoc
class __$$ProfileSessionImplCopyWithImpl<$Res>
    extends _$ProfileSessionCopyWithImpl<$Res, _$ProfileSessionImpl>
    implements _$$ProfileSessionImplCopyWith<$Res> {
  __$$ProfileSessionImplCopyWithImpl(
      _$ProfileSessionImpl _value, $Res Function(_$ProfileSessionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? createdAt = null,
    Object? valid = null,
  }) {
    return _then(_$ProfileSessionImpl(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      valid: null == valid
          ? _value.valid
          : valid // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileSessionImpl implements _ProfileSession {
  _$ProfileSessionImpl(
      {required this.token,
      @TimestampDateTimeSerializer() required this.createdAt,
      required this.valid});

  factory _$ProfileSessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileSessionImplFromJson(json);

  @override
  final String token;
  @override
  @TimestampDateTimeSerializer()
  final DateTime createdAt;
  @override
  final bool valid;

  @override
  String toString() {
    return 'ProfileSession(token: $token, createdAt: $createdAt, valid: $valid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileSessionImpl &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.valid, valid) || other.valid == valid));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, token, createdAt, valid);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileSessionImplCopyWith<_$ProfileSessionImpl> get copyWith =>
      __$$ProfileSessionImplCopyWithImpl<_$ProfileSessionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileSessionImplToJson(
      this,
    );
  }
}

abstract class _ProfileSession implements ProfileSession {
  factory _ProfileSession(
      {required final String token,
      @TimestampDateTimeSerializer() required final DateTime createdAt,
      required final bool valid}) = _$ProfileSessionImpl;

  factory _ProfileSession.fromJson(Map<String, dynamic> json) =
      _$ProfileSessionImpl.fromJson;

  @override
  String get token;
  @override
  @TimestampDateTimeSerializer()
  DateTime get createdAt;
  @override
  bool get valid;
  @override
  @JsonKey(ignore: true)
  _$$ProfileSessionImplCopyWith<_$ProfileSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
