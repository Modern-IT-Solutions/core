import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shipping_model.freezed.dart';
part 'shipping_model.g.dart';

@freezed
class ShippingModel with _$ShippingModel {

  const factory ShippingModel({
    required AddressModel address,
    ProfileModel? profile,
    required String name,
    required List<String> phoneNumbers,
    required List<String> emails,
    String? note,
    @Default({}) Map<String, dynamic> metadata,
  }) = _ShippingModel;

  factory ShippingModel.fromJson(Map<String, dynamic> json) => _$ShippingModelFromJson(json);
  /// [empty] returns an empty [ShippingModel]
  static const empty = ShippingModel(
    address: AddressModel.empty,
    name: "",
    phoneNumbers: [],
    emails: [],
  );
}