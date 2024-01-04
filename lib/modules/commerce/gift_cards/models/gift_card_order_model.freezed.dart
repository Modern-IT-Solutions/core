// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gift_card_order_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GiftCardOrderModel _$GiftCardOrderModelFromJson(Map<String, dynamic> json) {
  return _GiftCardOrderModel.fromJson(json);
}

/// @nodoc
mixin _$GiftCardOrderModel {
  @ModelRefSerializer()
  ModelRef get ref => throw _privateConstructorUsedError;
  @TimestampDateTimeSerializer()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @TimestampDateTimeSerializer()
  DateTime get updatedAt => throw _privateConstructorUsedError;
  @NullableTimestampDateTimeSerializer()
  DateTime? get deletedAt => throw _privateConstructorUsedError;

  ///
  ProfileModel get profile => throw _privateConstructorUsedError;
  ShippingModel get shipping => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  OrderStatus get status =>
      throw _privateConstructorUsedError; // this general note for the order
  String? get note =>
      throw _privateConstructorUsedError; // metadata for the order
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GiftCardOrderModelCopyWith<GiftCardOrderModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GiftCardOrderModelCopyWith<$Res> {
  factory $GiftCardOrderModelCopyWith(
          GiftCardOrderModel value, $Res Function(GiftCardOrderModel) then) =
      _$GiftCardOrderModelCopyWithImpl<$Res, GiftCardOrderModel>;
  @useResult
  $Res call(
      {@ModelRefSerializer() ModelRef ref,
      @TimestampDateTimeSerializer() DateTime createdAt,
      @TimestampDateTimeSerializer() DateTime updatedAt,
      @NullableTimestampDateTimeSerializer() DateTime? deletedAt,
      ProfileModel profile,
      ShippingModel shipping,
      double amount,
      OrderStatus status,
      String? note,
      Map<String, dynamic> metadata});

  $ProfileModelCopyWith<$Res> get profile;
  $ShippingModelCopyWith<$Res> get shipping;
}

/// @nodoc
class _$GiftCardOrderModelCopyWithImpl<$Res, $Val extends GiftCardOrderModel>
    implements $GiftCardOrderModelCopyWith<$Res> {
  _$GiftCardOrderModelCopyWithImpl(this._value, this._then);

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
    Object? profile = null,
    Object? shipping = null,
    Object? amount = null,
    Object? status = null,
    Object? note = freezed,
    Object? metadata = null,
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
      profile: null == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as ProfileModel,
      shipping: null == shipping
          ? _value.shipping
          : shipping // ignore: cast_nullable_to_non_nullable
              as ShippingModel,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OrderStatus,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProfileModelCopyWith<$Res> get profile {
    return $ProfileModelCopyWith<$Res>(_value.profile, (value) {
      return _then(_value.copyWith(profile: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ShippingModelCopyWith<$Res> get shipping {
    return $ShippingModelCopyWith<$Res>(_value.shipping, (value) {
      return _then(_value.copyWith(shipping: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GiftCardOrderModelImplCopyWith<$Res>
    implements $GiftCardOrderModelCopyWith<$Res> {
  factory _$$GiftCardOrderModelImplCopyWith(_$GiftCardOrderModelImpl value,
          $Res Function(_$GiftCardOrderModelImpl) then) =
      __$$GiftCardOrderModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@ModelRefSerializer() ModelRef ref,
      @TimestampDateTimeSerializer() DateTime createdAt,
      @TimestampDateTimeSerializer() DateTime updatedAt,
      @NullableTimestampDateTimeSerializer() DateTime? deletedAt,
      ProfileModel profile,
      ShippingModel shipping,
      double amount,
      OrderStatus status,
      String? note,
      Map<String, dynamic> metadata});

  @override
  $ProfileModelCopyWith<$Res> get profile;
  @override
  $ShippingModelCopyWith<$Res> get shipping;
}

/// @nodoc
class __$$GiftCardOrderModelImplCopyWithImpl<$Res>
    extends _$GiftCardOrderModelCopyWithImpl<$Res, _$GiftCardOrderModelImpl>
    implements _$$GiftCardOrderModelImplCopyWith<$Res> {
  __$$GiftCardOrderModelImplCopyWithImpl(_$GiftCardOrderModelImpl _value,
      $Res Function(_$GiftCardOrderModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ref = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? profile = null,
    Object? shipping = null,
    Object? amount = null,
    Object? status = null,
    Object? note = freezed,
    Object? metadata = null,
  }) {
    return _then(_$GiftCardOrderModelImpl(
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
      profile: null == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as ProfileModel,
      shipping: null == shipping
          ? _value.shipping
          : shipping // ignore: cast_nullable_to_non_nullable
              as ShippingModel,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OrderStatus,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GiftCardOrderModelImpl implements _GiftCardOrderModel {
  _$GiftCardOrderModelImpl(
      {@ModelRefSerializer() required this.ref,
      @TimestampDateTimeSerializer() required this.createdAt,
      @TimestampDateTimeSerializer() required this.updatedAt,
      @NullableTimestampDateTimeSerializer() this.deletedAt,
      required this.profile,
      required this.shipping,
      required this.amount,
      required this.status,
      this.note,
      final Map<String, dynamic> metadata = const {}})
      : _metadata = metadata;

  factory _$GiftCardOrderModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GiftCardOrderModelImplFromJson(json);

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

  ///
  @override
  final ProfileModel profile;
  @override
  final ShippingModel shipping;
  @override
  final double amount;
  @override
  final OrderStatus status;
// this general note for the order
  @override
  final String? note;
// metadata for the order
  final Map<String, dynamic> _metadata;
// metadata for the order
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  String toString() {
    return 'GiftCardOrderModel(ref: $ref, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, profile: $profile, shipping: $shipping, amount: $amount, status: $status, note: $note, metadata: $metadata)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GiftCardOrderModelImpl &&
            (identical(other.ref, ref) || other.ref == ref) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.profile, profile) || other.profile == profile) &&
            (identical(other.shipping, shipping) ||
                other.shipping == shipping) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.note, note) || other.note == note) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      ref,
      createdAt,
      updatedAt,
      deletedAt,
      profile,
      shipping,
      amount,
      status,
      note,
      const DeepCollectionEquality().hash(_metadata));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GiftCardOrderModelImplCopyWith<_$GiftCardOrderModelImpl> get copyWith =>
      __$$GiftCardOrderModelImplCopyWithImpl<_$GiftCardOrderModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GiftCardOrderModelImplToJson(
      this,
    );
  }
}

abstract class _GiftCardOrderModel implements GiftCardOrderModel {
  factory _GiftCardOrderModel(
      {@ModelRefSerializer() required final ModelRef ref,
      @TimestampDateTimeSerializer() required final DateTime createdAt,
      @TimestampDateTimeSerializer() required final DateTime updatedAt,
      @NullableTimestampDateTimeSerializer() final DateTime? deletedAt,
      required final ProfileModel profile,
      required final ShippingModel shipping,
      required final double amount,
      required final OrderStatus status,
      final String? note,
      final Map<String, dynamic> metadata}) = _$GiftCardOrderModelImpl;

  factory _GiftCardOrderModel.fromJson(Map<String, dynamic> json) =
      _$GiftCardOrderModelImpl.fromJson;

  @override
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

  ///
  ProfileModel get profile;
  @override
  ShippingModel get shipping;
  @override
  double get amount;
  @override
  OrderStatus get status;
  @override // this general note for the order
  String? get note;
  @override // metadata for the order
  Map<String, dynamic> get metadata;
  @override
  @JsonKey(ignore: true)
  _$$GiftCardOrderModelImplCopyWith<_$GiftCardOrderModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
