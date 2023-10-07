import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'stadium_model.freezed.dart';
part 'stadium_model.g.dart';

@freezed
class StadiumModel with _$StadiumModel implements Model {

  factory StadiumModel({
    @ModelRefSerializer()
    required ModelRef ref,
    required String name,
    @Default("") String photoUrl,
    required bool disabled,
    @Default({}) Map<String,dynamic> metadata,
    @TimestampDateTimeSerializer()
    required DateTime createdAt,
    @TimestampDateTimeSerializer()
    required DateTime updatedAt,
    @NullableTimestampDateTimeSerializer()
    DateTime? deletedAt,
  }) = _StadiumModel;

  factory StadiumModel.fromJson(Map<String, dynamic> json) => _$StadiumModelFromJson(json);
}