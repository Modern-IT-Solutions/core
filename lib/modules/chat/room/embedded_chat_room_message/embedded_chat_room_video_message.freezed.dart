// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'embedded_chat_room_video_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

EmbeddedChatRoomVideoMessage _$EmbeddedChatRoomVideoMessageFromJson(
    Map<String, dynamic> json) {
  return _EmbeddedChatRoomVideoMessage.fromJson(json);
}

/// @nodoc
mixin _$EmbeddedChatRoomVideoMessage {
  @ModelRefSerializer()
  ModelRef get profileRef => throw _privateConstructorUsedError;
  @TimestampDateTimeSerializer()
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get videoUrl => throw _privateConstructorUsedError;
  ChatRoomMessageType get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EmbeddedChatRoomVideoMessageCopyWith<EmbeddedChatRoomVideoMessage>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmbeddedChatRoomVideoMessageCopyWith<$Res> {
  factory $EmbeddedChatRoomVideoMessageCopyWith(
          EmbeddedChatRoomVideoMessage value,
          $Res Function(EmbeddedChatRoomVideoMessage) then) =
      _$EmbeddedChatRoomVideoMessageCopyWithImpl<$Res,
          EmbeddedChatRoomVideoMessage>;
  @useResult
  $Res call(
      {@ModelRefSerializer() ModelRef profileRef,
      @TimestampDateTimeSerializer() DateTime createdAt,
      String videoUrl,
      ChatRoomMessageType type});
}

/// @nodoc
class _$EmbeddedChatRoomVideoMessageCopyWithImpl<$Res,
        $Val extends EmbeddedChatRoomVideoMessage>
    implements $EmbeddedChatRoomVideoMessageCopyWith<$Res> {
  _$EmbeddedChatRoomVideoMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profileRef = null,
    Object? createdAt = null,
    Object? videoUrl = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      profileRef: null == profileRef
          ? _value.profileRef
          : profileRef // ignore: cast_nullable_to_non_nullable
              as ModelRef,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      videoUrl: null == videoUrl
          ? _value.videoUrl
          : videoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ChatRoomMessageType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EmbeddedChatRoomVideoMessageImplCopyWith<$Res>
    implements $EmbeddedChatRoomVideoMessageCopyWith<$Res> {
  factory _$$EmbeddedChatRoomVideoMessageImplCopyWith(
          _$EmbeddedChatRoomVideoMessageImpl value,
          $Res Function(_$EmbeddedChatRoomVideoMessageImpl) then) =
      __$$EmbeddedChatRoomVideoMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@ModelRefSerializer() ModelRef profileRef,
      @TimestampDateTimeSerializer() DateTime createdAt,
      String videoUrl,
      ChatRoomMessageType type});
}

/// @nodoc
class __$$EmbeddedChatRoomVideoMessageImplCopyWithImpl<$Res>
    extends _$EmbeddedChatRoomVideoMessageCopyWithImpl<$Res,
        _$EmbeddedChatRoomVideoMessageImpl>
    implements _$$EmbeddedChatRoomVideoMessageImplCopyWith<$Res> {
  __$$EmbeddedChatRoomVideoMessageImplCopyWithImpl(
      _$EmbeddedChatRoomVideoMessageImpl _value,
      $Res Function(_$EmbeddedChatRoomVideoMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profileRef = null,
    Object? createdAt = null,
    Object? videoUrl = null,
    Object? type = null,
  }) {
    return _then(_$EmbeddedChatRoomVideoMessageImpl(
      profileRef: null == profileRef
          ? _value.profileRef
          : profileRef // ignore: cast_nullable_to_non_nullable
              as ModelRef,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      videoUrl: null == videoUrl
          ? _value.videoUrl
          : videoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ChatRoomMessageType,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EmbeddedChatRoomVideoMessageImpl extends _EmbeddedChatRoomVideoMessage {
  const _$EmbeddedChatRoomVideoMessageImpl(
      {@ModelRefSerializer() required this.profileRef,
      @TimestampDateTimeSerializer() required this.createdAt,
      required this.videoUrl,
      this.type = ChatRoomMessageType.video})
      : super._();

  factory _$EmbeddedChatRoomVideoMessageImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$EmbeddedChatRoomVideoMessageImplFromJson(json);

  @override
  @ModelRefSerializer()
  final ModelRef profileRef;
  @override
  @TimestampDateTimeSerializer()
  final DateTime createdAt;
  @override
  final String videoUrl;
  @override
  @JsonKey()
  final ChatRoomMessageType type;

  @override
  String toString() {
    return 'EmbeddedChatRoomVideoMessage(profileRef: $profileRef, createdAt: $createdAt, videoUrl: $videoUrl, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmbeddedChatRoomVideoMessageImpl &&
            (identical(other.profileRef, profileRef) ||
                other.profileRef == profileRef) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.videoUrl, videoUrl) ||
                other.videoUrl == videoUrl) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, profileRef, createdAt, videoUrl, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EmbeddedChatRoomVideoMessageImplCopyWith<
          _$EmbeddedChatRoomVideoMessageImpl>
      get copyWith => __$$EmbeddedChatRoomVideoMessageImplCopyWithImpl<
          _$EmbeddedChatRoomVideoMessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmbeddedChatRoomVideoMessageImplToJson(
      this,
    );
  }
}

abstract class _EmbeddedChatRoomVideoMessage
    extends EmbeddedChatRoomVideoMessage {
  const factory _EmbeddedChatRoomVideoMessage(
      {@ModelRefSerializer() required final ModelRef profileRef,
      @TimestampDateTimeSerializer() required final DateTime createdAt,
      required final String videoUrl,
      final ChatRoomMessageType type}) = _$EmbeddedChatRoomVideoMessageImpl;
  const _EmbeddedChatRoomVideoMessage._() : super._();

  factory _EmbeddedChatRoomVideoMessage.fromJson(Map<String, dynamic> json) =
      _$EmbeddedChatRoomVideoMessageImpl.fromJson;

  @override
  @ModelRefSerializer()
  ModelRef get profileRef;
  @override
  @TimestampDateTimeSerializer()
  DateTime get createdAt;
  @override
  String get videoUrl;
  @override
  ChatRoomMessageType get type;
  @override
  @JsonKey(ignore: true)
  _$$EmbeddedChatRoomVideoMessageImplCopyWith<
          _$EmbeddedChatRoomVideoMessageImpl>
      get copyWith => throw _privateConstructorUsedError;
}
