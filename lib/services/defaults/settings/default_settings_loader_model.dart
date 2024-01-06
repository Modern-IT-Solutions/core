import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'default_settings_loader_model.freezed.dart';
part 'default_settings_loader_model.g.dart';

@freezed
class SettingsLoaderModel with _$SettingsLoaderModel implements Model {

  const factory SettingsLoaderModel({
    /// standard model field
    @ModelRefSerializer() required ModelRef ref,
    @TimestampDateTimeSerializer() required DateTime createdAt,
    @TimestampDateTimeSerializer() required DateTime updatedAt,
    @NullableTimestampDateTimeSerializer() DateTime? deletedAt,
    /// option model field
    
  }) = _SettingsLoaderModel;

  factory SettingsLoaderModel.fromJson(Map<String, dynamic> json) => _$SettingsLoaderModelFromJson(json);
}