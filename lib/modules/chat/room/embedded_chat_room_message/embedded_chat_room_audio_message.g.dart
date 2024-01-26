// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'embedded_chat_room_audio_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmbeddedChatRoomAudioMessageImpl _$$EmbeddedChatRoomAudioMessageImplFromJson(
        Map<String, dynamic> json) =>
    _$EmbeddedChatRoomAudioMessageImpl(
      profileRef: json['profileRef'] as String,
      audioUrl: json['audioUrl'] as String,
      type: $enumDecodeNullable(_$ChatRoomMessageTypeEnumMap, json['type']) ??
          ChatRoomMessageType.audio,
    );

Map<String, dynamic> _$$EmbeddedChatRoomAudioMessageImplToJson(
        _$EmbeddedChatRoomAudioMessageImpl instance) =>
    <String, dynamic>{
      'profileRef': instance.profileRef,
      'audioUrl': instance.audioUrl,
      'type': _$ChatRoomMessageTypeEnumMap[instance.type]!,
    };

const _$ChatRoomMessageTypeEnumMap = {
  ChatRoomMessageType.text: 'text',
  ChatRoomMessageType.image: 'image',
  ChatRoomMessageType.audio: 'audio',
};
