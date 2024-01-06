import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'option_model.freezed.dart';
part 'option_model.g.dart';

@freezed
class OptionModel with _$OptionModel implements Model {

  factory OptionModel({
    /// standard model field
    @ModelRefSerializer() required ModelRef ref,
    @TimestampDateTimeSerializer() required DateTime createdAt,
    @TimestampDateTimeSerializer() required DateTime updatedAt,
    @NullableTimestampDateTimeSerializer() DateTime? deletedAt,
    /// option model field
    String? name,
    String? details,
    required String key,
    required String value,
    required String type,


  }) = _OptionModel;

  factory OptionModel.fromJson(Map<String, dynamic> json) => _$OptionModelFromJson(json);
}