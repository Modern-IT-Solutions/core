
import 'package:core/core.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';

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
class ModelMnanagerController<M extends Model>
    extends ValueNotifier<ModelMnanagerValue<M>> {
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
    await reload();
  }

  //
  Future<void> search(String query, SearchType type);

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
