// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'embedded_chat_room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmbeddedChatRoomModelImpl _$$EmbeddedChatRoomModelImplFromJson(
        Map<String, dynamic> json) =>
    _$EmbeddedChatRoomModelImpl(
      ref: const ModelRefSerializer().fromJson(json['ref'] as String),
      createdAt:
          const TimestampDateTimeSerializer().fromJson(json['createdAt']),
      updatedAt:
          const TimestampDateTimeSerializer().fromJson(json['updatedAt']),
      deletedAt: const NullableTimestampDateTimeSerializer()
          .fromJson(json['deletedAt']),
      profilesRefs: (json['profilesRefs'] as List<dynamic>?)
          ?.map(ModelRef.fromJson)
          .toList(),
      profiles: (json['profiles'] as List<dynamic>)
          .map((e) => ProfileModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      messages: (json['messages'] as List<dynamic>?)
              ?.map((e) =>
                  EmbeddedChatRoomMessage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$EmbeddedChatRoomModelImplToJson(
        _$EmbeddedChatRoomModelImpl instance) =>
    <String, dynamic>{
      'ref': const ModelRefSerializer().toJson(instance.ref),
      'createdAt':
          const TimestampDateTimeSerializer().toJson(instance.createdAt),
      'updatedAt':
          const TimestampDateTimeSerializer().toJson(instance.updatedAt),
      'deletedAt': const NullableTimestampDateTimeSerializer()
          .toJson(instance.deletedAt),
      'profilesRefs': instance.profilesRefs?.map((e) => e.toJson()).toList(),
      'profiles': instance.profiles.map((e) => e.toJson()).toList(),
      'messages': instance.messages.map((e) => e.toJson()).toList(),
    };
