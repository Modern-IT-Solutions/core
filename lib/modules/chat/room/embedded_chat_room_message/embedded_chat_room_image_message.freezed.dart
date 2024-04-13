// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'embedded_chat_room_image_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EmbeddedChatRoomImageMessage _$EmbeddedChatRoomImageMessageFromJson(
    Map<String, dynamic> json) {
  return _EmbeddedChatRoomImageMessage.fromJson(json);
}

/// @nodoc
mixin _$EmbeddedChatRoomImageMessage {
  @ModelRefSerializer()
  ModelRef get profileRef => throw _privateConstructorUsedError;
  @TimestampDateTimeSerializer()
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  ChatRoomMessageType get type => throw _privateConstructorUsedError;
  String? get blurHash => throw _privateConstructorUsedError;
  double? get width => throw _privateConstructorUsedError;
  double? get height => throw _privateConstructorUsedError;
  int? get size => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EmbeddedChatRoomImageMessageCopyWith<EmbeddedChatRoomImageMessage>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmbeddedChatRoomImageMessageCopyWith<$Res> {
  factory $EmbeddedChatRoomImageMessageCopyWith(
          EmbeddedChatRoomImageMessage value,
          $Res Function(EmbeddedChatRoomImageMessage) then) =
      _$EmbeddedChatRoomImageMessageCopyWithImpl<$Res,
          EmbeddedChatRoomImageMessage>;
  @useResult
  $Res call(
      {@ModelRefSerializer() ModelRef profileRef,
      @TimestampDateTimeSerializer() DateTime createdAt,
      String imageUrl,
      ChatRoomMessageType type,
      String? blurHash,
      double? width,
      double? height,
      int? size});
}

/// @nodoc
class _$EmbeddedChatRoomImageMessageCopyWithImpl<$Res,
        $Val extends EmbeddedChatRoomImageMessage>
    implements $EmbeddedChatRoomImageMessageCopyWith<$Res> {
  _$EmbeddedChatRoomImageMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profileRef = null,
    Object? createdAt = null,
    Object? imageUrl = null,
    Object? type = null,
    Object? blurHash = freezed,
    Object? width = freezed,
    Object? height = freezed,
    Object? size = freezed,
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
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ChatRoomMessageType,
      blurHash: freezed == blurHash
          ? _value.blurHash
          : blurHash // ignore: cast_nullable_to_non_nullable
              as String?,
      width: freezed == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as double?,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double?,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EmbeddedChatRoomImageMessageImplCopyWith<$Res>
    implements $EmbeddedChatRoomImageMessageCopyWith<$Res> {
  factory _$$EmbeddedChatRoomImageMessageImplCopyWith(
          _$EmbeddedChatRoomImageMessageImpl value,
          $Res Function(_$EmbeddedChatRoomImageMessageImpl) then) =
      __$$EmbeddedChatRoomImageMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@ModelRefSerializer() ModelRef profileRef,
      @TimestampDateTimeSerializer() DateTime createdAt,
      String imageUrl,
      ChatRoomMessageType type,
      String? blurHash,
      double? width,
      double? height,
      int? size});
}

/// @nodoc
class __$$EmbeddedChatRoomImageMessageImplCopyWithImpl<$Res>
    extends _$EmbeddedChatRoomImageMessageCopyWithImpl<$Res,
        _$EmbeddedChatRoomImageMessageImpl>
    implements _$$EmbeddedChatRoomImageMessageImplCopyWith<$Res> {
  __$$EmbeddedChatRoomImageMessageImplCopyWithImpl(
      _$EmbeddedChatRoomImageMessageImpl _value,
      $Res Function(_$EmbeddedChatRoomImageMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profileRef = null,
    Object? createdAt = null,
    Object? imageUrl = null,
    Object? type = null,
    Object? blurHash = freezed,
    Object? width = freezed,
    Object? height = freezed,
    Object? size = freezed,
  }) {
    return _then(_$EmbeddedChatRoomImageMessageImpl(
      profileRef: null == profileRef
          ? _value.profileRef
          : profileRef // ignore: cast_nullable_to_non_nullable
              as ModelRef,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ChatRoomMessageType,
      blurHash: freezed == blurHash
          ? _value.blurHash
          : blurHash // ignore: cast_nullable_to_non_nullable
              as String?,
      width: freezed == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as double?,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double?,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EmbeddedChatRoomImageMessageImpl extends _EmbeddedChatRoomImageMessage {
  const _$EmbeddedChatRoomImageMessageImpl(
      {@ModelRefSerializer() required this.profileRef,
      @TimestampDateTimeSerializer() required this.createdAt,
      required this.imageUrl,
      this.type = ChatRoomMessageType.image,
      this.blurHash,
      this.width,
      this.height,
      this.size})
      : super._();

  factory _$EmbeddedChatRoomImageMessageImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$EmbeddedChatRoomImageMessageImplFromJson(json);

  @override
  @ModelRefSerializer()
  final ModelRef profileRef;
  @override
  @TimestampDateTimeSerializer()
  final DateTime createdAt;
  @override
  final String imageUrl;
  @override
  @JsonKey()
  final ChatRoomMessageType type;
  @override
  final String? blurHash;
  @override
  final double? width;
  @override
  final double? height;
  @override
  final int? size;

  @override
  String toString() {
    return 'EmbeddedChatRoomImageMessage(profileRef: $profileRef, createdAt: $createdAt, imageUrl: $imageUrl, type: $type, blurHash: $blurHash, width: $width, height: $height, size: $size)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmbeddedChatRoomImageMessageImpl &&
            (identical(other.profileRef, profileRef) ||
                other.profileRef == profileRef) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.blurHash, blurHash) ||
                other.blurHash == blurHash) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.size, size) || other.size == size));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, profileRef, createdAt, imageUrl,
      type, blurHash, width, height, size);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EmbeddedChatRoomImageMessageImplCopyWith<
          _$EmbeddedChatRoomImageMessageImpl>
      get copyWith => __$$EmbeddedChatRoomImageMessageImplCopyWithImpl<
          _$EmbeddedChatRoomImageMessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmbeddedChatRoomImageMessageImplToJson(
      this,
    );
  }
}

abstract class _EmbeddedChatRoomImageMessage
    extends EmbeddedChatRoomImageMessage {
  const factory _EmbeddedChatRoomImageMessage(
      {@ModelRefSerializer() required final ModelRef profileRef,
      @TimestampDateTimeSerializer() required final DateTime createdAt,
      required final String imageUrl,
      final ChatRoomMessageType type,
      final String? blurHash,
      final double? width,
      final double? height,
      final int? size}) = _$EmbeddedChatRoomImageMessageImpl;
  const _EmbeddedChatRoomImageMessage._() : super._();

  factory _EmbeddedChatRoomImageMessage.fromJson(Map<String, dynamic> json) =
      _$EmbeddedChatRoomImageMessageImpl.fromJson;

  @override
  @ModelRefSerializer()
  ModelRef get profileRef;
  @override
  @TimestampDateTimeSerializer()
  DateTime get createdAt;
  @override
  String get imageUrl;
  @override
  ChatRoomMessageType get type;
  @override
  String? get blurHash;
  @override
  double? get width;
  @override
  double? get height;
  @override
  int? get size;
  @override
  @JsonKey(ignore: true)
  _$$EmbeddedChatRoomImageMessageImplCopyWith<
          _$EmbeddedChatRoomImageMessageImpl>
      get copyWith => throw _privateConstructorUsedError;
}
