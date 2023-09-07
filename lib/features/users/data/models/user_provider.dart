
import 'dart:convert';

import 'package:core/core.dart';


class UserProviderModel {
  /// The user identifier for the linked provider.
  final String? uid;

  /// The display name for the linked provider.
  final String? displayName;

  /// The email for the linked provider.
  final String? email;

  /// The phone number for the linked provider.
  final String? phoneNumber;

  /// The photo URL for the linked provider.
  final String? photoURL;

  /// The linked provider ID (for example, "google.com" for the Google provider).
  final String? providerId;
  UserProviderModel({
    this.uid,
    this.displayName,
    this.email,
    this.phoneNumber,
    this.photoURL,
    this.providerId,
  });

  UserProviderModel copyWith({
    String? uid,
    String? displayName,
    String? email,
    String? phoneNumber,
    String? photoURL,
    String? providerId,
  }) {
    return UserProviderModel(
      uid: uid ?? this.uid,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photoURL: photoURL ?? this.photoURL,
      providerId: providerId ?? this.providerId,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uid': uid,
      'displayName': displayName,
      'email': email,
      'phoneNumber': phoneNumber,
      'photoURL': photoURL,
      'providerId': providerId,
    };
  }

  factory UserProviderModel.fromMap(Map<String, dynamic> map) {
    return UserProviderModel(
      uid: map['uid'] != null ? map['uid'] as String : null,
      displayName:
          map['displayName'] != null ? map['displayName'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      photoURL: map['photoURL'] != null ? map['photoURL'] as String : null,
      providerId:
          map['providerId'] != null ? map['providerId'] as String : null,
    );
  }


  factory UserProviderModel.fromJson(String source) =>
      UserProviderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserProvider(uid: $uid, displayName: $displayName, email: $email, phoneNumber: $phoneNumber, photoURL: $photoURL, providerId: $providerId)';
  }

  @override
  bool operator ==(covariant UserProviderModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.displayName == displayName &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.photoURL == photoURL &&
        other.providerId == providerId;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        displayName.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        photoURL.hashCode ^
        providerId.hashCode;
  }

  @override
  // TODO: implement ref
  ModelRef get ref => ModelRef('users/$uid');
}
