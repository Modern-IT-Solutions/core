// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gift_card_order_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GiftCardOrderRequest _$GiftCardOrderRequestFromJson(Map<String, dynamic> json) {
  return _GiftCardOrderRequest.fromJson(json);
}

/// @nodoc
mixin _$GiftCardOrderRequest {
  @ModelRefSerializer()
  ModelRef get ref => throw _privateConstructorUsedError;
  @TimestampDateTimeSerializer()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @TimestampDateTimeSerializer()
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @NullableTimestampDateTimeSerializer()
  DateTime? get deletedAt => throw _privateConstructorUsedError;

  ///
  double? get amount => throw _privateConstructorUsedError;
  OrderStatus get status => throw _privateConstructorUsedError;
  ProfileModel? get profile => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  ShippingModel get shipping => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GiftCardOrderRequestCopyWith<GiftCardOrderRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GiftCardOrderRequestCopyWith<$Res> {
  factory $GiftCardOrderRequestCopyWith(GiftCardOrderRequest value,
          $Res Function(GiftCardOrderRequest) then) =
      _$GiftCardOrderRequestCopyWithImpl<$Res, GiftCardOrderRequest>;
  @useResult
  $Res call(
      {@ModelRefSerializer() ModelRef ref,
      @TimestampDateTimeSerializer() DateTime? createdAt,
      @TimestampDateTimeSerializer() DateTime? updatedAt,
      @NullableTimestampDateTimeSerializer() DateTime? deletedAt,
      double? amount,
      OrderStatus status,
      ProfileModel? profile,
      String? note,
      ShippingModel shipping,
      Map<String, dynamic> metadata});

  $ProfileModelCopyWith<$Res>? get profile;
  $ShippingModelCopyWith<$Res> get shipping;
}

/// @nodoc
class _$GiftCardOrderRequestCopyWithImpl<$Res,
        $Val extends GiftCardOrderRequest>
    implements $GiftCardOrderRequestCopyWith<$Res> {
  _$GiftCardOrderRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ref = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
    Object? amount = freezed,
    Object? status = null,
    Object? profile = freezed,
    Object? note = freezed,
    Object? shipping = null,
    Object? metadata = null,
  }) {
    return _then(_value.copyWith(
      ref: null == ref
          ? _value.ref
          : ref // ignore: cast_nullable_to_non_nullable
              as ModelRef,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OrderStatus,
      profile: freezed == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as ProfileModel?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      shipping: null == shipping
          ? _value.shipping
          : shipping // ignore: cast_nullable_to_non_nullable
              as ShippingModel,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProfileModelCopyWith<$Res>? get profile {
    if (_value.profile == null) {
      return null;
    }

    return $ProfileModelCopyWith<$Res>(_value.profile!, (value) {
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
abstract class _$$GiftCardOrderRequestImplCopyWith<$Res>
    implements $GiftCardOrderRequestCopyWith<$Res> {
  factory _$$GiftCardOrderRequestImplCopyWith(_$GiftCardOrderRequestImpl value,
          $Res Function(_$GiftCardOrderRequestImpl) then) =
      __$$GiftCardOrderRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@ModelRefSerializer() ModelRef ref,
      @TimestampDateTimeSerializer() DateTime? createdAt,
      @TimestampDateTimeSerializer() DateTime? updatedAt,
      @NullableTimestampDateTimeSerializer() DateTime? deletedAt,
      double? amount,
      OrderStatus status,
      ProfileModel? profile,
      String? note,
      ShippingModel shipping,
      Map<String, dynamic> metadata});

  @override
  $ProfileModelCopyWith<$Res>? get profile;
  @override
  $ShippingModelCopyWith<$Res> get shipping;
}

/// @nodoc
class __$$GiftCardOrderRequestImplCopyWithImpl<$Res>
    extends _$GiftCardOrderRequestCopyWithImpl<$Res, _$GiftCardOrderRequestImpl>
    implements _$$GiftCardOrderRequestImplCopyWith<$Res> {
  __$$GiftCardOrderRequestImplCopyWithImpl(_$GiftCardOrderRequestImpl _value,
      $Res Function(_$GiftCardOrderRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ref = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
    Object? amount = freezed,
    Object? status = null,
    Object? profile = freezed,
    Object? note = freezed,
    Object? shipping = null,
    Object? metadata = null,
  }) {
    return _then(_$GiftCardOrderRequestImpl(
      ref: null == ref
          ? _value.ref
          : ref // ignore: cast_nullable_to_non_nullable
              as ModelRef,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OrderStatus,
      profile: freezed == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as ProfileModel?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      shipping: null == shipping
          ? _value.shipping
          : shipping // ignore: cast_nullable_to_non_nullable
              as ShippingModel,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GiftCardOrderRequestImpl implements _GiftCardOrderRequest {
  _$GiftCardOrderRequestImpl(
      {@ModelRefSerializer() required this.ref,
      @TimestampDateTimeSerializer() this.createdAt,
      @TimestampDateTimeSerializer() this.updatedAt,
      @NullableTimestampDateTimeSerializer() this.deletedAt,
      this.amount,
      this.status = OrderStatus.pending,
      this.profile,
      this.note,
      this.shipping = ShippingModel.empty,
      final Map<String, dynamic> metadata = const {}})
      : _metadata = metadata;

  factory _$GiftCardOrderRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$GiftCardOrderRequestImplFromJson(json);

  @override
  @ModelRefSerializer()
  final ModelRef ref;
  @override
  @TimestampDateTimeSerializer()
  final DateTime? createdAt;
  @override
  @TimestampDateTimeSerializer()
  final DateTime? updatedAt;
  @override
  @NullableTimestampDateTimeSerializer()
  final DateTime? deletedAt;

  ///
  @override
  final double? amount;
  @override
  @JsonKey()
  final OrderStatus status;
  @override
  final ProfileModel? profile;
  @override
  final String? note;
  @override
  @JsonKey()
  final ShippingModel shipping;
  final Map<String, dynamic> _metadata;
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  String toString() {
    return 'GiftCardOrderRequest(ref: $ref, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, amount: $amount, status: $status, profile: $profile, note: $note, shipping: $shipping, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GiftCardOrderRequestImpl &&
            (identical(other.ref, ref) || other.ref == ref) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.profile, profile) || other.profile == profile) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.shipping, shipping) ||
                other.shipping == shipping) &&
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
      amount,
      status,
      profile,
      note,
      shipping,
      const DeepCollectionEquality().hash(_metadata));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GiftCardOrderRequestImplCopyWith<_$GiftCardOrderRequestImpl>
      get copyWith =>
          __$$GiftCardOrderRequestImplCopyWithImpl<_$GiftCardOrderRequestImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GiftCardOrderRequestImplToJson(
      this,
    );
  }
}

abstract class _GiftCardOrderRequest implements GiftCardOrderRequest {
  factory _GiftCardOrderRequest(
      {@ModelRefSerializer() required final ModelRef ref,
      @TimestampDateTimeSerializer() final DateTime? createdAt,
      @TimestampDateTimeSerializer() final DateTime? updatedAt,
      @NullableTimestampDateTimeSerializer() final DateTime? deletedAt,
      final double? amount,
      final OrderStatus status,
      final ProfileModel? profile,
      final String? note,
      final ShippingModel shipping,
      final Map<String, dynamic> metadata}) = _$GiftCardOrderRequestImpl;

  factory _GiftCardOrderRequest.fromJson(Map<String, dynamic> json) =
      _$GiftCardOrderRequestImpl.fromJson;

  @override
  @ModelRefSerializer()
  ModelRef get ref;
  @override
  @TimestampDateTimeSerializer()
  DateTime? get createdAt;
  @override
  @TimestampDateTimeSerializer()
  DateTime? get updatedAt;
  @override
  @NullableTimestampDateTimeSerializer()
  DateTime? get deletedAt;
  @override

  ///
  double? get amount;
  @override
  OrderStatus get status;
  @override
  ProfileModel? get profile;
  @override
  String? get note;
  @override
  ShippingModel get shipping;
  @override
  Map<String, dynamic> get metadata;
  @override
  @JsonKey(ignore: true)
  _$$GiftCardOrderRequestImplCopyWith<_$GiftCardOrderRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
