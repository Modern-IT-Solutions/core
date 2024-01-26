import 'package:freezed_annotation/freezed_annotation.dart';

import 'embedded_chat_room_message.dart';

part 'embedded_chat_room_audio_message.freezed.dart';
part 'embedded_chat_room_audio_message.g.dart';

@freezed
class EmbeddedChatRoomAudioMessage with _$EmbeddedChatRoomAudioMessage implements EmbeddedChatRoomMessage {
  
  const EmbeddedChatRoomAudioMessage._();

  const factory EmbeddedChatRoomAudioMessage({
    required String profileRef,
    required String audioUrl,
    @Default(ChatRoomMessageType.audio) ChatRoomMessageType type,
  }) = _EmbeddedChatRoomAudioMessage;

  factory EmbeddedChatRoomAudioMessage.fromJson(Map<String, dynamic> json) => _$EmbeddedChatRoomAudioMessageFromJson(json);
}