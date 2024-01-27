// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'embedded_chat_room_text_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmbeddedChatRoomTextMessageImpl _$$EmbeddedChatRoomTextMessageImplFromJson(
        Map<String, dynamic> json) =>
    _$EmbeddedChatRoomTextMessageImpl(
      profileRef:
          const ModelRefSerializer().fromJson(json['profileRef'] as String),
      createdAt:
          const TimestampDateTimeSerializer().fromJson(json['createdAt']),
      text: json['text'] as String,
      type: $enumDecodeNullable(_$ChatRoomMessageTypeEnumMap, json['type']) ??
          ChatRoomMessageType.text,
    );

Map<String, dynamic> _$$EmbeddedChatRoomTextMessageImplToJson(
        _$EmbeddedChatRoomTextMessageImpl instance) =>
    <String, dynamic>{
      'profileRef': const ModelRefSerializer().toJson(instance.profileRef),
      'createdAt':
          const TimestampDateTimeSerializer().toJson(instance.createdAt),
      'text': instance.text,
      'type': _$ChatRoomMessageTypeEnumMap[instance.type]!,
    };

const _$ChatRoomMessageTypeEnumMap = {
  ChatRoomMessageType.text: 'text',
  ChatRoomMessageType.image: 'image',
  ChatRoomMessageType.audio: 'audio',
  ChatRoomMessageType.video: 'video',
  ChatRoomMessageType.file: 'file',
};
