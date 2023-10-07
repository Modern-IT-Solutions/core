import 'package:core/core.dart';
import 'package:core/models/address_model.dart';
import 'package:core/temp.dart';

import '../../data/models/role.dart';

abstract class Profile {
  ModelRef get ref;
  String get displayName;
  String get email;
  String? get phoneNumber;
  DateTime? get birthday;
  String get photoUrl;
  AddressModel? get address;
  String get uid;
  bool get disabled;
  List<Role> get roles;
  bool get emailVerified;
  Map<String, dynamic> get metadata;
  Map<String, dynamic> get customClaims;
  DateTime get createdAt;
  DateTime? get updatedAt;
  DateTime? get deletedAt;
  DateTime? get lastSignInAt;
}
