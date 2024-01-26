// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rent_time_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RentTime _$RentTimeFromJson(Map<String, dynamic> json) {
  return _RentTime.fromJson(json);
}

/// @nodoc
mixin _$RentTime {
  @TimestampDateTimeSerializer()
  DateTime get start => throw _privateConstructorUsedError;
  @DurationSerializer()
  Duration get duration => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RentTimeCopyWith<RentTime> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RentTimeCopyWith<$Res> {
  factory $RentTimeCopyWith(RentTime value, $Res Function(RentTime) then) =
      _$RentTimeCopyWithImpl<$Res, RentTime>;
  @useResult
  $Res call(
      {@TimestampDateTimeSerializer() DateTime start,
      @DurationSerializer() Duration duration});
}

/// @nodoc
class _$RentTimeCopyWithImpl<$Res, $Val extends RentTime>
    implements $RentTimeCopyWith<$Res> {
  _$RentTimeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = null,
    Object? duration = null,
  }) {
    return _then(_value.copyWith(
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RentTimeImplCopyWith<$Res>
    implements $RentTimeCopyWith<$Res> {
  factory _$$RentTimeImplCopyWith(
          _$RentTimeImpl value, $Res Function(_$RentTimeImpl) then) =
      __$$RentTimeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@TimestampDateTimeSerializer() DateTime start,
      @DurationSerializer() Duration duration});
}

/// @nodoc
class __$$RentTimeImplCopyWithImpl<$Res>
    extends _$RentTimeCopyWithImpl<$Res, _$RentTimeImpl>
    implements _$$RentTimeImplCopyWith<$Res> {
  __$$RentTimeImplCopyWithImpl(
      _$RentTimeImpl _value, $Res Function(_$RentTimeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = null,
    Object? duration = null,
  }) {
    return _then(_$RentTimeImpl(
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RentTimeImpl implements _RentTime {
  _$RentTimeImpl(
      {@TimestampDateTimeSerializer() required this.start,
      @DurationSerializer() required this.duration});

  factory _$RentTimeImpl.fromJson(Map<String, dynamic> json) =>
      _$$RentTimeImplFromJson(json);

  @override
  @TimestampDateTimeSerializer()
  final DateTime start;
  @override
  @DurationSerializer()
  final Duration duration;

  @override
  String toString() {
    return 'RentTime(start: $start, duration: $duration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RentTimeImpl &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.duration, duration) ||
                other.duration == duration));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, start, duration);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RentTimeImplCopyWith<_$RentTimeImpl> get copyWith =>
      __$$RentTimeImplCopyWithImpl<_$RentTimeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RentTimeImplToJson(
      this,
    );
  }
}

abstract class _RentTime implements RentTime {
  factory _RentTime(
      {@TimestampDateTimeSerializer() required final DateTime start,
      @DurationSerializer() required final Duration duration}) = _$RentTimeImpl;

  factory _RentTime.fromJson(Map<String, dynamic> json) =
      _$RentTimeImpl.fromJson;

  @override
  @TimestampDateTimeSerializer()
  DateTime get start;
  @override
  @DurationSerializer()
  Duration get duration;
  @override
  @JsonKey(ignore: true)
  _$$RentTimeImplCopyWith<_$RentTimeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
