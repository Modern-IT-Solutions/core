// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'embedded_chat_room_video_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmbeddedChatRoomVideoMessageImpl _$$EmbeddedChatRoomVideoMessageImplFromJson(
        Map<String, dynamic> json) =>
    _$EmbeddedChatRoomVideoMessageImpl(
      profileRef:
          const ModelRefSerializer().fromJson(json['profileRef'] as String),
      createdAt:
          const TimestampDateTimeSerializer().fromJson(json['createdAt']),
      videoUrl: json['videoUrl'] as String,
      type: $enumDecodeNullable(_$ChatRoomMessageTypeEnumMap, json['type']) ??
          ChatRoomMessageType.video,
    );

Map<String, dynamic> _$$EmbeddedChatRoomVideoMessageImplToJson(
        _$EmbeddedChatRoomVideoMessageImpl instance) =>
    <String, dynamic>{
      'profileRef': const ModelRefSerializer().toJson(instance.profileRef),
      'createdAt':
          const TimestampDateTimeSerializer().toJson(instance.createdAt),
      'videoUrl': instance.videoUrl,
      'type': _$ChatRoomMessageTypeEnumMap[instance.type]!,
    };

const _$ChatRoomMessageTypeEnumMap = {
  ChatRoomMessageType.text: 'text',
  ChatRoomMessageType.image: 'image',
  ChatRoomMessageType.audio: 'audio',
  ChatRoomMessageType.video: 'video',
  ChatRoomMessageType.file: 'file',
};
