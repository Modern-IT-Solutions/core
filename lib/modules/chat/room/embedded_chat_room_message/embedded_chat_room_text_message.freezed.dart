// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'embedded_chat_room_text_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EmbeddedChatRoomTextMessage _$EmbeddedChatRoomTextMessageFromJson(
    Map<String, dynamic> json) {
  return _EmbeddedChatRoomTextMessage.fromJson(json);
}

/// @nodoc
mixin _$EmbeddedChatRoomTextMessage {
  @ModelRefSerializer()
  ModelRef get profileRef => throw _privateConstructorUsedError;
  @TimestampDateTimeSerializer()
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  ChatRoomMessageType get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EmbeddedChatRoomTextMessageCopyWith<EmbeddedChatRoomTextMessage>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmbeddedChatRoomTextMessageCopyWith<$Res> {
  factory $EmbeddedChatRoomTextMessageCopyWith(
          EmbeddedChatRoomTextMessage value,
          $Res Function(EmbeddedChatRoomTextMessage) then) =
      _$EmbeddedChatRoomTextMessageCopyWithImpl<$Res,
          EmbeddedChatRoomTextMessage>;
  @useResult
  $Res call(
      {@ModelRefSerializer() ModelRef profileRef,
      @TimestampDateTimeSerializer() DateTime createdAt,
      String text,
      ChatRoomMessageType type});
}

/// @nodoc
class _$EmbeddedChatRoomTextMessageCopyWithImpl<$Res,
        $Val extends EmbeddedChatRoomTextMessage>
    implements $EmbeddedChatRoomTextMessageCopyWith<$Res> {
  _$EmbeddedChatRoomTextMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profileRef = null,
    Object? createdAt = null,
    Object? text = null,
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
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ChatRoomMessageType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EmbeddedChatRoomTextMessageImplCopyWith<$Res>
    implements $EmbeddedChatRoomTextMessageCopyWith<$Res> {
  factory _$$EmbeddedChatRoomTextMessageImplCopyWith(
          _$EmbeddedChatRoomTextMessageImpl value,
          $Res Function(_$EmbeddedChatRoomTextMessageImpl) then) =
      __$$EmbeddedChatRoomTextMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@ModelRefSerializer() ModelRef profileRef,
      @TimestampDateTimeSerializer() DateTime createdAt,
      String text,
      ChatRoomMessageType type});
}

/// @nodoc
class __$$EmbeddedChatRoomTextMessageImplCopyWithImpl<$Res>
    extends _$EmbeddedChatRoomTextMessageCopyWithImpl<$Res,
        _$EmbeddedChatRoomTextMessageImpl>
    implements _$$EmbeddedChatRoomTextMessageImplCopyWith<$Res> {
  __$$EmbeddedChatRoomTextMessageImplCopyWithImpl(
      _$EmbeddedChatRoomTextMessageImpl _value,
      $Res Function(_$EmbeddedChatRoomTextMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profileRef = null,
    Object? createdAt = null,
    Object? text = null,
    Object? type = null,
  }) {
    return _then(_$EmbeddedChatRoomTextMessageImpl(
      profileRef: null == profileRef
          ? _value.profileRef
          : profileRef // ignore: cast_nullable_to_non_nullable
              as ModelRef,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
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
class _$EmbeddedChatRoomTextMessageImpl extends _EmbeddedChatRoomTextMessage {
  const _$EmbeddedChatRoomTextMessageImpl(
      {@ModelRefSerializer() required this.profileRef,
      @TimestampDateTimeSerializer() required this.createdAt,
      required this.text,
      this.type = ChatRoomMessageType.text})
      : super._();

  factory _$EmbeddedChatRoomTextMessageImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$EmbeddedChatRoomTextMessageImplFromJson(json);

  @override
  @ModelRefSerializer()
  final ModelRef profileRef;
  @override
  @TimestampDateTimeSerializer()
  final DateTime createdAt;
  @override
  final String text;
  @override
  @JsonKey()
  final ChatRoomMessageType type;

  @override
  String toString() {
    return 'EmbeddedChatRoomTextMessage(profileRef: $profileRef, createdAt: $createdAt, text: $text, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmbeddedChatRoomTextMessageImpl &&
            (identical(other.profileRef, profileRef) ||
                other.profileRef == profileRef) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, profileRef, createdAt, text, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EmbeddedChatRoomTextMessageImplCopyWith<_$EmbeddedChatRoomTextMessageImpl>
      get copyWith => __$$EmbeddedChatRoomTextMessageImplCopyWithImpl<
          _$EmbeddedChatRoomTextMessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmbeddedChatRoomTextMessageImplToJson(
      this,
    );
  }
}

abstract class _EmbeddedChatRoomTextMessage
    extends EmbeddedChatRoomTextMessage {
  const factory _EmbeddedChatRoomTextMessage(
      {@ModelRefSerializer() required final ModelRef profileRef,
      @TimestampDateTimeSerializer() required final DateTime createdAt,
      required final String text,
      final ChatRoomMessageType type}) = _$EmbeddedChatRoomTextMessageImpl;
  const _EmbeddedChatRoomTextMessage._() : super._();

  factory _EmbeddedChatRoomTextMessage.fromJson(Map<String, dynamic> json) =
      _$EmbeddedChatRoomTextMessageImpl.fromJson;

  @override
  @ModelRefSerializer()
  ModelRef get profileRef;
  @override
  @TimestampDateTimeSerializer()
  DateTime get createdAt;
  @override
  String get text;
  @override
  ChatRoomMessageType get type;
  @override
  @JsonKey(ignore: true)
  _$$EmbeddedChatRoomTextMessageImplCopyWith<_$EmbeddedChatRoomTextMessageImpl>
      get copyWith => throw _privateConstructorUsedError;
}
