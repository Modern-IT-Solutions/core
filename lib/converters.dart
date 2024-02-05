import 'dart:ui';

import 'package:core/features/users/data/models/role.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';
import 'package:core/core.dart';

class GeoFirePointConverter implements JsonConverter<GeoFirePoint?, dynamic> {
  const GeoFirePointConverter();

  @override
  GeoFirePoint? fromJson(dynamic json) {
    try {
      if (json == null) return null;
      if (json is GeoPoint) return GeoFirePoint(json as GeoPoint);
      if (json is Iterable) return GeoFirePoint(GeoPoint(json.elementAt(0) as double, json.elementAt(1) as double));
      if (json is GeoFirePoint) return json;
    } catch (e) {
      print("MUST BE A GEOPOINT OR AN ITERABLE");
      print(e);
    }
    return null;
  }

  @override
  Map<String, dynamic>? toJson(GeoFirePoint? point) {
    return point?.data;
  }
}

/// timestamp coverter for [Timestamp]
class TimestampDateTimeSerializer implements JsonConverter<DateTime, dynamic> {
  const TimestampDateTimeSerializer();

  @override
  DateTime fromJson(dynamic timestamp) {
    if (timestamp == null) return DateTime.fromMicrosecondsSinceEpoch(0);
    if (timestamp is DateTime) return timestamp;
    if (timestamp is String) return DateTime.parse(timestamp);
    if (timestamp is Timestamp) return timestamp.toDate();

    return DateTime.fromMicrosecondsSinceEpoch(0);

    throw Exception('Invalid timestamp format');
  }

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}

/// timestamp coverter for [Timestamp]
class NullableTimestampDateTimeSerializer implements JsonConverter<DateTime?, dynamic> {
  const NullableTimestampDateTimeSerializer();

  @override
  DateTime? fromJson(dynamic timestamp) {
    if (timestamp == null) return null;
    if (timestamp is DateTime) return timestamp;
    if (timestamp is String) return DateTime.parse(timestamp);
    if (timestamp is Timestamp) return timestamp.toDate();
    throw Exception('Invalid timestamp format');
  }

  @override
  toJson(DateTime? date) => date == null? null : Timestamp.fromDate(date);
}

/// ModelRefSerializer
class ModelRefSerializer implements JsonConverter<ModelRef, String> {
  const ModelRefSerializer();

  @override
  ModelRef fromJson(String ref) {
    return ModelRef(ref);
  }

  @override
  String toJson(ModelRef ref) => ref.path;
}
/// ModelRefSerializer
class RoleSerializer implements JsonConverter<Role, String> {
  const RoleSerializer();

  @override
  Role fromJson(String role) {
    return Role(role, permissions: []);
  }

  @override
  String toJson(Role ref) => ref.name;
}

/// ColorSerializer
class ColorSerializer implements JsonConverter<Color, int> {
  const ColorSerializer();


  @override
  Color fromJson(dynamic color) {
    if (color is Color) return color;
    if (color is int) return Color(color);
    if (color is String) return _fromString(color);
    throw Exception('${color.runtimeType} is not a valid color that can be parsed - only int|Color|String are supported');
  }

  Color _fromString(String color) {
    if (color.startsWith('#')) {
      return Color(int.parse(color.substring(3, 9), radix: 16));
    } else if (color.startsWith('0x')) {
      return Color(int.parse(color.substring(2, 8), radix: 16));
    } else  {
      try {
        return Color(int.parse(color));
      } catch (e) {
        throw Exception('Invalid color format');
      }
    }
  }


  @override
  int toJson(Color color) => color.value;
}


/// DurationSerializer
class DurationSerializer implements JsonConverter<Duration, int> {
  const DurationSerializer();

  @override
  Duration fromJson(int milliseconds) {
    return Duration(milliseconds: milliseconds);
  }

  @override
  int toJson(Duration duration) => duration.inMilliseconds;
}