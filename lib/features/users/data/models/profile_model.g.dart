// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileModelImpl _$$ProfileModelImplFromJson(Map<String, dynamic> json) =>
    _$ProfileModelImpl(
      ref: const ModelRefSerializer().fromJson(json['ref'] as String),
      displayName: json['displayName'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      birthday: json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
      photoUrl: json['photoUrl'] as String? ?? "",
      address: json['address'] == null
          ? null
          : AddressModel.fromJson(json['address'] as Map<String, dynamic>),
      uid: json['uid'] as String,
      disabled: json['disabled'] as bool,
      roles: (json['roles'] as List<dynamic>)
          .map((e) => const RoleSerializer().fromJson(e as String))
          .toList(),
      emailVerified: json['emailVerified'] as bool,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      customClaims: json['customClaims'] as Map<String, dynamic>? ?? const {},
      createdAt: const TimestampDateTimeSerializer()
          .fromJson(json['createdAt'] as Timestamp),
      updatedAt: const TimestampDateTimeSerializer()
          .fromJson(json['updatedAt'] as Timestamp),
      deletedAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['deletedAt'], const TimestampDateTimeSerializer().fromJson),
      lastSignInAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['lastSignInAt'], const TimestampDateTimeSerializer().fromJson),
    );

Map<String, dynamic> _$$ProfileModelImplToJson(_$ProfileModelImpl instance) =>
    <String, dynamic>{
      'ref': const ModelRefSerializer().toJson(instance.ref),
      'displayName': instance.displayName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'birthday': instance.birthday?.toIso8601String(),
      'photoUrl': instance.photoUrl,
      'address': instance.address?.toJson(),
      'uid': instance.uid,
      'disabled': instance.disabled,
      'roles': instance.roles.map(const RoleSerializer().toJson).toList(),
      'emailVerified': instance.emailVerified,
      'metadata': instance.metadata,
      'customClaims': instance.customClaims,
      'createdAt':
          const TimestampDateTimeSerializer().toJson(instance.createdAt),
      'updatedAt':
          const TimestampDateTimeSerializer().toJson(instance.updatedAt),
      'deletedAt': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.deletedAt, const TimestampDateTimeSerializer().toJson),
      'lastSignInAt': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.lastSignInAt, const TimestampDateTimeSerializer().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
