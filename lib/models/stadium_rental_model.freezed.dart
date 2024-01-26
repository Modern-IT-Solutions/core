// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stadium_rental_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

StadiumRentalModel _$StadiumRentalModelFromJson(Map<String, dynamic> json) {
  return _StadiumRentalModel.fromJson(json);
}

/// @nodoc
mixin _$StadiumRentalModel {
  @ModelRefSerializer()
  ModelRef get ref => throw _privateConstructorUsedError;
  StadiumModel get stadium => throw _privateConstructorUsedError;
  ProfileModel get client =>
      throw _privateConstructorUsedError; // the admin who created this rental
  ProfileModel get createdBy => throw _privateConstructorUsedError;
  StadiumRentalStatus get status => throw _privateConstructorUsedError;
  @TimestampDateTimeSerializer()
  @DurationSerializer()
  Map<DateTime, Duration> get rents => throw _privateConstructorUsedError;
  @TimestampDateTimeSerializer()
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;
  @TimestampDateTimeSerializer()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @TimestampDateTimeSerializer()
  DateTime get updatedAt => throw _privateConstructorUsedError;
  @NullableTimestampDateTimeSerializer()
  DateTime? get deletedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StadiumRentalModelCopyWith<StadiumRentalModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StadiumRentalModelCopyWith<$Res> {
  factory $StadiumRentalModelCopyWith(
          StadiumRentalModel value, $Res Function(StadiumRentalModel) then) =
      _$StadiumRentalModelCopyWithImpl<$Res, StadiumRentalModel>;
  @useResult
  $Res call(
      {@ModelRefSerializer() ModelRef ref,
      StadiumModel stadium,
      ProfileModel client,
      ProfileModel createdBy,
      StadiumRentalStatus status,
      @TimestampDateTimeSerializer()
      @DurationSerializer()
      Map<DateTime, Duration> rents,
      @TimestampDateTimeSerializer() Map<String, dynamic> metadata,
      @TimestampDateTimeSerializer() DateTime createdAt,
      @TimestampDateTimeSerializer() DateTime updatedAt,
      @NullableTimestampDateTimeSerializer() DateTime? deletedAt});

  $StadiumModelCopyWith<$Res> get stadium;
  $ProfileModelCopyWith<$Res> get client;
  $ProfileModelCopyWith<$Res> get createdBy;
}

/// @nodoc
class _$StadiumRentalModelCopyWithImpl<$Res, $Val extends StadiumRentalModel>
    implements $StadiumRentalModelCopyWith<$Res> {
  _$StadiumRentalModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ref = null,
    Object? stadium = null,
    Object? client = null,
    Object? createdBy = null,
    Object? status = null,
    Object? rents = null,
    Object? metadata = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
  }) {
    return _then(_value.copyWith(
      ref: null == ref
          ? _value.ref
          : ref // ignore: cast_nullable_to_non_nullable
              as ModelRef,
      stadium: null == stadium
          ? _value.stadium
          : stadium // ignore: cast_nullable_to_non_nullable
              as StadiumModel,
      client: null == client
          ? _value.client
          : client // ignore: cast_nullable_to_non_nullable
              as ProfileModel,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as ProfileModel,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as StadiumRentalStatus,
      rents: null == rents
          ? _value.rents
          : rents // ignore: cast_nullable_to_non_nullable
              as Map<DateTime, Duration>,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
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
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $StadiumModelCopyWith<$Res> get stadium {
    return $StadiumModelCopyWith<$Res>(_value.stadium, (value) {
      return _then(_value.copyWith(stadium: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ProfileModelCopyWith<$Res> get client {
    return $ProfileModelCopyWith<$Res>(_value.client, (value) {
      return _then(_value.copyWith(client: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ProfileModelCopyWith<$Res> get createdBy {
    return $ProfileModelCopyWith<$Res>(_value.createdBy, (value) {
      return _then(_value.copyWith(createdBy: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StadiumRentalModelImplCopyWith<$Res>
    implements $StadiumRentalModelCopyWith<$Res> {
  factory _$$StadiumRentalModelImplCopyWith(_$StadiumRentalModelImpl value,
          $Res Function(_$StadiumRentalModelImpl) then) =
      __$$StadiumRentalModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@ModelRefSerializer() ModelRef ref,
      StadiumModel stadium,
      ProfileModel client,
      ProfileModel createdBy,
      StadiumRentalStatus status,
      @TimestampDateTimeSerializer()
      @DurationSerializer()
      Map<DateTime, Duration> rents,
      @TimestampDateTimeSerializer() Map<String, dynamic> metadata,
      @TimestampDateTimeSerializer() DateTime createdAt,
      @TimestampDateTimeSerializer() DateTime updatedAt,
      @NullableTimestampDateTimeSerializer() DateTime? deletedAt});

  @override
  $StadiumModelCopyWith<$Res> get stadium;
  @override
  $ProfileModelCopyWith<$Res> get client;
  @override
  $ProfileModelCopyWith<$Res> get createdBy;
}

/// @nodoc
class __$$StadiumRentalModelImplCopyWithImpl<$Res>
    extends _$StadiumRentalModelCopyWithImpl<$Res, _$StadiumRentalModelImpl>
    implements _$$StadiumRentalModelImplCopyWith<$Res> {
  __$$StadiumRentalModelImplCopyWithImpl(_$StadiumRentalModelImpl _value,
      $Res Function(_$StadiumRentalModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ref = null,
    Object? stadium = null,
    Object? client = null,
    Object? createdBy = null,
    Object? status = null,
    Object? rents = null,
    Object? metadata = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
  }) {
    return _then(_$StadiumRentalModelImpl(
      ref: null == ref
          ? _value.ref
          : ref // ignore: cast_nullable_to_non_nullable
              as ModelRef,
      stadium: null == stadium
          ? _value.stadium
          : stadium // ignore: cast_nullable_to_non_nullable
              as StadiumModel,
      client: null == client
          ? _value.client
          : client // ignore: cast_nullable_to_non_nullable
              as ProfileModel,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as ProfileModel,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as StadiumRentalStatus,
      rents: null == rents
          ? _value._rents
          : rents // ignore: cast_nullable_to_non_nullable
              as Map<DateTime, Duration>,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StadiumRentalModelImpl implements _StadiumRentalModel {
  _$StadiumRentalModelImpl(
      {@ModelRefSerializer() required this.ref,
      required this.stadium,
      required this.client,
      required this.createdBy,
      required this.status,
      @TimestampDateTimeSerializer()
      @DurationSerializer()
      required final Map<DateTime, Duration> rents,
      @TimestampDateTimeSerializer()
      final Map<String, dynamic> metadata = const {},
      @TimestampDateTimeSerializer() required this.createdAt,
      @TimestampDateTimeSerializer() required this.updatedAt,
      @NullableTimestampDateTimeSerializer() this.deletedAt})
      : _rents = rents,
        _metadata = metadata;

  factory _$StadiumRentalModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$StadiumRentalModelImplFromJson(json);

  @override
  @ModelRefSerializer()
  final ModelRef ref;
  @override
  final StadiumModel stadium;
  @override
  final ProfileModel client;
// the admin who created this rental
  @override
  final ProfileModel createdBy;
  @override
  final StadiumRentalStatus status;
  final Map<DateTime, Duration> _rents;
  @override
  @TimestampDateTimeSerializer()
  @DurationSerializer()
  Map<DateTime, Duration> get rents {
    if (_rents is EqualUnmodifiableMapView) return _rents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_rents);
  }

  final Map<String, dynamic> _metadata;
  @override
  @JsonKey()
  @TimestampDateTimeSerializer()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  @TimestampDateTimeSerializer()
  final DateTime createdAt;
  @override
  @TimestampDateTimeSerializer()
  final DateTime updatedAt;
  @override
  @NullableTimestampDateTimeSerializer()
  final DateTime? deletedAt;

  @override
  String toString() {
    return 'StadiumRentalModel(ref: $ref, stadium: $stadium, client: $client, createdBy: $createdBy, status: $status, rents: $rents, metadata: $metadata, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StadiumRentalModelImpl &&
            (identical(other.ref, ref) || other.ref == ref) &&
            (identical(other.stadium, stadium) || other.stadium == stadium) &&
            (identical(other.client, client) || other.client == client) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._rents, _rents) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      ref,
      stadium,
      client,
      createdBy,
      status,
      const DeepCollectionEquality().hash(_rents),
      const DeepCollectionEquality().hash(_metadata),
      createdAt,
      updatedAt,
      deletedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StadiumRentalModelImplCopyWith<_$StadiumRentalModelImpl> get copyWith =>
      __$$StadiumRentalModelImplCopyWithImpl<_$StadiumRentalModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StadiumRentalModelImplToJson(
      this,
    );
  }
}

abstract class _StadiumRentalModel implements StadiumRentalModel {
  factory _StadiumRentalModel(
          {@ModelRefSerializer() required final ModelRef ref,
          required final StadiumModel stadium,
          required final ProfileModel client,
          required final ProfileModel createdBy,
          required final StadiumRentalStatus status,
          @TimestampDateTimeSerializer()
          @DurationSerializer()
          required final Map<DateTime, Duration> rents,
          @TimestampDateTimeSerializer() final Map<String, dynamic> metadata,
          @TimestampDateTimeSerializer() required final DateTime createdAt,
          @TimestampDateTimeSerializer() required final DateTime updatedAt,
          @NullableTimestampDateTimeSerializer() final DateTime? deletedAt}) =
      _$StadiumRentalModelImpl;

  factory _StadiumRentalModel.fromJson(Map<String, dynamic> json) =
      _$StadiumRentalModelImpl.fromJson;

  @override
  @ModelRefSerializer()
  ModelRef get ref;
  @override
  StadiumModel get stadium;
  @override
  ProfileModel get client;
  @override // the admin who created this rental
  ProfileModel get createdBy;
  @override
  StadiumRentalStatus get status;
  @override
  @TimestampDateTimeSerializer()
  @DurationSerializer()
  Map<DateTime, Duration> get rents;
  @override
  @TimestampDateTimeSerializer()
  Map<String, dynamic> get metadata;
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
  @JsonKey(ignore: true)
  _$$StadiumRentalModelImplCopyWith<_$StadiumRentalModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
