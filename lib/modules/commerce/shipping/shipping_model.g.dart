// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipping_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ShippingModelImpl _$$ShippingModelImplFromJson(Map<String, dynamic> json) =>
    _$ShippingModelImpl(
      address: AddressModel.fromJson(json['address'] as Map<String, dynamic>),
      profile: json['profile'] == null
          ? null
          : ProfileModel.fromJson(json['profile'] as Map<String, dynamic>),
      name: json['name'] as String,
      phoneNumbers: (json['phoneNumbers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      emails:
          (json['emails'] as List<dynamic>).map((e) => e as String).toList(),
      note: json['note'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$ShippingModelImplToJson(_$ShippingModelImpl instance) =>
    <String, dynamic>{
      'address': instance.address.toJson(),
      'profile': instance.profile?.toJson(),
      'name': instance.name,
      'phoneNumbers': instance.phoneNumbers,
      'emails': instance.emails,
      'note': instance.note,
      'metadata': instance.metadata,
    };
