// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';

import 'package:core/core.dart';

/// [ModelMnanagerValue]
@immutable
class ModelMnanagerValue<M extends Model> {
  /// [loading] is a bool to show loading indicator
  final bool loading;

  /// [models] is a list of models
  final ListResult<M>? models;

  /// [SearchQuery]
  final SearchQuery? searchQuery;

  const ModelMnanagerValue({
    this.loading = false,
    this.models,
    this.searchQuery,
  });
}

/// [ModelMnanagerController] is a controller to refresh the view
class ModelMnanagerController<M extends Model> extends ValueNotifier<ModelMnanagerValue<M>> {
  ModelMnanagerController() : super(const ModelMnanagerValue());

  void refresh() {}
}

/// [ModelMnanagerView] an interface
abstract class ModelMnanagerView<M extends Model> extends StatefulWidget {
  /// repository
  RepositoryInterface<M> get repository;

  const ModelMnanagerView({
    super.key,
  });
}

enum ModelMnanagerStatus {
  loading,
}

enum ModelMnanagerEvents {
  inited,
  load,
  loaded,
  search,
  searched,
}

/// [showCreateModelDailog] and [showUpdateModelDailog] and [showDeleteModelDailog] are functions to show dialogs
/// it can be in mixins coled [ModelMnanagerViewMixin]
mixin ModelMnanagerViewMixin<M extends Model> {
  ValueNotifier<bool> loading = ValueNotifier(false);
  ValueNotifier<ListResult<M>?> models = ValueNotifier(null);
  TextEditingController searchController = TextEditingController();

  // load
  Future<void> load();

  // load
  Future<void> reload() async {
    await load();
  }

  // update station
  Future<void> showCreateModelDailog(BuildContext context);

  // update station
  Future<void> showUpdateModelDailog(BuildContext context, M model);

  // delete station, a simple dialog with a text and two buttons
  // Future<void> showDeleteModelDailog(BuildContext context, M model) async {}

  // show details, a simple dialog with a text and two buttons
  Future<void> showDetailsModelDailog(BuildContext context, M model);
}

///
mixin SearchType on Enum {
  IconData get icon;
  String get field => name;
}

typedef QueryBuilder<T> = Query<T> Function(Query<T> query);

abstract class QueryFilterInterface<T extends Model> {
  // local filter
  bool Function(T)? get local;
  // remote filter
  QueryBuilder<T> get server;
  bool get active;
  set active(bool value);
  bool get fixed;
  set fixed(bool value);
  String get name;
  set name(String value);
  // onSelect
  void Function(Map<String, QueryFilterInterface<T>> filters)? get onSelect;
}

/// QueryFilter
class QueryFilter<T extends Model> implements QueryFilterInterface<T> {
  // name
  @override
  String name;
  // fields
  List<String> fields;
  // active
  @override
  bool active;
  // local filter
  @override
  bool Function(T)? local;
  // remote filter
  @override
  QueryBuilder<T> server;
  // onSelect
  @override
  void Function(Map<String, QueryFilterInterface<T>> filters)? onSelect;
  // fixed
  @override
  bool fixed;

  QueryFilter({
    required this.name,
    this.local,
    this.active = true,
    required this.server,
    this.onSelect,
    this.fixed = false,
    required this.fields,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QueryFilter<T> && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}

class ModelAction<M extends Model> {
  final Widget? icon;
  final String? group;
  final String label;
  final FutureOr<M?> Function(BuildContext, M?)? single;
  final FutureOr<List<M>?> Function(BuildContext, List<M>?)? multiple;
  const ModelAction({
    this.icon,
    required this.label,
    this.group,
    this.single,
    this.multiple,
  });
}

enum QueryOperations {
  equal,
  notEqual,
  lessThan,
  lessThanOrEqual,
  greaterThan,
  greaterThanOrEqual,
  arrayContains,
  arrayContainsAny,
  whereIn;

  Query<Map<String, dynamic>> remote({required Query<Map<String, dynamic>> query, required String field, required dynamic value}) {
    if (value is DateTime) value = Timestamp.fromDate(value);
    if (this == QueryOperations.equal) {
      query = query.where(field, isEqualTo: value);
    } else if (this == QueryOperations.notEqual) {
      query = query.where(field, isNotEqualTo: value).orderBy(field, descending: true);
    } else if (this == QueryOperations.lessThan) {
      query = query.where(field, isLessThan: value).orderBy(field, descending: true);
    } else if (this == QueryOperations.lessThanOrEqual) {
      query = query.where(field, isLessThanOrEqualTo: value).orderBy(field, descending: true);
    } else if (this == QueryOperations.greaterThan) {
      query = query.where(field, isGreaterThan: value).orderBy(field, descending: true);
    } else if (this == QueryOperations.greaterThanOrEqual) {
      query = query.where(field, isGreaterThanOrEqualTo: value).orderBy(field, descending: true);
    } else if (this == QueryOperations.arrayContainsAny) {
      query = query.where(field, arrayContainsAny: value.toString().split("|"));
    } else if (this == QueryOperations.arrayContains) {
      query = query.where(field, arrayContains: value);
    } else if (this == QueryOperations.whereIn) {
      query = query.where(field, whereIn: value.toString().split("|"));
    } else {
      query = query.where(field, isEqualTo: value);
    }
    return query;
  }

  bool local<T extends Model>({required T model, required String field, required dynamic value}) {
    try {
      dynamic fieldValue = model.toJson()[field];
      if (fieldValue == null) return false;
      if (fieldValue is Timestamp) fieldValue = fieldValue.toDate();
      if (fieldValue is DateTime) fieldValue = fieldValue.millisecondsSinceEpoch;
      if (value is Timestamp) value = value.toDate();
      if (value is DateTime) value = value.millisecondsSinceEpoch;
      // return true;
      if (this == QueryOperations.equal) {
        return fieldValue == value;
      } else if (this == QueryOperations.notEqual) {
        return fieldValue != value;
      } else if (this == QueryOperations.lessThan) {
        return fieldValue < value;
      } else if (this == QueryOperations.lessThanOrEqual) {
        return fieldValue <= value;
      } else if (this == QueryOperations.greaterThan) {
        return fieldValue > value;
      } else if (this == QueryOperations.greaterThanOrEqual) {
        return fieldValue >= value;
      } else if (this == QueryOperations.arrayContainsAny) {
        // check if the field is a Iterable
        assert(fieldValue is Iterable);
        // check if the value is a Iterable
        assert(value is Iterable);
        // return true if the field contains any of the values
        return (List.from(fieldValue)).any((element) => (value as List).contains(element));
      } else if (this == QueryOperations.arrayContains) {
        // check if the field is a Iterable
        assert(fieldValue is Iterable);
        // check if the value is a Iterable
        assert(value is Iterable);
        // return true if the field contains any of the values
        return (List.from(fieldValue)).contains(value);
      } else if (this == QueryOperations.whereIn) {
        return (List.from(fieldValue)).contains(value);
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  // symbol
  String get symbol {
    if (this == QueryOperations.equal) {
      return "=";
    } else if (this == QueryOperations.notEqual) {
      return "!=";
    } else if (this == QueryOperations.lessThan) {
      return "<";
    } else if (this == QueryOperations.lessThanOrEqual) {
      return "<=";
    } else if (this == QueryOperations.greaterThan) {
      return ">";
    } else if (this == QueryOperations.greaterThanOrEqual) {
      return ">=";
    } else if (this == QueryOperations.arrayContainsAny) {
      return "array-contains-any";
    } else if (this == QueryOperations.arrayContains) {
      return "array-contains";
    } else if (this == QueryOperations.whereIn) {
      return "in";
    } else {
      return "=";
    }
  }
}

class DynamicQueryFilter<T extends Model> implements QueryFilterInterface<T> {
  @override
  bool active;
  @override
  bool fixed;
  @override
  String name;
  String field;
  QueryOperations operations;
  Object? value;
  @override
  void Function(Map<String, QueryFilterInterface<T>> filters)? onSelect;
  DynamicQueryFilter({
    required this.name,
    required this.field,
    required this.active,
    required this.fixed,
    required this.operations,
    required this.value,
    this.onSelect,
  });

  @override
  bool Function(T model)? get local {
    if (operations == QueryOperations.equal) {
      return (T m) {
        return m.toJson()[field] == value;
      };
    } else if (operations == QueryOperations.notEqual) {
      return (T m) {
        return m.toJson()[field] != value;
      };
    } else if (operations == QueryOperations.lessThan) {
      return (T m) {
        return m.toJson()[field] < value;
      };
    } else if (operations == QueryOperations.lessThanOrEqual) {
      return (T m) {
        return m.toJson()[field] <= value;
      };
    } else if (operations == QueryOperations.greaterThan) {
      return (T m) {
        return m.toJson()[field] > value;
      };
    } else if (operations == QueryOperations.greaterThanOrEqual) {
      return (T m) {
        return m.toJson()[field] >= value;
      };
    } else if (operations == QueryOperations.arrayContainsAny) {
      return (T m) {
        // check if the field is a Iterable
        assert(m.toJson()[field] is Iterable);
        // check if the value is a Iterable
        assert(value is Iterable);
        // return true if the field contains any of the values
        return (List.from(m.toJson()[field])).any((element) => (value as List).contains(element));
      };
    } else if (operations == QueryOperations.arrayContains) {
      return (T m) {
        // check if the field is a Iterable
        assert(m.toJson()[field] is Iterable);
        // check if the value is a Iterable
        assert(value is Iterable);
        // return true if the field contains any of the values
        return (List.from(m.toJson()[field])).contains(value);
      };
    } else if (operations == QueryOperations.whereIn) {
      return (T m) {
        return (List.from(m.toJson()[field])).contains(value);
      };
    }
    return null;
  }

  @override
  QueryBuilder<T> get server {
    if (operations == QueryOperations.equal) {
      return (Query<T> query) {
        return query.where(field, isEqualTo: value);
      };
    } else if (operations == QueryOperations.notEqual) {
      return (Query<T> query) {
        return query.where(field, isNotEqualTo: value);
      };
    } else if (operations == QueryOperations.lessThan) {
      return (Query<T> query) {
        return query.where(field, isLessThan: value);
      };
    } else if (operations == QueryOperations.lessThanOrEqual) {
      return (Query<T> query) {
        return query.where(field, isLessThanOrEqualTo: value);
      };
    } else if (operations == QueryOperations.greaterThan) {
      return (Query<T> query) {
        return query.where(field, isGreaterThan: value);
      };
    } else if (operations == QueryOperations.greaterThanOrEqual) {
      return (Query<T> query) {
        return query.where(field, isGreaterThanOrEqualTo: value);
      };
    } else if (operations == QueryOperations.arrayContainsAny) {
      return (Query<T> query) {
        return query.where(field, arrayContainsAny: value as List);
      };
    } else if (operations == QueryOperations.arrayContains) {
      return (Query<T> query) {
        return query.where(field, arrayContains: value);
      };
    } else if (operations == QueryOperations.whereIn) {
      return (Query<T> query) {
        return query.where(field, whereIn: value as List);
      };
    } else {
      return (Query<T> query) {
        return query;
      };
    }
  }
}
