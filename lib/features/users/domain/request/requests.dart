import 'dart:convert';

import 'package:core/core.dart';
import 'package:flutter/foundation.dart';

import '../../data/models/user_provider.dart';
class UserCreateRequest extends UserUpdateRequest implements CreateRequest {
  /// The user's `uid`.
  final String uid;

  /// The user's multi-factor related properties.
  // final MultiFactorCreateSettings? multiFactor;

  UserCreateRequest({
    required this.uid,
    super.disabled,
    super.displayName,
    super.email,
    super.emailVerified,
    super.password,
    super.phoneNumber,
    super.photoURL,
    super.providerToLink,
    super.providersToUnlink,
  }):super(id: uid);
}

class UserUpdateRequest extends UpdateRequest {
  final bool? disabled;
  final String? displayName;
  final String? email;
  final bool? emailVerified;
  final String? password;
  final String? phoneNumber;
  final String? photoURL;
  // multiFactor?: MultiFactorUpdateSettings;
  final UserProviderModel? providerToLink;
  final List<String>? providersToUnlink;
  UserUpdateRequest({
    required super.id,
    this.disabled,
    this.displayName,
    this.email,
    this.emailVerified,
    this.password,
    this.phoneNumber,
    this.photoURL,
    this.providerToLink,
    this.providersToUnlink,
  });

  UserUpdateRequest copyWith({
    bool? disabled,
    String? displayName,
    String? email,
    bool? emailVerified,
    String? password,
    String? phoneNumber,
    String? photoURL,
    UserProviderModel? providerToLink,
    List<String>? providersToUnlink,
  }) {
    return UserUpdateRequest(
      id: id,
      disabled: disabled ?? this.disabled,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      emailVerified: emailVerified ?? this.emailVerified,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photoURL: photoURL ?? this.photoURL,
      providerToLink: providerToLink ?? this.providerToLink,
      providersToUnlink: providersToUnlink ?? this.providersToUnlink,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'disabled': disabled,
      'displayName': displayName,
      'email': email,
      'emailVerified': emailVerified,
      'password': password,
      'phoneNumber': phoneNumber,
      'photoURL': photoURL,
      'providerToLink': providerToLink?.toJson(),
      'providersToUnlink': providersToUnlink,
    };
  }

  factory UserUpdateRequest.fromMap(Map<String, dynamic> map) {
    return UserUpdateRequest(
      id: map['id'].toString(),
      disabled: map['disabled'] != null ? map['disabled'] as bool : null,
      displayName:
          map['displayName'] != null ? map['displayName'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      emailVerified:
          map['emailVerified'] != null ? map['emailVerified'] as bool : null,
      password: map['password'] != null ? map['password'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      photoURL: map['photoURL'] != null ? map['photoURL'] as String : null,
      providerToLink: map['providerToLink'] != null
          ? UserProviderModel.fromMap(map['providerToLink'] as Map<String, dynamic>)
          : null,
      providersToUnlink: map['providersToUnlink'] != null
          ? List<String>.from((map['providersToUnlink'] as List<String>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserUpdateRequest.fromJson(String source) =>
      UserUpdateRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UpdateRequest(disabled: $disabled, displayName: $displayName, email: $email, emailVerified: $emailVerified, password: $password, phoneNumber: $phoneNumber, photoURL: $photoURL, providerToLink: $providerToLink, providersToUnlink: $providersToUnlink)';
  }

  @override
  bool operator ==(covariant UserUpdateRequest other) {
    if (identical(this, other)) return true;

    return other.disabled == disabled &&
        other.displayName == displayName &&
        other.email == email &&
        other.emailVerified == emailVerified &&
        other.password == password &&
        other.phoneNumber == phoneNumber &&
        other.photoURL == photoURL &&
        other.providerToLink == providerToLink &&
        listEquals(other.providersToUnlink, providersToUnlink);
  }

  @override
  int get hashCode {
    return disabled.hashCode ^
        displayName.hashCode ^
        email.hashCode ^
        emailVerified.hashCode ^
        password.hashCode ^
        phoneNumber.hashCode ^
        photoURL.hashCode ^
        providerToLink.hashCode ^
        providersToUnlink.hashCode;
  }
}
