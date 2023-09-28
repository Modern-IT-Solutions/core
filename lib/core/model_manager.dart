// ignore_for_file: public_member_api_docs, sort_constructors_first

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
  Future<void> showDeleteModelDailog(BuildContext context, M model);

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
  String name;
  // fields
  List<String> fields;
  // active
  bool active;
  // local filter
  bool Function(T)? local;
  // remote filter
  QueryBuilder<T> server;
  // onSelect
  void Function(Map<String, QueryFilterInterface<T>> filters)? onSelect;
  // fixed
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
  final Widget label;
  final void Function(M?)? onPressed;
  ModelAction({
    this.icon,
    required this.label,
    this.onPressed,
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
  whereIn,
}

class DynamicQueryFilter<T extends Model> implements QueryFilterInterface<T> {
  bool active;
  bool fixed;
  String name;
  String field;
  QueryOperations operations;
  Object? value;
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
        return (List.from(m.toJson()[field]) as List).any((element) => (value as List).contains(element));
      };
    } else if (operations == QueryOperations.arrayContains) {
      return (T m) {
        // check if the field is a Iterable
        assert(m.toJson()[field] is Iterable);
        // check if the value is a Iterable
        assert(value is Iterable);
        // return true if the field contains any of the values
        return (List.from(m.toJson()[field]) as List).contains(value);
      };
    } else if (operations == QueryOperations.whereIn) {
      return (T m) {
        return (List.from(m.toJson()[field])).contains(value);
      };
    }
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
        return query.where(field,whereIn: value as List);
      };
    } else {
      return (Query<T> query) {
        return query;
      };
    }
  }
  
  
}
