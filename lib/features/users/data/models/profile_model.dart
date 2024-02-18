
import 'package:core/core.dart';
import 'package:core/features/users/data/models/permission.dart';
import 'package:core/models/address_model.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'profile_session.dart';
import 'role.dart';


part 'profile_model.freezed.dart';
part 'profile_model.g.dart';

@freezed
class ProfileModel with _$ProfileModel implements Model {
  const factory ProfileModel({
    @ModelRefSerializer()
    required ModelRef ref,
    required String displayName,
    required String email,
    String? phoneNumber,
    @NullableTimestampDateTimeSerializer()
    DateTime? birthday,
    @Default("") String photoUrl,
    required AddressModel? address,
    required String uid,
    required bool disabled,
    @RoleSerializer() 
    required List<Role> roles,
    required bool emailVerified,
    @Default({}) Map<String, ProfileSession> sessions,
    @Default({}) Map<String,dynamic> metadata,
    @Default({}) Map<String,dynamic> customClaims,


    @TimestampDateTimeSerializer()
    required DateTime createdAt,
    @TimestampDateTimeSerializer()
    required DateTime updatedAt,
    @NullableTimestampDateTimeSerializer()
    DateTime? deletedAt,
    @NullableTimestampDateTimeSerializer()
    DateTime? lastSignInAt,
  }) = _ProfileModel;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => _$ProfileModelFromJson(json);

  static ModelDescription<ProfileModel> get description => ModelDescription<ProfileModel>(
      fields: {
        FieldDescription(
          name: "uid",
          path: "uid",
          map: (m)=>m.uid,
          type: FieldType.text,
          group: FieldGroup.metadata,
        ),
        FieldDescription(
          name: "displayName",
          path: "displayName",
          map: (m)=>m.displayName,
          type: FieldType.text,
          group: FieldGroup.primary,
        ),
        FieldDescription(
          name: "email",
          path: "email",
          map: (m)=>m.email,
          type: FieldType.email,
          group: FieldGroup.primary,
        ),
        FieldDescription(
          name: "phoneNumber",
          path: "phoneNumber",
          map: (m)=>m.phoneNumber,
          type: FieldType.phone,
          group: FieldGroup.primary,
        ),
        FieldDescription(
          name: "updatedAt",
          path: "updatedAt",
          map: (m)=>m.updatedAt,
          type: FieldType.datetime,
          group: FieldGroup.metadata,
        ),
        FieldDescription(
          name: "createdAt",
          path: "createdAt",
          map: (m)=>m.createdAt,
          type: FieldType.datetime,
          group: FieldGroup.metadata,
        ),
        FieldDescription(
          name: "deletedAt",
          path: "deletedAt",
          map: (m)=>m.createdAt,
          type: FieldType.datetime,
          group: FieldGroup.metadata,
        ),
      },
      name: "Profile",
      path: "profiles",
      fromJson: ProfileModel.fromJson,
      tileBuilder: (model) => ModelGeneralData(
        title: model.displayName,
      ),
      actions: []
    );
}


/// [Role] is an enum that represents the role of the user.
/// it contains :  [ClientModel], [Technician], [Commercial], [Admin]
// enum Role {
//   /// Role.client
//   student,
//   /// Role.client
//   client,

//   /// Role.technician
//   technicianL1,
//   technicianL2,
//   technicianL3,

//   /// Role.commercial
//   commercial,

//   /// Role.admin
//   admin;

//   /// fromString
//   static Role? fromString(String? role) {
//     var r = Role.values.where(
//       (e) => e.name == role,
//     );
//     if (r.isNotEmpty) {
//       return r.first;
//     } else {
//       return null;
//     }
//   }

//   /// fromListString
//   static List<Role> fromListString(List<String> roles) {
//     return roles.map((e) => fromString(e)!).toList();
//   }
// }



/// [emptyToNull] extension method on [Map<String, dynamic>]
extension MapExtension on Map<String, dynamic> {
  /// Returns a copy of this map with all null values removed.
  Map<String, dynamic> emptyToNull() {
    return Map.fromEntries(entries.where((e) => e.value != null));
  }
}




/// fcm token extension to set and get the fcm tokens
extension FcmTokenExtension on ProfileModel {
  /// get the fcm token
  List<String> get fcmTokens => List<String>.from(metadata['fcmTokens'] ?? []);

  /// set the fcm token
  set fcmTokens(List<String> tokens) {
    metadata['fcmTokens'] = tokens;
  }
}


/// roles extension to set and get the fcm tokens
extension RolesExtensions on ProfileModel {
  List<String> get rolesString => roles.map((e) => e.name).toList();
  bool get isAdmin => roles.map((e) => e.name).contains("admin");
  bool hasRoleString(String role) => roles.map((e) => e.name).contains(role);
  bool hasRole(Role role) => hasRoleString(role.name);

  
  List<Role> get appRoles {
    var _dr = DynamicConfigs.roles;
    return roles.map((e) {
      return _dr.firstWhere((r) => r.name == e.name);
    }).toList();
  }

  List<Permission> get permissions {
    return appRoles.expand((e) => e.permissions).toList();
  }

  bool hasPermission(Permission permission, {String? any_uid}) {
    var stringPermissions = permissions.map((e) {
      return e.key.replaceAll("{uid}", uid).replaceAll("{any_uid}", any_uid ?? "{any_uid}");
    }).toList();
    return stringPermissions.contains(
      permission.key.replaceAll("{uid}", uid).replaceAll("{any_uid}", any_uid ?? "{any_uid}"),
    );
  }

  bool can(String permission, {String? any_uid}) {
    return hasPermission(Permission(key: permission), any_uid: any_uid);
  }

  // for list  (any one of the permission is enough)
  bool canAny(List<String> permissions, {String? any_uid}) {
    return permissions.any((e) => can(e));
  }
}


// can
/// Checks if the current user has the specified permission.
///
/// Returns `true` if the current user has the permission, otherwise `false`.
/// If [any_uid] is provided, it checks if any user with the specified UID has the permission.
/// 
/// Example usage:
/// ```dart
/// bool hasPermission = can('edit_posts');
/// ```
// ignore: non_constant_identifier_names
bool can(String permission, {String? any_uid}) {
  return getCurrentProfile()?.can(
    permission,
    any_uid: any_uid,
  ) ?? false;
}

/// Checks if the current profile has any of the specified permissions.
///
/// Returns `true` if the current profile has any of the specified [permissions].
/// If [any_uid] is provided, it checks if the profile with the given [any_uid]
/// has any of the specified [permissions].
/// Returns `false` if the current profile is null or does not have any of the
/// specified permissions.
///
/// Example usage:
/// ```dart
/// bool result = canAny(['profiles.{any_uid}.read', 'profiles.{any_uid}.write'], any_uid: 'user123');
/// ```
// ignore: non_constant_identifier_names
bool canAny(List<String> permissions, {String? any_uid}) {
  return getCurrentProfile()?.canAny(
    permissions,
    any_uid: any_uid,
  ) ?? false;
}