import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';

import '../converters.dart';

/// [Address] is a model for address data.
/// it use Freezed package to generate the model.

part 'address.freezed.dart';
part 'address.g.dart';

@freezed
abstract class Address with _$Address {
  const factory Address({
    required String raw,
    String? state,
    String? city,
    // zip code
    String? zip,
    @GeoFirePointConverter()
    GeoFirePoint? location,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}
