import 'package:core/core.dart';
import '../converters.dart';
import 'base.dart';

/// [Attachment] is an abstract class that represents an attachment
/// it contains : [name] is [String], [url] is [String] , [type] is [String]

import 'package:freezed_annotation/freezed_annotation.dart';

part 'attachment_model.freezed.dart';
part 'attachment_model.g.dart';

@freezed
class AttachmentModel extends Model with _$AttachmentModel {

  factory AttachmentModel({
    @ModelRefSerializer()
    required ModelRef ref,
    @TimestampDateTimeSerializer()
    required DateTime createdAt,
    @TimestampDateTimeSerializer()
    required DateTime updatedAt,
    @TimestampDateTimeSerializer()
    DateTime? deletedAt,
    required String name,
    required String type,
    required String url,
  }) = _AttachmentModel;

  factory AttachmentModel.fromJson(Map<String, dynamic> json) => _$AttachmentModelFromJson(json);
}

