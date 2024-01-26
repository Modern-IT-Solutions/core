// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatRoomModelImpl _$$ChatRoomModelImplFromJson(Map<String, dynamic> json) =>
    _$ChatRoomModelImpl(
      ref: const ModelRefSerializer().fromJson(json['ref'] as String),
      createdAt:
          const TimestampDateTimeSerializer().fromJson(json['createdAt']),
      updatedAt:
          const TimestampDateTimeSerializer().fromJson(json['updatedAt']),
      deletedAt: const NullableTimestampDateTimeSerializer()
          .fromJson(json['deletedAt']),
      membersRefs: (json['membersRefs'] as List<dynamic>?)
          ?.map(ModelRef.fromJson)
          .toList(),
      adminsRefs: (json['adminsRefs'] as List<dynamic>?)
          ?.map(ModelRef.fromJson)
          .toList(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$$ChatRoomModelImplToJson(_$ChatRoomModelImpl instance) =>
    <String, dynamic>{
      'ref': const ModelRefSerializer().toJson(instance.ref),
      'createdAt':
          const TimestampDateTimeSerializer().toJson(instance.createdAt),
      'updatedAt':
          const TimestampDateTimeSerializer().toJson(instance.updatedAt),
      'deletedAt': const NullableTimestampDateTimeSerializer()
          .toJson(instance.deletedAt),
      'membersRefs': instance.membersRefs?.map((e) => e.toJson()).toList(),
      'adminsRefs': instance.adminsRefs?.map((e) => e.toJson()).toList(),
      'name': instance.name,
    };
