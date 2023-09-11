// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intervention_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_InterventionModel _$$_InterventionModelFromJson(Map<String, dynamic> json) =>
    _$_InterventionModel(
      ref: const ModelRefSerializer().fromJson(json['ref'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
      status: $enumDecode(_$InterventionStatusEnumMap, json['status']),
      date: DateTime.parse(json['date'] as String),
      description: json['description'] as String,
      attachments: json['attachments'] as List<dynamic>,
      type: $enumDecode(_$InterventionTypeEnumMap, json['type']),
      intervener:
          ProfileModel.fromJson(json['intervener'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_InterventionModelToJson(
        _$_InterventionModel instance) =>
    <String, dynamic>{
      'ref': const ModelRefSerializer().toJson(instance.ref),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
      'status': _$InterventionStatusEnumMap[instance.status]!,
      'date': instance.date.toIso8601String(),
      'description': instance.description,
      'attachments': instance.attachments,
      'type': _$InterventionTypeEnumMap[instance.type]!,
      'intervener': instance.intervener.toJson(),
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
