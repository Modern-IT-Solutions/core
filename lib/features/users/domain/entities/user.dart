// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:intl/intl.dart';

import '../../data/models/user_model.dart';

class User {
  final String uid;
  final String? email;
  final bool emailVerified;
  final String? displayName;
  final String? photoURL;
  final String? phoneNumber;
  final bool disabled;
  final UserMetadatas metadata;
  final List<UserInfo> providerData;
  final String? passwordHash;
  final String? passwordSalt;
  final Map<String, dynamic> customClaims;
  final String? tenantId;
  final String? tokensValidAfterTime;
  User({
    required this.uid,
    this.email,
    required this.emailVerified,
    this.displayName,
    this.photoURL,
    this.phoneNumber,
    required this.disabled,
    required this.metadata,
    required this.providerData,
    this.passwordHash,
    this.passwordSalt,
    required this.customClaims,
    this.tenantId,
    this.tokensValidAfterTime,
  });
}

/// enum for the different roles of the users
// enum Role {
//   admin(0),
//   suplier(1),
//   customer(2);

//   const Role(this.code);
//   final int code;

//   static Role fromString(String? role) {
//     if (role == 'admin') {
//       return Role.admin;
//     } else if (role == 'suplier') {
//       return Role.suplier;
//     } 
//       return Role.customer;
//   }
// }

class UserInfo {
  final String? displayName;
  final String? email;
  final String? phoneNumber;
  final String? photoURL;
  final String providerId;
  final String? uid;
  UserInfo({
    this.displayName,
    this.email,
    this.phoneNumber,
    this.photoURL,
    required this.providerId,
    this.uid,
  });

  UserInfo copyWith({
    String? displayName,
    String? email,
    String? phoneNumber,
    String? photoURL,
    String? providerId,
    String? uid,
  }) {
    return UserInfo(
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photoURL: photoURL ?? this.photoURL,
      providerId: providerId ?? this.providerId,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'displayName': displayName,
      'email': email,
      'phoneNumber': phoneNumber,
      'photoURL': photoURL,
      'providerId': providerId,
      'uid': uid,
    };
  }

  factory UserInfo.fromMap(Map<String, dynamic> map) {
    return UserInfo(
      displayName:
          map['displayName'] != null ? map['displayName'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      photoURL: map['photoURL'] != null ? map['photoURL'] as String : null,
      providerId: map['providerId'] as String,
      uid: map['uid'] != null ? map['uid'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserInfo.fromJson(String source) =>
      UserInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserInfo(displayName: $displayName, email: $email, phoneNumber: $phoneNumber, photoURL: $photoURL, providerId: $providerId, uid: $uid)';
  }

  @override
  bool operator ==(covariant UserInfo other) {
    if (identical(this, other)) return true;

    return other.displayName == displayName &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.photoURL == photoURL &&
        other.providerId == providerId &&
        other.uid == uid;
  }

  @override
  int get hashCode {
    return displayName.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        photoURL.hashCode ^
        providerId.hashCode ^
        uid.hashCode;
  }
}

class UserMetadatas {
  final DateTime creationTime;
  final DateTime lastSignInTime;
  final DateTime lastRefreshTime;
  UserMetadatas({
    required this.creationTime,
    required this.lastSignInTime,
    required this.lastRefreshTime,
  });

  UserMetadatas copyWith({
    DateTime? creationTime,
    DateTime? lastSignInTime,
    DateTime? lastRefreshTime,
  }) {
    return UserMetadatas(
      creationTime: creationTime ?? this.creationTime,
      lastSignInTime: lastSignInTime ?? this.lastSignInTime,
      lastRefreshTime: lastRefreshTime ?? this.lastRefreshTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'creationTime': creationTime.millisecondsSinceEpoch,
      'lastSignInTime': lastSignInTime.millisecondsSinceEpoch,
      'lastRefreshTime': lastRefreshTime.millisecondsSinceEpoch,
    };
  }

  factory UserMetadatas.fromMap(Map<String, dynamic> map) {
    DateTime parse(dynamic data) {
      try {
        if (data is int) {
          return DateTime.fromMillisecondsSinceEpoch(data);
        }
        return DateFormat('EEE, d MMM y H:m:s \'GMT\'').parse(data);
      } catch (e) {}
      return DateTime(0);
    }

    return UserMetadatas(
      creationTime: parse(map['creationTime']),
      lastSignInTime: parse(map['lastSignInTime']),
      lastRefreshTime: parse(map['lastRefreshTime']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserMetadatas.fromJson(String source) =>
      UserMetadatas.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'UserMetadata(creationTime: $creationTime, lastSignInTime: $lastSignInTime, lastRefreshTime: $lastRefreshTime)';

  @override
  bool operator ==(covariant UserMetadatas other) {
    if (identical(this, other)) return true;

    return other.creationTime == creationTime &&
        other.lastSignInTime == lastSignInTime &&
        other.lastRefreshTime == lastRefreshTime;
  }

  @override
  int get hashCode =>
      creationTime.hashCode ^
      lastSignInTime.hashCode ^
      lastRefreshTime.hashCode;
}
