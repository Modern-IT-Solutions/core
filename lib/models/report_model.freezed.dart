// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ReportModel _$ReportModelFromJson(Map<String, dynamic> json) {
  return _ReportModel.fromJson(json);
}

/// @nodoc
mixin _$ReportModel {
  @ModelRefSerializer()
  ModelRef get ref => throw _privateConstructorUsedError;
  String get issue => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  Map<String, dynamic> get deviceInfo => throw _privateConstructorUsedError;
  Map<String, dynamic> get packageInfo => throw _privateConstructorUsedError;
  Map<String, dynamic> get user => throw _privateConstructorUsedError;
  @TimestampDateTimeSerializer()
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReportModelCopyWith<ReportModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReportModelCopyWith<$Res> {
  factory $ReportModelCopyWith(
          ReportModel value, $Res Function(ReportModel) then) =
      _$ReportModelCopyWithImpl<$Res, ReportModel>;
  @useResult
  $Res call(
      {@ModelRefSerializer() ModelRef ref,
      String issue,
      String type,
      Map<String, dynamic> deviceInfo,
      Map<String, dynamic> packageInfo,
      Map<String, dynamic> user,
      @TimestampDateTimeSerializer() DateTime createdAt});
}

/// @nodoc
class _$ReportModelCopyWithImpl<$Res, $Val extends ReportModel>
    implements $ReportModelCopyWith<$Res> {
  _$ReportModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ref = null,
    Object? issue = null,
    Object? type = null,
    Object? deviceInfo = null,
    Object? packageInfo = null,
    Object? user = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      ref: null == ref
          ? _value.ref
          : ref // ignore: cast_nullable_to_non_nullable
              as ModelRef,
      issue: null == issue
          ? _value.issue
          : issue // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      deviceInfo: null == deviceInfo
          ? _value.deviceInfo
          : deviceInfo // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      packageInfo: null == packageInfo
          ? _value.packageInfo
          : packageInfo // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReportModelImplCopyWith<$Res>
    implements $ReportModelCopyWith<$Res> {
  factory _$$ReportModelImplCopyWith(
          _$ReportModelImpl value, $Res Function(_$ReportModelImpl) then) =
      __$$ReportModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@ModelRefSerializer() ModelRef ref,
      String issue,
      String type,
      Map<String, dynamic> deviceInfo,
      Map<String, dynamic> packageInfo,
      Map<String, dynamic> user,
      @TimestampDateTimeSerializer() DateTime createdAt});
}

/// @nodoc
class __$$ReportModelImplCopyWithImpl<$Res>
    extends _$ReportModelCopyWithImpl<$Res, _$ReportModelImpl>
    implements _$$ReportModelImplCopyWith<$Res> {
  __$$ReportModelImplCopyWithImpl(
      _$ReportModelImpl _value, $Res Function(_$ReportModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ref = null,
    Object? issue = null,
    Object? type = null,
    Object? deviceInfo = null,
    Object? packageInfo = null,
    Object? user = null,
    Object? createdAt = null,
  }) {
    return _then(_$ReportModelImpl(
      ref: null == ref
          ? _value.ref
          : ref // ignore: cast_nullable_to_non_nullable
              as ModelRef,
      issue: null == issue
          ? _value.issue
          : issue // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      deviceInfo: null == deviceInfo
          ? _value._deviceInfo
          : deviceInfo // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      packageInfo: null == packageInfo
          ? _value._packageInfo
          : packageInfo // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      user: null == user
          ? _value._user
          : user // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReportModelImpl extends _ReportModel {
  const _$ReportModelImpl(
      {@ModelRefSerializer() required this.ref,
      required this.issue,
      required this.type,
      final Map<String, dynamic> deviceInfo = const {},
      final Map<String, dynamic> packageInfo = const {},
      final Map<String, dynamic> user = const {},
      @TimestampDateTimeSerializer() required this.createdAt})
      : _deviceInfo = deviceInfo,
        _packageInfo = packageInfo,
        _user = user,
        super._();

  factory _$ReportModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReportModelImplFromJson(json);

  @override
  @ModelRefSerializer()
  final ModelRef ref;
  @override
  final String issue;
  @override
  final String type;
  final Map<String, dynamic> _deviceInfo;
  @override
  @JsonKey()
  Map<String, dynamic> get deviceInfo {
    if (_deviceInfo is EqualUnmodifiableMapView) return _deviceInfo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_deviceInfo);
  }

  final Map<String, dynamic> _packageInfo;
  @override
  @JsonKey()
  Map<String, dynamic> get packageInfo {
    if (_packageInfo is EqualUnmodifiableMapView) return _packageInfo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_packageInfo);
  }

  final Map<String, dynamic> _user;
  @override
  @JsonKey()
  Map<String, dynamic> get user {
    if (_user is EqualUnmodifiableMapView) return _user;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_user);
  }

  @override
  @TimestampDateTimeSerializer()
  final DateTime createdAt;

  @override
  String toString() {
    return 'ReportModel(ref: $ref, issue: $issue, type: $type, deviceInfo: $deviceInfo, packageInfo: $packageInfo, user: $user, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReportModelImpl &&
            (identical(other.ref, ref) || other.ref == ref) &&
            (identical(other.issue, issue) || other.issue == issue) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality()
                .equals(other._deviceInfo, _deviceInfo) &&
            const DeepCollectionEquality()
                .equals(other._packageInfo, _packageInfo) &&
            const DeepCollectionEquality().equals(other._user, _user) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      ref,
      issue,
      type,
      const DeepCollectionEquality().hash(_deviceInfo),
      const DeepCollectionEquality().hash(_packageInfo),
      const DeepCollectionEquality().hash(_user),
      createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReportModelImplCopyWith<_$ReportModelImpl> get copyWith =>
      __$$ReportModelImplCopyWithImpl<_$ReportModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReportModelImplToJson(
      this,
    );
  }
}

abstract class _ReportModel extends ReportModel {
  const factory _ReportModel(
          {@ModelRefSerializer() required final ModelRef ref,
          required final String issue,
          required final String type,
          final Map<String, dynamic> deviceInfo,
          final Map<String, dynamic> packageInfo,
          final Map<String, dynamic> user,
          @TimestampDateTimeSerializer() required final DateTime createdAt}) =
      _$ReportModelImpl;
  const _ReportModel._() : super._();

  factory _ReportModel.fromJson(Map<String, dynamic> json) =
      _$ReportModelImpl.fromJson;

  @override
  @ModelRefSerializer()
  ModelRef get ref;
  @override
  String get issue;
  @override
  String get type;
  @override
  Map<String, dynamic> get deviceInfo;
  @override
  Map<String, dynamic> get packageInfo;
  @override
  Map<String, dynamic> get user;
  @override
  @TimestampDateTimeSerializer()
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$ReportModelImplCopyWith<_$ReportModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
