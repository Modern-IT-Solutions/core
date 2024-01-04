import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:core/modules/commerce/shipping/shipping_model.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'gift_card_order_model.freezed.dart';
part 'gift_card_order_model.g.dart';

enum OrderStatus {
  pending,
  processing,
  completed,
  cancelled,
}

@freezed
class GiftCardOrderModel with _$GiftCardOrderModel implements Model {

  factory GiftCardOrderModel({
    @ModelRefSerializer()
    required ModelRef ref,
    @TimestampDateTimeSerializer()
    required DateTime createdAt,
    @TimestampDateTimeSerializer()
    required DateTime updatedAt,
    @NullableTimestampDateTimeSerializer()
    DateTime? deletedAt,


    ///
    required ProfileModel profile,
    required ShippingModel shipping,
    required double amount,
    required OrderStatus status,
    // this general note for the order
    String? note,
    // metadata for the order
    @Default({}) Map<String, dynamic> metadata,
    
  }) = _GiftCardOrderModel;

  factory GiftCardOrderModel.fromJson(Map<String, dynamic> json) => _$GiftCardOrderModelFromJson(json);


    static ModelDescription<GiftCardOrderModel> get description => ModelDescription<GiftCardOrderModel>(
      fields: {
        FieldDescription(
          name: "state",
          path: "shipping.address.state",
          map: (m)=>m.shipping.address.state,
          type: FieldType.text,
          group: FieldGroup.primary,
        ),
        FieldDescription(
          name: "uid",
          path: "profile.uid",
          map: (m)=>m.profile.uid,
          type: FieldType.text,
          group: FieldGroup.metadata,
        ),
        FieldDescription(
          name: "displayName",
          path: "profile.displayName",
          map: (m)=>m.profile.displayName,
          type: FieldType.text,
          group: FieldGroup.primary,
        ),
        FieldDescription(
          name: "email",
          path: "profile.email",
          map: (m)=>m.profile.email,
          type: FieldType.email,
          group: FieldGroup.primary,
        ),
        FieldDescription(
          name: "phoneNumber",
          path: "profile.phoneNumber",
          map: (m)=>m.profile.phoneNumber,
          type: FieldType.phone,
          group: FieldGroup.primary,
        ),
        FieldDescription(
          name: "updatedAt",
          path: "updatedAt",
          map: (m)=>m.updatedAt,
          type: FieldType.datetime,
          group: FieldGroup.metadata,
        ),
        FieldDescription(
          name: "createdAt",
          path: "createdAt",
          map: (m)=>m.createdAt,
          type: FieldType.datetime,
          group: FieldGroup.metadata,
        ),
        FieldDescription(
          name: "deletedAt",
          path: "deletedAt",
          map: (m)=>m.createdAt,
          type: FieldType.datetime,
          group: FieldGroup.metadata,
        ),
      },
      name: "GC Orders",
      path: "giftCardOrders",
      fromJson: GiftCardOrderModel.fromJson,
      tileBuilder: (model) => ModelGeneralData(
        title: model.profile.displayName,
        subtitle: model.profile.email.nullIfEmpty ?? model.profile.phoneNumber?.nullIfEmpty,
        leading: ProfileAvatar(profile: model.profile),
      ),
      actions: [
        // cancel order
        ModelAction(
          label: "Cancel order",
          group: "control",
          icon: Icon(FluentIcons.delete_20_regular),
          multiple: (context, models) async {
            for (var model in models!) {
              // await showStationModelHistoryDailog(context, model!);
            }
          },
        ),
      ]
    );

}