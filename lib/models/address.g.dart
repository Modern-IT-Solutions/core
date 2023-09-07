// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Address _$$_AddressFromJson(Map<String, dynamic> json) => _$_Address(
      raw: json['raw'] as String,
      state: json['state'] as String?,
      city: json['city'] as String?,
      zip: json['zip'] as String?,
      location: const GeoFirePointConverter()
          .fromJson(json['location'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$$_AddressToJson(_$_Address instance) =>
    <String, dynamic>{
      'raw': instance.raw,
      'state': instance.state,
      'city': instance.city,
      'zip': instance.zip,
      'location': const GeoFirePointConverter().toJson(instance.location),
    };
