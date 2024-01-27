
import 'package:core/temp.dart';

import 'embedded_chat_room_audio_message.dart';
import 'embedded_chat_room_image_message.dart';
import 'embedded_chat_room_text_message.dart';
import 'embedded_chat_room_video_message.dart';

export 'embedded_chat_room_audio_message.dart';
export 'embedded_chat_room_image_message.dart';
export 'embedded_chat_room_text_message.dart';
export 'embedded_chat_room_video_message.dart';

enum ChatRoomMessageType {
  text,
  image,
  audio,
  video,
  file,
}


abstract class EmbeddedChatRoomMessage {
  ModelRef get profileRef;
  ChatRoomMessageType get type;
  DateTime get createdAt;

  // toJson
  Map<String, dynamic> toJson();
  // fromJson
  factory EmbeddedChatRoomMessage.fromJson(Map<String, dynamic> json) {
    switch (json['type']) {
      case 'text':
        return EmbeddedChatRoomTextMessage.fromJson(json);
      case 'image':
        return EmbeddedChatRoomImageMessage.fromJson(json);
      case 'audio':
        return EmbeddedChatRoomAudioMessage.fromJson(json);
      case 'video':
        return EmbeddedChatRoomVideoMessage.fromJson(json);
      default:
        throw Exception('Unknown EmbeddedChatRoomMessage type');
    }
  }
}