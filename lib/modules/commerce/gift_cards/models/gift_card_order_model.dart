import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:core/modules/commerce/shipping/shipping_model.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'gift_card_order_model.freezed.dart';
part 'gift_card_order_model.g.dart';

enum OrderStatus {
  pending(color: Colors.orange),
  processing(color: Colors.blue),
  completed(color: Colors.green),
  cancelled(color: Colors.red);

  const OrderStatus({required this.color});
  final Color color;
}

@freezed
class GiftCardOrderModel with _$GiftCardOrderModel implements Model {
  factory GiftCardOrderModel({
    @ModelRefSerializer() required ModelRef ref,
    @TimestampDateTimeSerializer() required DateTime createdAt,
    @TimestampDateTimeSerializer() required DateTime updatedAt,
    @NullableTimestampDateTimeSerializer() DateTime? deletedAt,
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
          map: (m) => m.shipping.address.state,
          type: FieldType.text,
          group: FieldGroup.primary,
        ),
        FieldDescription(
          name: "uid",
          path: "profile.uid",
          map: (m) => m.profile.uid,
          type: FieldType.text,
          group: FieldGroup.metadata,
        ),
        FieldDescription(
          name: "displayName",
          path: "profile.displayName",
          map: (m) => m.profile.displayName,
          type: FieldType.text,
          group: FieldGroup.primary,
        ),
        FieldDescription(
          name: "email",
          path: "profile.email",
          map: (m) => m.profile.email,
          type: FieldType.email,
          group: FieldGroup.primary,
        ),
        FieldDescription(
          name: "phoneNumber",
          path: "profile.phoneNumber",
          map: (m) => m.profile.phoneNumber,
          type: FieldType.phone,
          group: FieldGroup.primary,
        ),
        FieldDescription(
          name: "updatedAt",
          path: "updatedAt",
          map: (m) => m.updatedAt,
          type: FieldType.datetime,
          group: FieldGroup.metadata,
        ),
        FieldDescription(
          name: "createdAt",
          path: "createdAt",
          map: (m) => m.createdAt,
          type: FieldType.datetime,
          group: FieldGroup.metadata,
        ),
        FieldDescription(
          name: "deletedAt",
          path: "deletedAt",
          map: (m) => m.createdAt,
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
        // change order status
        for (var status in OrderStatus.values)
          ModelAction(
            label: "Mark as ${status.name}",
            group: "control",
            single: (context, model) async {
              if (model != null) {
                var loading = false;
                String? error;
                await showDialog(useRootNavigator: false,
                  context: context,
                  builder: (context) => StatefulBuilder(builder: (context, setState) {
                    return AlertDialog(
                      title: Text('confirm mark as ${status.name}?'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('are you sure you want to mark it as ${status.name} instead of ${model.status.name}?'),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: loading
                              ? null
                              : () async {
                                  loading = true;
                                  error = null;
                                  setState(() {});
                                  try {
                                    await updateDocument(
                                      path: model.ref.path,
                                      data: {
                                        "status": status.name,
                                      },
                                    );
                                    ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                                      SnackBar(
                                          behavior: SnackBarBehavior.floating,
                                          width: 400.0,
                                          content: Text('${model.shortId} marked as ${status.name}'),
                                          action: SnackBarAction(
                                            label: 'Close',
                                            onPressed: () {
                                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                            },
                                          )),
                                    );
                                    Navigator.of(context).pop();
                                  } catch (e) {
                                    error = e.toString();
                                  }
                                  loading = false;
                                  setState(() {});
                                },
                          child: loading ? const CircularProgressIndicator.adaptive() : const Text('Continue'),
                        ),
                      ],
                    );
                  }),
                );
              }
            },
            multiple: (context, models) async {
              double progress = 0.0;
              var loading = false;
              if (models != null) {
                await showDialog(useRootNavigator: false,
                  context: context,
                  builder: (context) => StatefulBuilder(builder: (context, setState) {
                    return AlertDialog(
                      title: Text('confirm mark as ${status.name}?'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('are you sure you want to mark ${models.length} orders as ${status.name}?'),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 2,
                            child: LinearProgressIndicator(
                              value: progress,
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: loading
                              ? null
                              : () async {
                                  loading = true;
                                  setState(() {});
                                  try {
                                    for (var model in models) {
                                      await updateDocument(
                                        path: model.ref.path,
                                        data: {
                                          "status": status.name,
                                        },
                                      );
                                      progress = models.indexOf(model) / models.length;
                                      setState(() {});
                                    }
                                    ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                                      SnackBar(
                                          behavior: SnackBarBehavior.floating,
                                          width: 400.0,
                                          content: Text('${models.length} orders marked as ${status.name}'),
                                          action: SnackBarAction(
                                            label: 'Close',
                                            onPressed: () {
                                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                            },
                                          )),
                                    );
                                    Navigator.of(context).pop();
                                  } catch (e) {}
                                  loading = false;
                                  setState(() {});
                                },
                          child: loading ? const CircularProgressIndicator.adaptive() : const Text('Continue'),
                        ),
                      ],
                    );
                  }),
                );
              }
              

              // for (var model in models!) {
              //   await updateDocument(
              //     path: model.ref.path,
              //     data: {
              //       "status": status.index,
              //     },
              //   );
              // }
            },
          ),
      ],
    );
}
