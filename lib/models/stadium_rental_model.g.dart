// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stadium_rental_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StadiumRentalModelImpl _$$StadiumRentalModelImplFromJson(
        Map<String, dynamic> json) =>
    _$StadiumRentalModelImpl(
      ref: const ModelRefSerializer().fromJson(json['ref'] as String),
      stadium: StadiumModel.fromJson(json['stadium'] as Map<String, dynamic>),
      client: ProfileModel.fromJson(json['client'] as Map<String, dynamic>),
      createdBy:
          ProfileModel.fromJson(json['createdBy'] as Map<String, dynamic>),
      status: $enumDecode(_$StadiumRentalStatusEnumMap, json['status']),
      rents: (json['rents'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            DateTime.parse(k), const DurationSerializer().fromJson(e as int)),
      ),
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      createdAt:
          const TimestampDateTimeSerializer().fromJson(json['createdAt']),
      updatedAt:
          const TimestampDateTimeSerializer().fromJson(json['updatedAt']),
      deletedAt: const NullableTimestampDateTimeSerializer()
          .fromJson(json['deletedAt'] as Timestamp?),
    );

Map<String, dynamic> _$$StadiumRentalModelImplToJson(
        _$StadiumRentalModelImpl instance) =>
    <String, dynamic>{
      'ref': const ModelRefSerializer().toJson(instance.ref),
      'stadium': instance.stadium.toJson(),
      'client': instance.client.toJson(),
      'createdBy': instance.createdBy.toJson(),
      'status': _$StadiumRentalStatusEnumMap[instance.status]!,
      'rents': instance.rents.map((k, e) =>
          MapEntry(k.toIso8601String(), const DurationSerializer().toJson(e))),
      'metadata': instance.metadata,
      'createdAt':
          const TimestampDateTimeSerializer().toJson(instance.createdAt),
      'updatedAt':
          const TimestampDateTimeSerializer().toJson(instance.updatedAt),
      'deletedAt': const NullableTimestampDateTimeSerializer()
          .toJson(instance.deletedAt),
    };

const _$StadiumRentalStatusEnumMap = {
  StadiumRentalStatus.paid: 'paid',
  StadiumRentalStatus.unpaid: 'unpaid',
  StadiumRentalStatus.halfPaid: 'halfPaid',
  StadiumRentalStatus.canceled: 'canceled',
  StadiumRentalStatus.expired: 'expired',
};
