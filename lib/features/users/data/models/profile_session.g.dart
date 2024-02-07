// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileSessionImpl _$$ProfileSessionImplFromJson(Map<String, dynamic> json) =>
    _$ProfileSessionImpl(
      token: json['token'] as String,
      createdAt:
          const TimestampDateTimeSerializer().fromJson(json['createdAt']),
      valid: json['valid'] as bool,
    );

Map<String, dynamic> _$$ProfileSessionImplToJson(
        _$ProfileSessionImpl instance) =>
    <String, dynamic>{
      'token': instance.token,
      'createdAt':
          const TimestampDateTimeSerializer().toJson(instance.createdAt),
      'valid': instance.valid,
    };
