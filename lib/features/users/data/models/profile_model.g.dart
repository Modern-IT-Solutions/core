// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ProfileModel _$$_ProfileModelFromJson(Map<String, dynamic> json) =>
    _$_ProfileModel(
      ref: const ModelRefSerializer().fromJson(json['ref'] as String),
      displayName: json['displayName'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      birthday: json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
      photoUrl: json['photoUrl'] as String,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      uid: json['uid'] as String,
      disabled: json['disabled'] as bool,
      roles: (json['roles'] as List<dynamic>)
          .map((e) => $enumDecode(_$RoleEnumMap, e))
          .toList(),
      emailVerified: json['emailVerified'] as bool,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      createdAt:
          const TimestampDateTimeSerializer().fromJson(json['createdAt']),
      updatedAt:
          const TimestampDateTimeSerializer().fromJson(json['updatedAt']),
      deletedAt:
          const TimestampDateTimeSerializer().fromJson(json['deletedAt']),
      lastSignInAt:
          const TimestampDateTimeSerializer().fromJson(json['lastSignInAt']),
    );

Map<String, dynamic> _$$_ProfileModelToJson(_$_ProfileModel instance) =>
    <String, dynamic>{
      'ref': const ModelRefSerializer().toJson(instance.ref),
      'displayName': instance.displayName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'birthday': instance.birthday?.toIso8601String(),
      'photoUrl': instance.photoUrl,
      'address': instance.address,
      'uid': instance.uid,
      'disabled': instance.disabled,
      'roles': instance.roles.map((e) => _$RoleEnumMap[e]!).toList(),
      'emailVerified': instance.emailVerified,
      'metadata': instance.metadata,
      'createdAt':
          const TimestampDateTimeSerializer().toJson(instance.createdAt),
      'updatedAt': _$JsonConverterToJson<dynamic, DateTime>(
          instance.updatedAt, const TimestampDateTimeSerializer().toJson),
      'deletedAt': _$JsonConverterToJson<dynamic, DateTime>(
          instance.deletedAt, const TimestampDateTimeSerializer().toJson),
      'lastSignInAt': _$JsonConverterToJson<dynamic, DateTime>(
          instance.lastSignInAt, const TimestampDateTimeSerializer().toJson),
    };

const _$RoleEnumMap = {
  Role.client: 'client',
  Role.technicianL1: 'technicianL1',
  Role.technicianL2: 'technicianL2',
  Role.technicianL3: 'technicianL3',
  Role.commercial: 'commercial',
  Role.admin: 'admin',
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
