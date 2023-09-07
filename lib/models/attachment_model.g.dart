// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AttachmentModel _$$_AttachmentModelFromJson(Map<String, dynamic> json) =>
    _$_AttachmentModel(
      ref: const ModelRefSerializer().fromJson(json['ref'] as String),
      createdAt:
          const TimestampDateTimeSerializer().fromJson(json['createdAt']),
      updatedAt:
          const TimestampDateTimeSerializer().fromJson(json['updatedAt']),
      deletedAt:
          const TimestampDateTimeSerializer().fromJson(json['deletedAt']),
      name: json['name'] as String,
      type: json['type'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$$_AttachmentModelToJson(_$_AttachmentModel instance) =>
    <String, dynamic>{
      'ref': const ModelRefSerializer().toJson(instance.ref),
      'createdAt':
          const TimestampDateTimeSerializer().toJson(instance.createdAt),
      'updatedAt': _$JsonConverterToJson<dynamic, DateTime>(
          instance.updatedAt, const TimestampDateTimeSerializer().toJson),
      'deletedAt': _$JsonConverterToJson<dynamic, DateTime>(
          instance.deletedAt, const TimestampDateTimeSerializer().toJson),
      'name': instance.name,
      'type': instance.type,
      'url': instance.url,
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
