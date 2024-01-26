// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'embedded_chat_room_text_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmbeddedChatRoomTextMessageImpl _$$EmbeddedChatRoomTextMessageImplFromJson(
        Map<String, dynamic> json) =>
    _$EmbeddedChatRoomTextMessageImpl(
      profileRef: json['profileRef'] as String,
      text: json['text'] as String,
      type: $enumDecodeNullable(_$ChatRoomMessageTypeEnumMap, json['type']) ??
          ChatRoomMessageType.text,
    );

Map<String, dynamic> _$$EmbeddedChatRoomTextMessageImplToJson(
        _$EmbeddedChatRoomTextMessageImpl instance) =>
    <String, dynamic>{
      'profileRef': instance.profileRef,
      'text': instance.text,
      'type': _$ChatRoomMessageTypeEnumMap[instance.type]!,
    };

const _$ChatRoomMessageTypeEnumMap = {
  ChatRoomMessageType.text: 'text',
  ChatRoomMessageType.image: 'image',
  ChatRoomMessageType.audio: 'audio',
};
