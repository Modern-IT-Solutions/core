import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

@freezed
class NotificationModel with _$NotificationModel implements Model {

  factory NotificationModel({
    @ModelRefSerializer()
    required ModelRef ref,
    String? photoUrl,
    required String title,
    String? subtitle,
    String? body,
    @Default(false) bool seen,
    required ProfileModel profile,
    @Default({}) Map<String,dynamic> metadata,
    @TimestampDateTimeSerializer()
    required DateTime createdAt,
    @TimestampDateTimeSerializer()
    required DateTime updatedAt,
    @NullableTimestampDateTimeSerializer()
    DateTime? deletedAt,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, dynamic> json) => _$NotificationModelFromJson(json);



    static ModelDescription<NotificationModel> get description => ModelDescription<NotificationModel>(
        fields: {
          FieldDescription(
            name: "title",
            path: "title",
            nullable: true,
            type: FieldType.text,
            map: (m) => m.title,
            group: FieldGroup.primary,
          ),
          FieldDescription(
            name: "body",
            path: "body",
            type: FieldType.text,
            map: (m) => m.body,
            group: FieldGroup.primary,
          ),
          FieldDescription(
            name: "profile uid",
            path: "uid",
            type: FieldType.text,
            map: (m) => m.profile.uid,
            group: FieldGroup.secondary,
          ),
          FieldDescription(
            name: "profile email",
            path: "email",
            type: FieldType.text,
            map: (m) => m.profile.email,
            group: FieldGroup.secondary,
          ),
          FieldDescription(
            name: "profile phone",
            path: "phoneNumber",
            type: FieldType.text,
            map: (m) => m.profile.phoneNumber,
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
          FieldDescription(
            name: "updatedAt",
            path: "updatedAt",
            type: FieldType.datetime,
            map: (m) => m.updatedAt,
            group: FieldGroup.metadata,
          ),
          FieldDescription(
            name: "deletedAt",
            path: "deletedAt",
            nullable: true,
            type: FieldType.datetime,
            map: (m) => m.deletedAt,
            group: FieldGroup.metadata,
          ),
        },
        name: "Notifications",
        path: "notifications",
        fromJson: NotificationModel.fromJson,
        tileBuilder: (model) => ModelGeneralData(
          title: model.title,
          subtitle: model.body,
          leading: model.photoUrl?.nullIfEmpty != null ? CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(model.photoUrl!),
          ) : null,
        ),
        actions: [],
      );

}