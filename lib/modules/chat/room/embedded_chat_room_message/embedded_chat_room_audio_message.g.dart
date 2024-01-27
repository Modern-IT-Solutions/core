// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'embedded_chat_room_audio_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmbeddedChatRoomAudioMessageImpl _$$EmbeddedChatRoomAudioMessageImplFromJson(
        Map<String, dynamic> json) =>
    _$EmbeddedChatRoomAudioMessageImpl(
      profileRef:
          const ModelRefSerializer().fromJson(json['profileRef'] as String),
      createdAt:
          const TimestampDateTimeSerializer().fromJson(json['createdAt']),
      audioUrl: json['audioUrl'] as String,
      type: $enumDecodeNullable(_$ChatRoomMessageTypeEnumMap, json['type']) ??
          ChatRoomMessageType.audio,
      size: json['size'] as int?,
    );

Map<String, dynamic> _$$EmbeddedChatRoomAudioMessageImplToJson(
        _$EmbeddedChatRoomAudioMessageImpl instance) =>
    <String, dynamic>{
      'profileRef': const ModelRefSerializer().toJson(instance.profileRef),
      'createdAt':
          const TimestampDateTimeSerializer().toJson(instance.createdAt),
      'audioUrl': instance.audioUrl,
      'type': _$ChatRoomMessageTypeEnumMap[instance.type]!,
      'size': instance.size,
    };

const _$ChatRoomMessageTypeEnumMap = {
  ChatRoomMessageType.text: 'text',
  ChatRoomMessageType.image: 'image',
  ChatRoomMessageType.audio: 'audio',
  ChatRoomMessageType.video: 'video',
  ChatRoomMessageType.file: 'file',
};
