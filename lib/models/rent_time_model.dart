import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'rent_time_model.freezed.dart';
part 'rent_time_model.g.dart';

@freezed
class RentTime with _$RentTime {

  factory RentTime({
    @TimestampDateTimeSerializer()
    required DateTime start,
    @DurationSerializer()
    required Duration duration,
  }) = _RentTime;

  factory RentTime.fromJson(Map<String, dynamic> json) => _$RentTimeFromJson(json);
}