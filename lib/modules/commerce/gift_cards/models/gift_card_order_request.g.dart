// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gift_card_order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GiftCardOrderRequestImpl _$$GiftCardOrderRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$GiftCardOrderRequestImpl(
      ref: const ModelRefSerializer().fromJson(json['ref'] as String),
      createdAt:
          const TimestampDateTimeSerializer().fromJson(json['createdAt']),
      updatedAt:
          const TimestampDateTimeSerializer().fromJson(json['updatedAt']),
      deletedAt: const NullableTimestampDateTimeSerializer()
          .fromJson(json['deletedAt']),
      amount: (json['amount'] as num?)?.toDouble(),
      status: $enumDecodeNullable(_$OrderStatusEnumMap, json['status']) ??
          OrderStatus.pending,
      profile: json['profile'] == null
          ? null
          : ProfileModel.fromJson(json['profile'] as Map<String, dynamic>),
      note: json['note'] as String?,
      shipping: json['shipping'] == null
          ? ShippingModel.empty
          : ShippingModel.fromJson(json['shipping'] as Map<String, dynamic>),
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$GiftCardOrderRequestImplToJson(
        _$GiftCardOrderRequestImpl instance) =>
    <String, dynamic>{
      'ref': const ModelRefSerializer().toJson(instance.ref),
      'createdAt': _$JsonConverterToJson<dynamic, DateTime>(
          instance.createdAt, const TimestampDateTimeSerializer().toJson),
      'updatedAt': _$JsonConverterToJson<dynamic, DateTime>(
          instance.updatedAt, const TimestampDateTimeSerializer().toJson),
      'deletedAt': const NullableTimestampDateTimeSerializer()
          .toJson(instance.deletedAt),
      'amount': instance.amount,
      'status': _$OrderStatusEnumMap[instance.status]!,
      'profile': instance.profile?.toJson(),
      'note': instance.note,
      'shipping': instance.shipping.toJson(),
      'metadata': instance.metadata,
    };

const _$OrderStatusEnumMap = {
  OrderStatus.pending: 'pending',
  OrderStatus.processing: 'processing',
  OrderStatus.completed: 'completed',
  OrderStatus.cancelled: 'cancelled',
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
