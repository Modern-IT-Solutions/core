// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intervention_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

InterventionModel _$InterventionModelFromJson(Map<String, dynamic> json) {
  return _InterventionModel.fromJson(json);
}

/// @nodoc
mixin _$InterventionModel {
  @ModelRefSerializer()
  ModelRef get ref => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  DateTime? get deletedAt => throw _privateConstructorUsedError;
  InterventionStatus get status => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  String get description =>
      throw _privateConstructorUsedError; // required List<AttachmentModel> attachments,
  List<dynamic> get attachments => throw _privateConstructorUsedError;
  InterventionType get type => throw _privateConstructorUsedError;
  ProfileModel get intervener => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InterventionModelCopyWith<InterventionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InterventionModelCopyWith<$Res> {
  factory $InterventionModelCopyWith(
          InterventionModel value, $Res Function(InterventionModel) then) =
      _$InterventionModelCopyWithImpl<$Res, InterventionModel>;
  @useResult
  $Res call(
      {@ModelRefSerializer() ModelRef ref,
      DateTime createdAt,
      DateTime? updatedAt,
      DateTime? deletedAt,
      InterventionStatus status,
      DateTime date,
      String description,
      List<dynamic> attachments,
      InterventionType type,
      ProfileModel intervener});

  $ProfileModelCopyWith<$Res> get intervener;
}

/// @nodoc
class _$InterventionModelCopyWithImpl<$Res, $Val extends InterventionModel>
    implements $InterventionModelCopyWith<$Res> {
  _$InterventionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ref = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
    Object? status = null,
    Object? date = null,
    Object? description = null,
    Object? attachments = null,
    Object? type = null,
    Object? intervener = null,
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
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as InterventionStatus,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      attachments: null == attachments
          ? _value.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as InterventionType,
      intervener: null == intervener
          ? _value.intervener
          : intervener // ignore: cast_nullable_to_non_nullable
              as ProfileModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProfileModelCopyWith<$Res> get intervener {
    return $ProfileModelCopyWith<$Res>(_value.intervener, (value) {
      return _then(_value.copyWith(intervener: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_InterventionModelCopyWith<$Res>
    implements $InterventionModelCopyWith<$Res> {
  factory _$$_InterventionModelCopyWith(_$_InterventionModel value,
          $Res Function(_$_InterventionModel) then) =
      __$$_InterventionModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@ModelRefSerializer() ModelRef ref,
      DateTime createdAt,
      DateTime? updatedAt,
      DateTime? deletedAt,
      InterventionStatus status,
      DateTime date,
      String description,
      List<dynamic> attachments,
      InterventionType type,
      ProfileModel intervener});

  @override
  $ProfileModelCopyWith<$Res> get intervener;
}

/// @nodoc
class __$$_InterventionModelCopyWithImpl<$Res>
    extends _$InterventionModelCopyWithImpl<$Res, _$_InterventionModel>
    implements _$$_InterventionModelCopyWith<$Res> {
  __$$_InterventionModelCopyWithImpl(
      _$_InterventionModel _value, $Res Function(_$_InterventionModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ref = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
    Object? status = null,
    Object? date = null,
    Object? description = null,
    Object? attachments = null,
    Object? type = null,
    Object? intervener = null,
  }) {
    return _then(_$_InterventionModel(
      ref: null == ref
          ? _value.ref
          : ref // ignore: cast_nullable_to_non_nullable
              as ModelRef,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as InterventionStatus,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      attachments: null == attachments
          ? _value._attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as InterventionType,
      intervener: null == intervener
          ? _value.intervener
          : intervener // ignore: cast_nullable_to_non_nullable
              as ProfileModel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_InterventionModel implements _InterventionModel {
  _$_InterventionModel(
      {@ModelRefSerializer() required this.ref,
      required this.createdAt,
      this.updatedAt,
      this.deletedAt,
      required this.status,
      required this.date,
      required this.description,
      required final List<dynamic> attachments,
      required this.type,
      required this.intervener})
      : _attachments = attachments;

  factory _$_InterventionModel.fromJson(Map<String, dynamic> json) =>
      _$$_InterventionModelFromJson(json);

  @override
  @ModelRefSerializer()
  final ModelRef ref;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final DateTime? deletedAt;
  @override
  final InterventionStatus status;
  @override
  final DateTime date;
  @override
  final String description;
// required List<AttachmentModel> attachments,
  final List<dynamic> _attachments;
// required List<AttachmentModel> attachments,
  @override
  List<dynamic> get attachments {
    if (_attachments is EqualUnmodifiableListView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attachments);
  }

  @override
  final InterventionType type;
  @override
  final ProfileModel intervener;

  @override
  String toString() {
    return 'InterventionModel(ref: $ref, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, status: $status, date: $date, description: $description, attachments: $attachments, type: $type, intervener: $intervener)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_InterventionModel &&
            (identical(other.ref, ref) || other.ref == ref) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._attachments, _attachments) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.intervener, intervener) ||
                other.intervener == intervener));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      ref,
      createdAt,
      updatedAt,
      deletedAt,
      status,
      date,
      description,
      const DeepCollectionEquality().hash(_attachments),
      type,
      intervener);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_InterventionModelCopyWith<_$_InterventionModel> get copyWith =>
      __$$_InterventionModelCopyWithImpl<_$_InterventionModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_InterventionModelToJson(
      this,
    );
  }
}

abstract class _InterventionModel implements InterventionModel {
  factory _InterventionModel(
      {@ModelRefSerializer() required final ModelRef ref,
      required final DateTime createdAt,
      final DateTime? updatedAt,
      final DateTime? deletedAt,
      required final InterventionStatus status,
      required final DateTime date,
      required final String description,
      required final List<dynamic> attachments,
      required final InterventionType type,
      required final ProfileModel intervener}) = _$_InterventionModel;

  factory _InterventionModel.fromJson(Map<String, dynamic> json) =
      _$_InterventionModel.fromJson;

  @override
  @ModelRefSerializer()
  ModelRef get ref;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  DateTime? get deletedAt;
  @override
  InterventionStatus get status;
  @override
  DateTime get date;
  @override
  String get description;
  @override // required List<AttachmentModel> attachments,
  List<dynamic> get attachments;
  @override
  InterventionType get type;
  @override
  ProfileModel get intervener;
  @override
  @JsonKey(ignore: true)
  _$$_InterventionModelCopyWith<_$_InterventionModel> get copyWith =>
      throw _privateConstructorUsedError;
}
