
import 'package:core/core.dart';

import 'package:freezed_annotation/freezed_annotation.dart';


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
    DateTime? birthday,
    @Default("") String photoUrl,
    required Address? address,
    required String uid,
    required bool disabled,
    required List<Role> roles,
    required bool emailVerified,
    @Default({}) Map<String,dynamic> metadata,
    @Default({}) Map<String,dynamic> customClaims,
    @TimestampDateTimeSerializer()
    required DateTime createdAt,
    @TimestampDateTimeSerializer()
    required DateTime updatedAt,
    @TimestampDateTimeSerializer()
    DateTime? deletedAt,
    @TimestampDateTimeSerializer()
    DateTime? lastSignInAt,
  }) = _ProfileModel;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => _$ProfileModelFromJson(json);
}


/// [Role] is an enum that represents the role of the user.
/// it contains :  [ClientModel], [Technician], [Commercial], [Admin]
enum Role {
  /// Role.client
  student,
  /// Role.client
  client,

  /// Role.technician
  technicianL1,
  technicianL2,
  technicianL3,

  /// Role.commercial
  commercial,

  /// Role.admin
  admin;

  /// fromString
  static Role? fromString(String? role) {
    var r = Role.values.where(
      (e) => e.name == role,
    );
    if (r.isNotEmpty) {
      return r.first;
    } else {
      return null;
    }
  }

  /// fromListString
  static List<Role> fromListString(List<String> roles) {
    return roles.map((e) => fromString(e)!).toList();
  }
}



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
  String? get fcmTokens => metadata['fcmTokens'];

  /// set the fcm token
  set fcmTokens(String? tokens) {
    metadata['fcmTokens'] = tokens;
  }
}
