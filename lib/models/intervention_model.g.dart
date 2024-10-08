// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intervention_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InterventionModelImpl _$$InterventionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$InterventionModelImpl(
      ref: const ModelRefSerializer().fromJson(json['ref'] as String),
      status: $enumDecode(_$InterventionStatusEnumMap, json['status']),
      date: DateTime.parse(json['date'] as String),
      description: json['description'] as String,
      attachments: json['attachments'] as List<dynamic>,
      type: $enumDecode(_$InterventionTypeEnumMap, json['type']),
      intervener:
          ProfileModel.fromJson(json['intervener'] as Map<String, dynamic>),
      createdAt:
          const TimestampDateTimeSerializer().fromJson(json['createdAt']),
      updatedAt:
          const TimestampDateTimeSerializer().fromJson(json['updatedAt']),
      deletedAt: const NullableTimestampDateTimeSerializer()
          .fromJson(json['deletedAt']),
    );

Map<String, dynamic> _$$InterventionModelImplToJson(
        _$InterventionModelImpl instance) =>
    <String, dynamic>{
      'ref': const ModelRefSerializer().toJson(instance.ref),
      'status': _$InterventionStatusEnumMap[instance.status]!,
      'date': instance.date.toIso8601String(),
      'description': instance.description,
      'attachments': instance.attachments,
      'type': _$InterventionTypeEnumMap[instance.type]!,
      'intervener': instance.intervener.toJson(),
      'createdAt':
          const TimestampDateTimeSerializer().toJson(instance.createdAt),
      'updatedAt':
          const TimestampDateTimeSerializer().toJson(instance.updatedAt),
      'deletedAt': const NullableTimestampDateTimeSerializer()
          .toJson(instance.deletedAt),
    };

const _$InterventionStatusEnumMap = {
  InterventionStatus.pending: 'pending',
  InterventionStatus.inProgress: 'inProgress',
  InterventionStatus.completed: 'completed',
  InterventionStatus.canceled: 'canceled',
};

const _$InterventionTypeEnumMap = {
  InterventionType.onSite: 'onSite',
  InterventionType.byPhone: 'byPhone',
};
