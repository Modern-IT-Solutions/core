

import 'dart:convert';

import 'package:core/core.dart';
import 'package:flutter/foundation.dart';


class ListResult<T extends Model> {
  final List<T> items;
  final String? next;
  ListResult({
    required this.items,
    this.next,
  });

  ListResult copyWith({
    List<T>? users,
    String? next,
  }) {
    return ListResult(
      items: users ?? this.items,
      next: next ?? this.next,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'users': items.map((x) => x.toJson()).toList(),
      'next': next,
    };
  }
  static ListResult<T> fromMapWithConverter<T extends Model>({required Map<String,dynamic> map, required T Function(Map<String, dynamic> map) converter}) {
    var list = <T>[];
    for (var i = 0; i < map['users'].length; i++) {
      var userData = Map<String, dynamic>.from(map['users'][i]);
      list.add(converter(userData));
    }
    return ListResult<T>(
      items: list,
      next: map['next'],
    );    
  }

  String toJson() => json.encode(toMap());


  @override
  String toString() => 'ListUsersResult(users: $items, next: $next)';

  @override
  bool operator ==(covariant ListResult other) {
    if (identical(this, other)) return true;

    return listEquals(other.items, items) && other.next == next;
  }

  @override
  int get hashCode => items.hashCode ^ next.hashCode;
}

