// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stadium_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StadiumModelImpl _$$StadiumModelImplFromJson(Map<String, dynamic> json) =>
    _$StadiumModelImpl(
      ref: const ModelRefSerializer().fromJson(json['ref'] as String),
      name: json['name'] as String,
      photoUrl: json['photoUrl'] as String? ?? "",
      disabled: json['disabled'] as bool,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      createdAt:
          const TimestampDateTimeSerializer().fromJson(json['createdAt']),
      updatedAt:
          const TimestampDateTimeSerializer().fromJson(json['updatedAt']),
      deletedAt:
          const TimestampDateTimeSerializer().fromJson(json['deletedAt']),
    );

Map<String, dynamic> _$$StadiumModelImplToJson(_$StadiumModelImpl instance) =>
    <String, dynamic>{
      'ref': const ModelRefSerializer().toJson(instance.ref),
      'name': instance.name,
      'photoUrl': instance.photoUrl,
      'disabled': instance.disabled,
      'metadata': instance.metadata,
      'createdAt':
          const TimestampDateTimeSerializer().toJson(instance.createdAt),
      'updatedAt':
          const TimestampDateTimeSerializer().toJson(instance.updatedAt),
      'deletedAt': _$JsonConverterToJson<dynamic, DateTime>(
          instance.deletedAt, const TimestampDateTimeSerializer().toJson),
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
