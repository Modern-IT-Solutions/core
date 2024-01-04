import 'package:core/core.dart';
import 'package:core/models/base.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'file_model.freezed.dart';
part 'file_model.g.dart';

@freezed
class FileModel with _$FileModel  {

  factory FileModel({
    @ModelRefSerializer()
    required ModelRef ref,
    @TimestampDateTimeSerializer()
    required DateTime createdAt,
    @TimestampDateTimeSerializer()
    required DateTime updatedAt,
    @NullableTimestampDateTimeSerializer()
    DateTime? deletedAt,
    ///
    ProfileModel? profile,
    @ModelRefSerializer()
    ModelRef? profileRef,
    String? name,
    String? type,
    String? url,

  }) = _FileModel;

  factory FileModel.fromJson(Map<String, dynamic> json) => _$FileModelFromJson(json);
}