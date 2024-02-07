// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReportModelImpl _$$ReportModelImplFromJson(Map<String, dynamic> json) =>
    _$ReportModelImpl(
      ref: const ModelRefSerializer().fromJson(json['ref'] as String),
      issue: json['issue'] as String,
      type: json['type'] as String,
      deviceInfo: json['deviceInfo'] as Map<String, dynamic>? ?? const {},
      packageInfo: json['packageInfo'] as Map<String, dynamic>? ?? const {},
      user: json['user'] as Map<String, dynamic>? ?? const {},
      createdAt:
          const TimestampDateTimeSerializer().fromJson(json['createdAt']),
    );

Map<String, dynamic> _$$ReportModelImplToJson(_$ReportModelImpl instance) =>
    <String, dynamic>{
      'ref': const ModelRefSerializer().toJson(instance.ref),
      'issue': instance.issue,
      'type': instance.type,
      'deviceInfo': instance.deviceInfo,
      'packageInfo': instance.packageInfo,
      'user': instance.user,
      'createdAt':
          const TimestampDateTimeSerializer().toJson(instance.createdAt),
    };
