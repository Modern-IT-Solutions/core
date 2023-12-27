// ignore_for_file: public_member_api_docs, sort_constructors_first



// /// [UserModel] represents a user of the app.
// class UserModel {
//   final String uid;
//   final String? email;
//   final bool emailVerified;
//   final String? displayName;
//   final String? photoURL;
//   final String? phoneNumber;
//   final bool disabled;
//   final UserMetadatas metadata;
//   final List<UserInfo> providerData;
//   final String? passwordHash;
//   final String? passwordSalt;
//   final Map<String, dynamic> customClaims;
//   final String? tenantId;
//   final String? tokensValidAfterTime;
//   UserModel({
//     required this.uid,
//     this.email,
//     required this.emailVerified,
//     this.displayName,
//     this.photoURL,
//     this.phoneNumber,
//     required this.disabled,
//     required this.metadata,
//     required this.providerData,
//     this.passwordHash,
//     this.passwordSalt,
//     required this.customClaims,
//     this.tenantId,
//     this.tokensValidAfterTime,
//   });

//   Set<Role> get roles {
//     var list = List<String>.from(customClaims['roles'] ?? []);
//     return Set<Role>.from(
//       (list).map<Role>(
//         (x) => Role.values.firstWhere((e) => describeEnum(e) == x, orElse: () {
//           throw FormatException('Unknown role: $x');
//         }),
//       ),
//     );
//   }

//   String? get address  {
//     return customClaims['address'];
//   }

//   // isSupplier
//   bool get isTechnician => roles.contains(Role.technicianL1) || roles.contains(Role.technicianL2) || roles.contains(Role.technicianL3);
//   bool get isAdmin => roles.contains(Role.admin);
//   bool get isClient => roles.contains(Role.client);

//   UserModel copyWith({
//     String? uid,
//     String? email,
//     bool? emailVerified,
//     String? displayName,
//     String? photoURL,
//     String? phoneNumber,
//     bool? disabled,
//     UserMetadatas? metadata,
//     List<UserInfo>? providerData,
//     String? passwordHash,
//     String? passwordSalt,
//     Map<String, dynamic>? customClaims,
//     String? tenantId,
//     String? tokensValidAfterTime,
//   }) {
//     return UserModel(
//       uid: uid ?? this.uid,
//       email: email ?? this.email,
//       emailVerified: emailVerified ?? this.emailVerified,
//       displayName: displayName ?? this.displayName,
//       photoURL: photoURL ?? this.photoURL,
//       phoneNumber: phoneNumber ?? this.phoneNumber,
//       disabled: disabled ?? this.disabled,
//       metadata: metadata ?? this.metadata,
//       providerData: providerData ?? this.providerData,
//       passwordHash: passwordHash ?? this.passwordHash,
//       passwordSalt: passwordSalt ?? this.passwordSalt,
//       customClaims: customClaims ?? this.customClaims,
//       tenantId: tenantId ?? this.tenantId,
//       tokensValidAfterTime: tokensValidAfterTime ?? this.tokensValidAfterTime,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return <String, dynamic>{
//       'uid': uid,
//       'email': email,
//       'emailVerified': emailVerified,
//       'displayName': displayName,
//       'photoURL': photoURL,
//       'phoneNumber': phoneNumber,
//       'disabled': disabled,
//       'metadata': {
//         'creationTime': metadata.creationTime.toString(),
//         'lastSignInTime': metadata.lastSignInTime.toString(),
//       },
//       'providerData': providerData.map((providerData) {
//         return {
//           'displayName': providerData.displayName,
//           'email': providerData.email,
//           'phoneNumber': providerData.phoneNumber,
//           'photoURL': providerData.photoURL,
//           'uid': providerData.uid,
//           'providerId': providerData.providerId,
//         };
//       }).toList(),
//       'passwordHash': passwordHash,
//       'passwordSalt': passwordSalt,
//       'customClaims': customClaims,
//       'tenantId': tenantId,
//       'tokensValidAfterTime': tokensValidAfterTime,
//     };
//   }

//   factory UserModel.fromMap(Map<String, dynamic> map) {
//     String? validPhotoURL;
//     if (map['photoURL'] != null && map['photoURL'].toString().isNotEmpty) {
//       validPhotoURL = map['photoURL'] as String;
//     }
//     return UserModel(
//       uid: map['uid'] as String,
//       email: map['email'] != null ? map['email'] as String : null,
//       emailVerified: map['emailVerified'] as bool,
//       displayName:
//           map['displayName'] != null ? map['displayName'] as String : null,
//       photoURL: validPhotoURL,
//       phoneNumber:
//           map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
//       disabled: map['disabled'] as bool,
//       metadata: map['metadata'] ==null?UserMetadatas(
//         creationTime: DateTime.now(),
//         lastRefreshTime: DateTime.now(),
//         lastSignInTime: DateTime.now(),
//       ): UserMetadatas.fromMap(Map<String,dynamic>.from(map['metadata'])),
//       providerData: List<UserInfo>.from(
//         (map['providerData'] ?? []).map<UserInfo>(
//           (x) => UserInfo.fromMap(Map<String, dynamic>.from(x)),
//         ),
//       ),
//       passwordHash:
//           map['passwordHash'] != null ? map['passwordHash'] as String : null,
//       passwordSalt:
//           map['passwordSalt'] != null ? map['passwordSalt'] as String : null,
//       customClaims: Map<String, dynamic>.from(
//           ( Map<String, dynamic>.from( map['customClaims'] ?? {}))),
//       tenantId: map['tenantId'] != null ? map['tenantId'] as String : null,
//       tokensValidAfterTime: map['tokensValidAfterTime'] != null
//           ? map['tokensValidAfterTime'] as String
//           : null,
//     );
//   }


//   factory UserModel.fromJson(String source) =>
//       UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() {
//     return 'UserRecord(uid: $uid, email: $email, emailVerified: $emailVerified, displayName: $displayName, photoURL: $photoURL, phoneNumber: $phoneNumber, disabled: $disabled, metadata: $metadata, providerData: $providerData, passwordHash: $passwordHash, passwordSalt: $passwordSalt, customClaims: $customClaims, tenantId: $tenantId, tokensValidAfterTime: $tokensValidAfterTime)';
//   }

//   @override
//   bool operator ==(covariant UserModel other) {
//     if (identical(this, other)) return true;

//     return other.uid == uid &&
//         other.email == email &&
//         other.emailVerified == emailVerified &&
//         other.displayName == displayName &&
//         other.photoURL == photoURL &&
//         other.phoneNumber == phoneNumber &&
//         other.disabled == disabled &&
//         other.metadata == metadata &&
//         listEquals(other.providerData, providerData) &&
//         other.passwordHash == passwordHash &&
//         other.passwordSalt == passwordSalt &&
//         mapEquals(other.customClaims, customClaims) &&
//         other.tenantId == tenantId &&
//         other.tokensValidAfterTime == tokensValidAfterTime;
//   }

//   @override
//   int get hashCode {
//     return uid.hashCode ^
//         email.hashCode ^
//         emailVerified.hashCode ^
//         displayName.hashCode ^
//         photoURL.hashCode ^
//         phoneNumber.hashCode ^
//         disabled.hashCode ^
//         metadata.hashCode ^
//         providerData.hashCode ^
//         passwordHash.hashCode ^
//         passwordSalt.hashCode ^
//         customClaims.hashCode ^
//         tenantId.hashCode ^
//         tokensValidAfterTime.hashCode;
//   }

//   @override
//   // TODO: implement ref
//   ModelRef get ref => ModelRef('users/$uid');
// }





