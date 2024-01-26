import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_room_model.freezed.dart';
part 'chat_room_model.g.dart';


@freezed
class ChatRoomModel with _$ChatRoomModel implements Model {

  factory ChatRoomModel({
    @ModelRefSerializer() required ModelRef ref,
    @TimestampDateTimeSerializer() required DateTime createdAt,
    @TimestampDateTimeSerializer() required DateTime updatedAt,
    @NullableTimestampDateTimeSerializer() DateTime? deletedAt,
    //
    List<ModelRef>? membersRefs,
    List<ModelRef>? adminsRefs,
    String? name,

  }) = _ChatRoomModel;

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) => _$ChatRoomModelFromJson(json);
}