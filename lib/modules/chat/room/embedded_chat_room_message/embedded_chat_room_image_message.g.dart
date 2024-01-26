// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'embedded_chat_room_image_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmbeddedChatRoomImageMessageImpl _$$EmbeddedChatRoomImageMessageImplFromJson(
        Map<String, dynamic> json) =>
    _$EmbeddedChatRoomImageMessageImpl(
      profileRef: json['profileRef'] as String,
      imageUrl: json['imageUrl'] as String,
      type: $enumDecodeNullable(_$ChatRoomMessageTypeEnumMap, json['type']) ??
          ChatRoomMessageType.text,
    );

Map<String, dynamic> _$$EmbeddedChatRoomImageMessageImplToJson(
        _$EmbeddedChatRoomImageMessageImpl instance) =>
    <String, dynamic>{
      'profileRef': instance.profileRef,
      'imageUrl': instance.imageUrl,
      'type': _$ChatRoomMessageTypeEnumMap[instance.type]!,
    };

const _$ChatRoomMessageTypeEnumMap = {
  ChatRoomMessageType.text: 'text',
  ChatRoomMessageType.image: 'image',
  ChatRoomMessageType.audio: 'audio',
};
