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
      birthday: const NullableTimestampDateTimeSerializer()
          .fromJson(json['birthday']),
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
      createdAt:
          const TimestampDateTimeSerializer().fromJson(json['createdAt']),
      updatedAt:
          const TimestampDateTimeSerializer().fromJson(json['updatedAt']),
      deletedAt: const NullableTimestampDateTimeSerializer()
          .fromJson(json['deletedAt']),
      lastSignInAt: const NullableTimestampDateTimeSerializer()
          .fromJson(json['lastSignInAt']),
    );

Map<String, dynamic> _$$ProfileModelImplToJson(_$ProfileModelImpl instance) =>
    <String, dynamic>{
      'ref': const ModelRefSerializer().toJson(instance.ref),
      'displayName': instance.displayName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'birthday':
          const NullableTimestampDateTimeSerializer().toJson(instance.birthday),
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
      'deletedAt': const NullableTimestampDateTimeSerializer()
          .toJson(instance.deletedAt),
      'lastSignInAt': const NullableTimestampDateTimeSerializer()
          .toJson(instance.lastSignInAt),
    };
