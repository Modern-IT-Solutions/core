// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'embedded_chat_room_image_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmbeddedChatRoomImageMessageImpl _$$EmbeddedChatRoomImageMessageImplFromJson(
        Map<String, dynamic> json) =>
    _$EmbeddedChatRoomImageMessageImpl(
      profileRef:
          const ModelRefSerializer().fromJson(json['profileRef'] as String),
      createdAt:
          const TimestampDateTimeSerializer().fromJson(json['createdAt']),
      imageUrl: json['imageUrl'] as String,
      type: $enumDecodeNullable(_$ChatRoomMessageTypeEnumMap, json['type']) ??
          ChatRoomMessageType.image,
    );

Map<String, dynamic> _$$EmbeddedChatRoomImageMessageImplToJson(
        _$EmbeddedChatRoomImageMessageImpl instance) =>
    <String, dynamic>{
      'profileRef': const ModelRefSerializer().toJson(instance.profileRef),
      'createdAt':
          const TimestampDateTimeSerializer().toJson(instance.createdAt),
      'imageUrl': instance.imageUrl,
      'type': _$ChatRoomMessageTypeEnumMap[instance.type]!,
    };

const _$ChatRoomMessageTypeEnumMap = {
  ChatRoomMessageType.text: 'text',
  ChatRoomMessageType.image: 'image',
  ChatRoomMessageType.audio: 'audio',
  ChatRoomMessageType.video: 'video',
  ChatRoomMessageType.file: 'file',
};
