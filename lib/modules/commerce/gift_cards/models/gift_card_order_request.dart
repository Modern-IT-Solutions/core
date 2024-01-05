import 'package:core/converters.dart';
import 'package:core/core.dart';
import 'package:core/modules/commerce/shipping/shipping_model.dart';
import 'package:core/temp.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'gift_card_order_model.dart';

part 'gift_card_order_request.freezed.dart';
part 'gift_card_order_request.g.dart';

@freezed
class GiftCardOrderRequest with _$GiftCardOrderRequest {

  factory GiftCardOrderRequest({
    @ModelRefSerializer()
    required ModelRef ref,
    @TimestampDateTimeSerializer()
    DateTime? createdAt,
    @TimestampDateTimeSerializer()
    DateTime? updatedAt,
    @NullableTimestampDateTimeSerializer()
    DateTime? deletedAt,
    ///
    double? amount,
    @Default(OrderStatus.pending) OrderStatus status,
    ProfileModel? profile,
    String? note,
    @Default(ShippingModel.empty) ShippingModel shipping,
    @Default({}) Map<String, dynamic> metadata,
  }) = _GiftCardOrderRequest;

  factory GiftCardOrderRequest.fromJson(Map<String, dynamic> json) => _$GiftCardOrderRequestFromJson(json);
}