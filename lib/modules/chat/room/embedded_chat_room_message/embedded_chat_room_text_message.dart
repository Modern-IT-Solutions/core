import 'package:freezed_annotation/freezed_annotation.dart';

import 'embedded_chat_room_message.dart';

part 'embedded_chat_room_text_message.freezed.dart';
part 'embedded_chat_room_text_message.g.dart';

@freezed
class EmbeddedChatRoomTextMessage with _$EmbeddedChatRoomTextMessage implements EmbeddedChatRoomMessage {
  
  const EmbeddedChatRoomTextMessage._();

  const factory EmbeddedChatRoomTextMessage({
    required String profileRef,
    required String text,
    @Default(ChatRoomMessageType.text) ChatRoomMessageType type,
  }) = _EmbeddedChatRoomTextMessage;

  factory EmbeddedChatRoomTextMessage.fromJson(Map<String, dynamic> json) => _$EmbeddedChatRoomTextMessageFromJson(json);
}