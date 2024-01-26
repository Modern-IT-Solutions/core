// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'embedded_chat_room_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

EmbeddedChatRoomModel _$EmbeddedChatRoomModelFromJson(
    Map<String, dynamic> json) {
  return _EmbeddedChatRoomModel.fromJson(json);
}

/// @nodoc
mixin _$EmbeddedChatRoomModel {
  @ModelRefSerializer()
  ModelRef get ref => throw _privateConstructorUsedError;
  @TimestampDateTimeSerializer()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @TimestampDateTimeSerializer()
  DateTime get updatedAt => throw _privateConstructorUsedError;
  @NullableTimestampDateTimeSerializer()
  DateTime? get deletedAt => throw _privateConstructorUsedError; //
  List<ModelRef>? get profilesRefs => throw _privateConstructorUsedError;
  List<ProfileModel> get profiles => throw _privateConstructorUsedError;
  List<EmbeddedChatRoomMessage> get messages =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EmbeddedChatRoomModelCopyWith<EmbeddedChatRoomModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmbeddedChatRoomModelCopyWith<$Res> {
  factory $EmbeddedChatRoomModelCopyWith(EmbeddedChatRoomModel value,
          $Res Function(EmbeddedChatRoomModel) then) =
      _$EmbeddedChatRoomModelCopyWithImpl<$Res, EmbeddedChatRoomModel>;
  @useResult
  $Res call(
      {@ModelRefSerializer() ModelRef ref,
      @TimestampDateTimeSerializer() DateTime createdAt,
      @TimestampDateTimeSerializer() DateTime updatedAt,
      @NullableTimestampDateTimeSerializer() DateTime? deletedAt,
      List<ModelRef>? profilesRefs,
      List<ProfileModel> profiles,
      List<EmbeddedChatRoomMessage> messages});
}

/// @nodoc
class _$EmbeddedChatRoomModelCopyWithImpl<$Res,
        $Val extends EmbeddedChatRoomModel>
    implements $EmbeddedChatRoomModelCopyWith<$Res> {
  _$EmbeddedChatRoomModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ref = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? profilesRefs = freezed,
    Object? profiles = null,
    Object? messages = null,
  }) {
    return _then(_value.copyWith(
      ref: null == ref
          ? _value.ref
          : ref // ignore: cast_nullable_to_non_nullable
              as ModelRef,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      profilesRefs: freezed == profilesRefs
          ? _value.profilesRefs
          : profilesRefs // ignore: cast_nullable_to_non_nullable
              as List<ModelRef>?,
      profiles: null == profiles
          ? _value.profiles
          : profiles // ignore: cast_nullable_to_non_nullable
              as List<ProfileModel>,
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<EmbeddedChatRoomMessage>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EmbeddedChatRoomModelImplCopyWith<$Res>
    implements $EmbeddedChatRoomModelCopyWith<$Res> {
  factory _$$EmbeddedChatRoomModelImplCopyWith(
          _$EmbeddedChatRoomModelImpl value,
          $Res Function(_$EmbeddedChatRoomModelImpl) then) =
      __$$EmbeddedChatRoomModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@ModelRefSerializer() ModelRef ref,
      @TimestampDateTimeSerializer() DateTime createdAt,
      @TimestampDateTimeSerializer() DateTime updatedAt,
      @NullableTimestampDateTimeSerializer() DateTime? deletedAt,
      List<ModelRef>? profilesRefs,
      List<ProfileModel> profiles,
      List<EmbeddedChatRoomMessage> messages});
}

/// @nodoc
class __$$EmbeddedChatRoomModelImplCopyWithImpl<$Res>
    extends _$EmbeddedChatRoomModelCopyWithImpl<$Res,
        _$EmbeddedChatRoomModelImpl>
    implements _$$EmbeddedChatRoomModelImplCopyWith<$Res> {
  __$$EmbeddedChatRoomModelImplCopyWithImpl(_$EmbeddedChatRoomModelImpl _value,
      $Res Function(_$EmbeddedChatRoomModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ref = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? profilesRefs = freezed,
    Object? profiles = null,
    Object? messages = null,
  }) {
    return _then(_$EmbeddedChatRoomModelImpl(
      ref: null == ref
          ? _value.ref
          : ref // ignore: cast_nullable_to_non_nullable
              as ModelRef,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      profilesRefs: freezed == profilesRefs
          ? _value._profilesRefs
          : profilesRefs // ignore: cast_nullable_to_non_nullable
              as List<ModelRef>?,
      profiles: null == profiles
          ? _value._profiles
          : profiles // ignore: cast_nullable_to_non_nullable
              as List<ProfileModel>,
      messages: null == messages
          ? _value._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<EmbeddedChatRoomMessage>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EmbeddedChatRoomModelImpl implements _EmbeddedChatRoomModel {
  const _$EmbeddedChatRoomModelImpl(
      {@ModelRefSerializer() required this.ref,
      @TimestampDateTimeSerializer() required this.createdAt,
      @TimestampDateTimeSerializer() required this.updatedAt,
      @NullableTimestampDateTimeSerializer() this.deletedAt,
      required final List<ModelRef>? profilesRefs,
      required final List<ProfileModel> profiles,
      final List<EmbeddedChatRoomMessage> messages = const []})
      : _profilesRefs = profilesRefs,
        _profiles = profiles,
        _messages = messages;

  factory _$EmbeddedChatRoomModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmbeddedChatRoomModelImplFromJson(json);

  @override
  @ModelRefSerializer()
  final ModelRef ref;
  @override
  @TimestampDateTimeSerializer()
  final DateTime createdAt;
  @override
  @TimestampDateTimeSerializer()
  final DateTime updatedAt;
  @override
  @NullableTimestampDateTimeSerializer()
  final DateTime? deletedAt;
//
  final List<ModelRef>? _profilesRefs;
//
  @override
  List<ModelRef>? get profilesRefs {
    final value = _profilesRefs;
    if (value == null) return null;
    if (_profilesRefs is EqualUnmodifiableListView) return _profilesRefs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ProfileModel> _profiles;
  @override
  List<ProfileModel> get profiles {
    if (_profiles is EqualUnmodifiableListView) return _profiles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_profiles);
  }

  final List<EmbeddedChatRoomMessage> _messages;
  @override
  @JsonKey()
  List<EmbeddedChatRoomMessage> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  String toString() {
    return 'EmbeddedChatRoomModel(ref: $ref, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, profilesRefs: $profilesRefs, profiles: $profiles, messages: $messages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmbeddedChatRoomModelImpl &&
            (identical(other.ref, ref) || other.ref == ref) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            const DeepCollectionEquality()
                .equals(other._profilesRefs, _profilesRefs) &&
            const DeepCollectionEquality().equals(other._profiles, _profiles) &&
            const DeepCollectionEquality().equals(other._messages, _messages));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      ref,
      createdAt,
      updatedAt,
      deletedAt,
      const DeepCollectionEquality().hash(_profilesRefs),
      const DeepCollectionEquality().hash(_profiles),
      const DeepCollectionEquality().hash(_messages));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EmbeddedChatRoomModelImplCopyWith<_$EmbeddedChatRoomModelImpl>
      get copyWith => __$$EmbeddedChatRoomModelImplCopyWithImpl<
          _$EmbeddedChatRoomModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmbeddedChatRoomModelImplToJson(
      this,
    );
  }
}

abstract class _EmbeddedChatRoomModel implements EmbeddedChatRoomModel {
  const factory _EmbeddedChatRoomModel(
          {@ModelRefSerializer() required final ModelRef ref,
          @TimestampDateTimeSerializer() required final DateTime createdAt,
          @TimestampDateTimeSerializer() required final DateTime updatedAt,
          @NullableTimestampDateTimeSerializer() final DateTime? deletedAt,
          required final List<ModelRef>? profilesRefs,
          required final List<ProfileModel> profiles,
          final List<EmbeddedChatRoomMessage> messages}) =
      _$EmbeddedChatRoomModelImpl;

  factory _EmbeddedChatRoomModel.fromJson(Map<String, dynamic> json) =
      _$EmbeddedChatRoomModelImpl.fromJson;

  @override
  @ModelRefSerializer()
  ModelRef get ref;
  @override
  @TimestampDateTimeSerializer()
  DateTime get createdAt;
  @override
  @TimestampDateTimeSerializer()
  DateTime get updatedAt;
  @override
  @NullableTimestampDateTimeSerializer()
  DateTime? get deletedAt;
  @override //
  List<ModelRef>? get profilesRefs;
  @override
  List<ProfileModel> get profiles;
  @override
  List<EmbeddedChatRoomMessage> get messages;
  @override
  @JsonKey(ignore: true)
  _$$EmbeddedChatRoomModelImplCopyWith<_$EmbeddedChatRoomModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
