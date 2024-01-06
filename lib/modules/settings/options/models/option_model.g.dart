// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OptionModelImpl _$$OptionModelImplFromJson(Map<String, dynamic> json) =>
    _$OptionModelImpl(
      ref: const ModelRefSerializer().fromJson(json['ref'] as String),
      createdAt:
          const TimestampDateTimeSerializer().fromJson(json['createdAt']),
      updatedAt:
          const TimestampDateTimeSerializer().fromJson(json['updatedAt']),
      deletedAt: const NullableTimestampDateTimeSerializer()
          .fromJson(json['deletedAt']),
      name: json['name'] as String?,
      details: json['details'] as String?,
      key: json['key'] as String,
      value: json['value'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$$OptionModelImplToJson(_$OptionModelImpl instance) =>
    <String, dynamic>{
      'ref': const ModelRefSerializer().toJson(instance.ref),
      'createdAt':
          const TimestampDateTimeSerializer().toJson(instance.createdAt),
      'updatedAt':
          const TimestampDateTimeSerializer().toJson(instance.updatedAt),
      'deletedAt': const NullableTimestampDateTimeSerializer()
          .toJson(instance.deletedAt),
      'name': instance.name,
      'details': instance.details,
      'key': instance.key,
      'value': instance.value,
      'type': instance.type,
    };
