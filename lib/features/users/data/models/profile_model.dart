
import 'package:core/core.dart';
import 'package:core/models/address_model.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'role.dart';


part 'profile_model.freezed.dart';
part 'profile_model.g.dart';

@freezed
class ProfileModel with _$ProfileModel implements Model {
  factory ProfileModel({
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
