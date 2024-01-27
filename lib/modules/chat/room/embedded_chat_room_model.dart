import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'embedded_chat_room_message/embedded_chat_room_message.dart';

export 'embedded_chat_room_message/embedded_chat_room_message.dart';

part 'embedded_chat_room_model.freezed.dart';
part 'embedded_chat_room_model.g.dart';

@freezed
class EmbeddedChatRoomModel with _$EmbeddedChatRoomModel implements Model {

  const factory EmbeddedChatRoomModel({
    @ModelRefSerializer() required ModelRef ref,
    @TimestampDateTimeSerializer() required DateTime createdAt,
    @TimestampDateTimeSerializer() required DateTime updatedAt,
    @NullableTimestampDateTimeSerializer() DateTime? deletedAt,
    //
    required List<ModelRef>? profilesRefs,
    required List<ProfileModel> profiles,
    @Default([]) List<EmbeddedChatRoomMessage> messages,
  }) = _EmbeddedChatRoomModel;

  // empty
  static final empty = EmbeddedChatRoomModel(
    ref: ModelRef.empty,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    deletedAt: null,
    profilesRefs: [],
    profiles: [],
    messages: [],
  );

  factory EmbeddedChatRoomModel.fromJson(Map<String, dynamic> json) => _$EmbeddedChatRoomModelFromJson(json);
}