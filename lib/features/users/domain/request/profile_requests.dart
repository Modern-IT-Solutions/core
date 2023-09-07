// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:core/core/data/requests.dart';

import '../../users.dart';

class ProfileCreateRequest<T extends ProfileModel> extends CreateRequest<T> {
  String? ref;
  /// The name of the user.
  final String? displayName;

  /// The email of the user.
  final String? email;

  /// The phone number of the user.
  final String? phoneNumber;

  /// The photo url of the user.
  final String? photoUrl;

  /// The id of the user.
  final String? uid;

  /// The disabled status of the user.
  final bool disabled;

  /// The email verified status of the user.
  final bool emailVerified;

  /// The role of the user.
  final List<Role> roles;
  ProfileCreateRequest({
    this.ref,
    this.displayName,
    this.email,
    this.phoneNumber,
    this.photoUrl,
    this.uid,
    required this.disabled,
    required this.roles,
    required this.emailVerified,
  });
  
  @override
  Map<String, dynamic> toMap() {
    return {
      'uid':uid,
      'ref': ref,
      "emailVerified": emailVerified,
      'displayName': displayName,
      'email': email,
      'phoneNumber': phoneNumber,
      'photoUrl': photoUrl,
      'disabled': disabled,
      'roles': roles.map((x) => x.name).toList(),
    };
  }
}
class ProfileUpdateRequest<T extends ProfileModel> extends UpdateRequest<T> {

  /// The name of the user.
  final String? displayName;

  /// The email of the user.
  final String? email;

  /// The phone number of the user.
  final String? phoneNumber;

  /// The photo url of the user.
  final String? photoUrl;

  /// The id of the user.
  final String? uid;

  /// The disabled status of the user.
  final bool? disabled;

  /// The role of the user.
  final List<Role>? roles;

  /// The email verified status of the user.
  final bool? emailVerified;

  ProfileUpdateRequest({
    required super.id,
    this.displayName,
    this.emailVerified,
    this.email,
    this.phoneNumber,
    this.photoUrl,
    this.uid,
     this.disabled,
     this.roles,
  });
  
  @override
  Map<String, dynamic> toMap() {
    return {
      'uid':uid,
      'ref': id,
      "emailVerified": emailVerified,
      'displayName': displayName,
      'email': email,
      'phoneNumber': phoneNumber,
      'photoUrl': photoUrl,
      'disabled': disabled,
      'roles': roles?.map((x) => x.name).toList(),
    };
  }
  }

