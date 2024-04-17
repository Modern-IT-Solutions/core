// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gift_card_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GiftCardOrderModelImpl _$$GiftCardOrderModelImplFromJson(
        Map<String, dynamic> json) =>
    _$GiftCardOrderModelImpl(
      ref: const ModelRefSerializer().fromJson(json['ref'] as String),
      createdAt:
          const TimestampDateTimeSerializer().fromJson(json['createdAt']),
      updatedAt:
          const TimestampDateTimeSerializer().fromJson(json['updatedAt']),
      deletedAt: const NullableTimestampDateTimeSerializer()
          .fromJson(json['deletedAt']),
      profile: json['profile'] == null
          ? null
          : ProfileModel.fromJson(json['profile'] as Map<String, dynamic>),
      shipping:
          ShippingModel.fromJson(json['shipping'] as Map<String, dynamic>),
      amount: (json['amount'] as num).toDouble(),
      status: $enumDecode(_$OrderStatusEnumMap, json['status']),
      note: json['note'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$GiftCardOrderModelImplToJson(
        _$GiftCardOrderModelImpl instance) =>
    <String, dynamic>{
      'ref': const ModelRefSerializer().toJson(instance.ref),
      'createdAt':
          const TimestampDateTimeSerializer().toJson(instance.createdAt),
      'updatedAt':
          const TimestampDateTimeSerializer().toJson(instance.updatedAt),
      'deletedAt': const NullableTimestampDateTimeSerializer()
          .toJson(instance.deletedAt),
      'profile': instance.profile?.toJson(),
      'shipping': instance.shipping.toJson(),
      'amount': instance.amount,
      'status': _$OrderStatusEnumMap[instance.status]!,
      'note': instance.note,
      'metadata': instance.metadata,
    };

const _$OrderStatusEnumMap = {
  OrderStatus.pending: 'pending',
  OrderStatus.processing: 'processing',
  OrderStatus.completed: 'completed',
  OrderStatus.cancelled: 'cancelled',
};
