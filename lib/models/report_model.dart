import 'package:core/converters.dart';
import 'package:core/features/users/presentation/index.dart';
import 'package:core/temp.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'base.dart';

part 'report_model.freezed.dart';
part 'report_model.g.dart';

@freezed
class ReportModel with _$ReportModel implements Model {

  const ReportModel._();

  const factory ReportModel({
    @ModelRefSerializer() required ModelRef ref,
    required String issue,
    required String type,
    @Default({}) Map<String, dynamic> deviceInfo,
    @Default({}) Map<String, dynamic> packageInfo,
    @Default({}) Map<String, dynamic> user,
    @TimestampDateTimeSerializer() required DateTime createdAt,
    // @NullableTimestampDateTimeSerializer() DateTime? deletedAt,
  }) = _ReportModel;

  @override
  DateTime get updatedAt => createdAt;

  @override
  DateTime? get deletedAt => null;

  factory ReportModel.fromJson(Map<String, dynamic> json) => _$ReportModelFromJson(json);

  static ModelDescription<ReportModel> get description => ModelDescription<ReportModel>(
        fields: {
          FieldDescription(
            name: "issue",
            path: "issue",
            nullable: true,
            type: FieldType.text,
            map: (m) => m.issue,
            group: FieldGroup.primary,
          ),
          FieldDescription(
            name: "type",
            path: "type",
            type: FieldType.text,
            map: (m) => m.type,
            group: FieldGroup.primary,
          ),
          FieldDescription(
            name: "uid",
            path: "user.uid",
            type: FieldType.text,
            map: (m) => m.user["uid"],
            group: FieldGroup.secondary,
          ),
          FieldDescription(
            name: "email",
            path: "user.email",
            type: FieldType.text,
            map: (m) => m.user["email"],
            group: FieldGroup.secondary,
          ),

          FieldDescription(
            name: "ref",
            path: "ref",
            type: FieldType.text,
            map: (m) => m.ref,
            group: FieldGroup.metadata,
          ),
          FieldDescription(
            name: "createdAt",
            path: "createdAt",
            type: FieldType.datetime,
            map: (m) => m.createdAt,
            group: FieldGroup.metadata,
          ),
        },
        name: "Reporta",
        path: "reports",
        fromJson: ReportModel.fromJson,
        tileBuilder: (model) => ModelGeneralData(
          title: model.issue,
          subtitle: model.type,
        ),
        actions: [],
      );
}
