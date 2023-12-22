// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationModelImpl _$$NotificationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationModelImpl(
      ref: const ModelRefSerializer().fromJson(json['ref'] as String),
      photoUrl: json['photoUrl'] as String?,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      body: json['body'] as String?,
      seen: json['seen'] as bool? ?? false,
      profile: ProfileModel.fromJson(json['profile'] as Map<String, dynamic>),
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      createdAt:
          const TimestampDateTimeSerializer().fromJson(json['createdAt']),
      updatedAt:
          const TimestampDateTimeSerializer().fromJson(json['updatedAt']),
      deletedAt: const NullableTimestampDateTimeSerializer()
          .fromJson(json['deletedAt']),
    );

Map<String, dynamic> _$$NotificationModelImplToJson(
        _$NotificationModelImpl instance) =>
    <String, dynamic>{
      'ref': const ModelRefSerializer().toJson(instance.ref),
      'photoUrl': instance.photoUrl,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'body': instance.body,
      'seen': instance.seen,
      'profile': instance.profile.toJson(),
      'metadata': instance.metadata,
      'createdAt':
          const TimestampDateTimeSerializer().toJson(instance.createdAt),
      'updatedAt':
          const TimestampDateTimeSerializer().toJson(instance.updatedAt),
      'deletedAt': const NullableTimestampDateTimeSerializer()
          .toJson(instance.deletedAt),
    };
