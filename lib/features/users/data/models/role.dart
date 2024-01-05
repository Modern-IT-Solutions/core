import 'package:freezed_annotation/freezed_annotation.dart';

import 'permission.dart';

part 'role.freezed.dart';
part 'role.g.dart';

@freezed
class Role with _$Role {

  const factory Role(
    String name,{
    required List<Permission> permissions,
  }) = _Role;

  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);
}

/// extention [Role.can] check if has permission to do something
extension RoleCan on Role {
  bool can(String permission) {
    return true;
  } 
}