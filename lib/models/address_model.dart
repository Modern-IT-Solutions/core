import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';

import '../converters.dart';

part 'address_model.freezed.dart';
part 'address_model.g.dart';

@freezed
class AddressModel with _$AddressModel {

  factory AddressModel({
    required String raw,
    String? state,
    String? city,
    // zip code
    String? zip,
    @GeoFirePointConverter()
    GeoFirePoint? location,
  }) = _AddressModel;

  factory AddressModel.fromJson(Map<String, dynamic> json) => _$AddressModelFromJson(json);
}