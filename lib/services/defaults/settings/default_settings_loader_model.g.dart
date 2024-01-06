// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'default_settings_loader_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SettingsLoaderModelImpl _$$SettingsLoaderModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SettingsLoaderModelImpl(
      ref: const ModelRefSerializer().fromJson(json['ref'] as String),
      createdAt:
          const TimestampDateTimeSerializer().fromJson(json['createdAt']),
      updatedAt:
          const TimestampDateTimeSerializer().fromJson(json['updatedAt']),
      deletedAt: const NullableTimestampDateTimeSerializer()
          .fromJson(json['deletedAt']),
    );

Map<String, dynamic> _$$SettingsLoaderModelImplToJson(
        _$SettingsLoaderModelImpl instance) =>
    <String, dynamic>{
      'ref': const ModelRefSerializer().toJson(instance.ref),
      'createdAt':
          const TimestampDateTimeSerializer().toJson(instance.createdAt),
      'updatedAt':
          const TimestampDateTimeSerializer().toJson(instance.updatedAt),
      'deletedAt': const NullableTimestampDateTimeSerializer()
          .toJson(instance.deletedAt),
    };
