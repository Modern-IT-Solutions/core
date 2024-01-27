import 'package:core/converters.dart';
import 'package:core/temp.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'embedded_chat_room_message.dart';

part 'embedded_chat_room_image_message.freezed.dart';
part 'embedded_chat_room_image_message.g.dart';

@freezed
class EmbeddedChatRoomImageMessage with _$EmbeddedChatRoomImageMessage implements EmbeddedChatRoomMessage {
  
  const EmbeddedChatRoomImageMessage._();

  const factory EmbeddedChatRoomImageMessage({
    @ModelRefSerializer() required ModelRef profileRef,
    @TimestampDateTimeSerializer() required DateTime createdAt,
    required String imageUrl,
    @Default(ChatRoomMessageType.image) ChatRoomMessageType type,
  }) = _EmbeddedChatRoomImageMessage;

  factory EmbeddedChatRoomImageMessage.fromJson(Map<String, dynamic> json) => _$EmbeddedChatRoomImageMessageFromJson(json);
}