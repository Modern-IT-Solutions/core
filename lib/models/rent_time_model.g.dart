// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rent_time_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RentTimeImpl _$$RentTimeImplFromJson(Map<String, dynamic> json) =>
    _$RentTimeImpl(
      start: const TimestampDateTimeSerializer().fromJson(json['start']),
      duration: const DurationSerializer().fromJson(json['duration'] as int),
    );

Map<String, dynamic> _$$RentTimeImplToJson(_$RentTimeImpl instance) =>
    <String, dynamic>{
      'start': const TimestampDateTimeSerializer().toJson(instance.start),
      'duration': const DurationSerializer().toJson(instance.duration),
    };
