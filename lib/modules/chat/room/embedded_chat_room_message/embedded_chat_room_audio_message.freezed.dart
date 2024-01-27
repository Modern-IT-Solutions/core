// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'embedded_chat_room_audio_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

EmbeddedChatRoomAudioMessage _$EmbeddedChatRoomAudioMessageFromJson(
    Map<String, dynamic> json) {
  return _EmbeddedChatRoomAudioMessage.fromJson(json);
}

/// @nodoc
mixin _$EmbeddedChatRoomAudioMessage {
  @ModelRefSerializer()
  ModelRef get profileRef => throw _privateConstructorUsedError;
  @TimestampDateTimeSerializer()
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get audioUrl => throw _privateConstructorUsedError;
  ChatRoomMessageType get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EmbeddedChatRoomAudioMessageCopyWith<EmbeddedChatRoomAudioMessage>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmbeddedChatRoomAudioMessageCopyWith<$Res> {
  factory $EmbeddedChatRoomAudioMessageCopyWith(
          EmbeddedChatRoomAudioMessage value,
          $Res Function(EmbeddedChatRoomAudioMessage) then) =
      _$EmbeddedChatRoomAudioMessageCopyWithImpl<$Res,
          EmbeddedChatRoomAudioMessage>;
  @useResult
  $Res call(
      {@ModelRefSerializer() ModelRef profileRef,
      @TimestampDateTimeSerializer() DateTime createdAt,
      String audioUrl,
      ChatRoomMessageType type});
}

/// @nodoc
class _$EmbeddedChatRoomAudioMessageCopyWithImpl<$Res,
        $Val extends EmbeddedChatRoomAudioMessage>
    implements $EmbeddedChatRoomAudioMessageCopyWith<$Res> {
  _$EmbeddedChatRoomAudioMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profileRef = null,
    Object? createdAt = null,
    Object? audioUrl = null,
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
      audioUrl: null == audioUrl
          ? _value.audioUrl
          : audioUrl // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ChatRoomMessageType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EmbeddedChatRoomAudioMessageImplCopyWith<$Res>
    implements $EmbeddedChatRoomAudioMessageCopyWith<$Res> {
  factory _$$EmbeddedChatRoomAudioMessageImplCopyWith(
          _$EmbeddedChatRoomAudioMessageImpl value,
          $Res Function(_$EmbeddedChatRoomAudioMessageImpl) then) =
      __$$EmbeddedChatRoomAudioMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@ModelRefSerializer() ModelRef profileRef,
      @TimestampDateTimeSerializer() DateTime createdAt,
      String audioUrl,
      ChatRoomMessageType type});
}

/// @nodoc
class __$$EmbeddedChatRoomAudioMessageImplCopyWithImpl<$Res>
    extends _$EmbeddedChatRoomAudioMessageCopyWithImpl<$Res,
        _$EmbeddedChatRoomAudioMessageImpl>
    implements _$$EmbeddedChatRoomAudioMessageImplCopyWith<$Res> {
  __$$EmbeddedChatRoomAudioMessageImplCopyWithImpl(
      _$EmbeddedChatRoomAudioMessageImpl _value,
      $Res Function(_$EmbeddedChatRoomAudioMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profileRef = null,
    Object? createdAt = null,
    Object? audioUrl = null,
    Object? type = null,
  }) {
    return _then(_$EmbeddedChatRoomAudioMessageImpl(
      profileRef: null == profileRef
          ? _value.profileRef
          : profileRef // ignore: cast_nullable_to_non_nullable
              as ModelRef,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      audioUrl: null == audioUrl
          ? _value.audioUrl
          : audioUrl // ignore: cast_nullable_to_non_nullable
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
class _$EmbeddedChatRoomAudioMessageImpl extends _EmbeddedChatRoomAudioMessage {
  const _$EmbeddedChatRoomAudioMessageImpl(
      {@ModelRefSerializer() required this.profileRef,
      @TimestampDateTimeSerializer() required this.createdAt,
      required this.audioUrl,
      this.type = ChatRoomMessageType.audio})
      : super._();

  factory _$EmbeddedChatRoomAudioMessageImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$EmbeddedChatRoomAudioMessageImplFromJson(json);

  @override
  @ModelRefSerializer()
  final ModelRef profileRef;
  @override
  @TimestampDateTimeSerializer()
  final DateTime createdAt;
  @override
  final String audioUrl;
  @override
  @JsonKey()
  final ChatRoomMessageType type;

  @override
  String toString() {
    return 'EmbeddedChatRoomAudioMessage(profileRef: $profileRef, createdAt: $createdAt, audioUrl: $audioUrl, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmbeddedChatRoomAudioMessageImpl &&
            (identical(other.profileRef, profileRef) ||
                other.profileRef == profileRef) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.audioUrl, audioUrl) ||
                other.audioUrl == audioUrl) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, profileRef, createdAt, audioUrl, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EmbeddedChatRoomAudioMessageImplCopyWith<
          _$EmbeddedChatRoomAudioMessageImpl>
      get copyWith => __$$EmbeddedChatRoomAudioMessageImplCopyWithImpl<
          _$EmbeddedChatRoomAudioMessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmbeddedChatRoomAudioMessageImplToJson(
      this,
    );
  }
}

abstract class _EmbeddedChatRoomAudioMessage
    extends EmbeddedChatRoomAudioMessage {
  const factory _EmbeddedChatRoomAudioMessage(
      {@ModelRefSerializer() required final ModelRef profileRef,
      @TimestampDateTimeSerializer() required final DateTime createdAt,
      required final String audioUrl,
      final ChatRoomMessageType type}) = _$EmbeddedChatRoomAudioMessageImpl;
  const _EmbeddedChatRoomAudioMessage._() : super._();

  factory _EmbeddedChatRoomAudioMessage.fromJson(Map<String, dynamic> json) =
      _$EmbeddedChatRoomAudioMessageImpl.fromJson;

  @override
  @ModelRefSerializer()
  ModelRef get profileRef;
  @override
  @TimestampDateTimeSerializer()
  DateTime get createdAt;
  @override
  String get audioUrl;
  @override
  ChatRoomMessageType get type;
  @override
  @JsonKey(ignore: true)
  _$$EmbeddedChatRoomAudioMessageImplCopyWith<
          _$EmbeddedChatRoomAudioMessageImpl>
      get copyWith => throw _privateConstructorUsedError;
}
