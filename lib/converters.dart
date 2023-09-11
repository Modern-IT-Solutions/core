import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';
import 'package:core/core.dart';

/// json coverter for [GeoFirePoint]
class GeoFirePointConverter implements JsonConverter<GeoFirePoint?, Map<String, dynamic>?> {
  const GeoFirePointConverter();

  @override
  GeoFirePoint? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    return GeoFirePoint(json['geopoint'] as GeoPoint);
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
    if (timestamp == null) return DateTime.now();
    if (timestamp is DateTime) return timestamp;
    if (timestamp is String) return DateTime.parse(timestamp);
    if (timestamp is Timestamp) return timestamp.toDate();
    throw Exception('Invalid timestamp format');
  }

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
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

/// ColorSerializer
class ColorSerializer implements JsonConverter<Color, int> {
  const ColorSerializer();

  @override
  Color fromJson(dynamic color) {
    try {
      return Color(int.parse('0xFF${color.toString().substring(
          // the camine color is "xxxxxxFF" string
          // but we need only "xxxxxx"
          0, 6)}'));
    } catch (e) {
      return Color(int.tryParse("0xFF" + color.toString()) ??
          /// purple
          0xFF6200EE);
    }
  }

  @override
  int toJson(Color color) => color.value;
}
