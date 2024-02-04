// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AddressModelImpl _$$AddressModelImplFromJson(Map<String, dynamic> json) =>
    _$AddressModelImpl(
      raw: json['raw'] as String,
      state: json['state'] as String?,
      city: json['city'] as String?,
      zip: json['zip'] as String?,
      country: json['country'] as String? ?? "DZ",
      location: const GeoFirePointConverter().fromJson(json['location']),
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$AddressModelImplToJson(_$AddressModelImpl instance) =>
    <String, dynamic>{
      'raw': instance.raw,
      'state': instance.state,
      'city': instance.city,
      'zip': instance.zip,
      'country': instance.country,
      'location': const GeoFirePointConverter().toJson(instance.location),
      'metadata': instance.metadata,
    };
