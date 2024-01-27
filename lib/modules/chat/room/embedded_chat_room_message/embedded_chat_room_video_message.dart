import 'package:core/converters.dart';
import 'package:core/temp.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'embedded_chat_room_message.dart';

part 'embedded_chat_room_video_message.freezed.dart';
part 'embedded_chat_room_video_message.g.dart';

@freezed
class EmbeddedChatRoomVideoMessage with _$EmbeddedChatRoomVideoMessage implements EmbeddedChatRoomMessage,EmbeddedChatRoomFileMessage {
  
  const EmbeddedChatRoomVideoMessage._();

  const factory EmbeddedChatRoomVideoMessage({
    @ModelRefSerializer() required ModelRef profileRef,
    @TimestampDateTimeSerializer() required DateTime createdAt,
    required String videoUrl,
    @Default(ChatRoomMessageType.video) ChatRoomMessageType type,
    int? size,
    double? width,
    double? height,
  }) = _EmbeddedChatRoomVideoMessage;

  factory EmbeddedChatRoomVideoMessage.fromJson(Map<String, dynamic> json) => _$EmbeddedChatRoomVideoMessageFromJson(json);
}