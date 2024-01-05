import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';

import '../converters.dart';

part 'address_model.freezed.dart';
part 'address_model.g.dart';

@freezed
class AddressModel with _$AddressModel {
  const factory AddressModel({
    required String raw,

    /// [state] is the wilaya
    String? state,

    /// [city] is the baladiya
    String? city,
    // zip code
    String? zip,
    @Default("DZ") String country,
    @GeoFirePointConverter() GeoFirePoint? location,
    @Default({}) Map<String, dynamic> metadata,
  }) = _AddressModel;

  factory AddressModel.fromJson(Map<String, dynamic> json) => _$AddressModelFromJson(json);
  static const empty = const AddressModel(
    raw: "",
  );
}
