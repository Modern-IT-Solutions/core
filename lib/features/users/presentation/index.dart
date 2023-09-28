import 'package:feather_icons/feather_icons.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:lib/lib.dart';
import 'package:recase/recase.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:visibility_detector/visibility_detector.dart';

import 'package:core/core.dart';

import 'find.dart';
import 'forms/create_profile.dart';
import 'forms/update_profile.dart';

/// [ProfilesSearchType] is a class to build a query to search
enum ProfilesSearchType implements SearchType {
  name,
  email;

  IconData get icon {
    switch (this) {
      case ProfilesSearchType.name:
        return FeatherIcons.user;
      case ProfilesSearchType.email:
        return FeatherIcons.mail;
    }
  }

  String get field {
    if (this == ProfilesSearchType.name) {
      return "displayName";
    } else {
      return "email";
    }
  }
}

/// [ManageProfilesView] is a tab for stations
class ManageProfilesView<M extends ProfileModel> extends ModelMnanagerView<M> {
  final ProfileRepositoryInterface<M> repository;
  final Map<String, QueryFilterInterface<M>> filters;
  final List<ModelAction<M>> actions;

  ManageProfilesView({
    super.key,
    this.filters = const {},
    this.actions = const [],
  }) : repository = ProfileRepository.instance as ProfileRepositoryInterface<M>;

  @override
  State<ManageProfilesView> createState() => ManageProfilesViewState<M>();
}

class ManageProfilesViewState<M extends ProfileModel> extends State<ManageProfilesView> with ModelMnanagerViewMixin<M> {
  var searchType = ValueNotifier(ProfilesSearchType.email);
  Map<String, QueryFilterInterface<M>> filters = {};

  @override
  void initState() {
    super.initState();
    filters['All'] = QueryFilter(
      name: 'All',
      fields: [],
      server: (query) => query,
      active: !widget.filters.values.any((element) => element.active),
      onSelect: (filters) {
        for (var filter in filters.keys.where((e) => e != 'All')) {
          filters[filter]?.active= false;
        }
      },
      fixed: true,
    );
    // filters = widget.filters;
    filters.addAll(widget.filters as Map<String, QueryFilterInterface<M>>);
    for (var filter in activeFilters) {
      filter.onSelect?.call(filters);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      load();
    });
  }

  List<QueryFilterInterface<M>> get activeFilters {
    return filters.values.where((element) => element.active).toList();
  }

  Map<DateTime, bool> history = {};
  DateTime? get currentStartAt => history.keys.lastOrNull;

  bool get hasNext => filteredModels.isNotEmpty && nextStartAt != null && nextStartAt != currentStartAt;
  DateTime? get nextStartAt => models.value?.items.lastOrNull?.updatedAt;

  // prevStartAt
  DateTime? get prevStartAt {
    // index of latest item
    var index = models.value?.items.indexWhere((element) => element.updatedAt == currentStartAt);
    if (index != null && index > 0) {
      return models.value?.items[index - 1].updatedAt;
    }
    return null;
  }

  bool get hasPrev => prevStartAt != null && prevStartAt != currentStartAt;

  @override
  Future<void> load() async {
    return search();
  }

  /// [search] is a function to search for profiles
  /// it takes a [query] and a [type] to search by
  Future<void> search({String? query, SearchType? type, Iterable<Timestamp>? startAfter}) async {
    if (loading.value) {
      return;
    }
    loading.value = true;
    var concat = false;
    try {
      if (startAfter != null && startAfter.isNotEmpty == true) {
        history[startAfter.first.toDate()] = true;
        concat = true;
      }

      ListResult<M> data = (await widget.repository.list(
        ListRequest(
            searchQuery: query != null && query.isNotEmpty && type != null ? SearchQuery(field: type.name, value: query) : null,
            queryBuilder: (query) {
              for (QueryFilterInterface<M> filter in activeFilters) {
                query = filter.server(query as Query<M>);
              }
              query = query.orderBy("updatedAt", descending: true);
              if (startAfter != null) {
                query = query.startAfter(startAfter);
              }
              return query;
            },
            limit: 10,
            options: const GetOptions(
              source: Source.server,
            )),
      )) as ListResult<M>;
      if (concat) {
        models.value = ListResult(
          items: [
            ...models.value!.items,
            ...data.items
          ],
        );
      } else {
        models.value = data;
      }
    } catch (e) {
      print(e);
    }
    loading.value = false;
  }

  List<ProfileModel> get filteredModels {
    if (models.value == null) {
      return [];
    }
    bool _filters(ProfileModel model) {
      for (var filter in activeFilters) {
        if (filter.local != null) {
          if (filter.local!(model as M) == false) {
            return false;
          }
        }
      }
      return true;
    }

    if (searchController.text.isEmpty) {
      return models.value!.items.where(_filters).toList();
    }
    // search in display name and email and phone number and uid
    return models.value!.items.where((profile) {
      var query = searchController.text.toLowerCase();
      if (!_filters(profile)) {
        return false;
      }
      return profile.toString().toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([
        loading,
        models
      ]),
      builder: (context, _) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                SizedBox(
                  child: FilledButton.icon(
                    onPressed: () => showCreateModelDailog(context),
                    label: const Text('Add'),
                    icon: const Icon(FeatherIcons.plus),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: AppTextFormField.min(
                    // enabled: !loading.value,
                    onSubmitted: (String value) {
                      search(query: value, type: searchType.value);
                    },
                    controller: searchController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(FluentIcons.search_24_regular),
                      label: const Text('Search'),
                      alignLabelWithHint: true,
                      suffixIcon: ListenableBuilder(
                          listenable: searchType,
                          builder: (context, _) {
                            return MenuAnchor(
                              builder: (context, controller, __) {
                                return TextButton.icon(
                                  icon: const Icon(
                                    FluentIcons.filter_24_regular,
                                  ),
                                  onPressed: () => controller.open(),
                                  label: Text(searchType.value.name.titleCase),
                                );
                              },
                              menuChildren: [
                                for (var type in ProfilesSearchType.values)
                                  MenuItemButton(
                                    leadingIcon: Icon(type.icon),
                                    trailingIcon: searchType.value == type ? const Icon(FluentIcons.checkmark_24_regular) : null,
                                    onPressed: searchType.value == type
                                        ? null
                                        : () {
                                            searchType.value = type;
                                          },
                                    child: Text(type.name.titleCase),
                                  ),
                              ],
                            );
                          }),
                    ),
                  ),
                ),
              ],
            ),
            // row of filters using chips, each chip is a filter can be remove
            // if no filters, hide this row
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                width: double.infinity,
                child: Wrap(
                  spacing: 8,
                  children: [
                    for (var filter in filters.values)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            filters[filter.name]?.active = !(filters[filter.name]?.active ?? false);
                            filters[filter.name]!.onSelect?.call(filters);
                            search();
                          });
                        },
                        child: Chip(
                          label: Text(filter.name),
                          backgroundColor: filter.active ? Theme.of(context).colorScheme.primary : null,
                          side: filter.active ? const BorderSide(color: Colors.transparent) : BorderSide(color: Theme.of(context).colorScheme.onSurface.withOpacity(.12)),
                          labelStyle: TextStyle(color: filter.active ? Theme.of(context).colorScheme.onPrimary : null),
                          deleteIcon: filter.fixed
                              ? null
                              : const Icon(
                                  FluentIcons.dismiss_24_regular,
                                  size: 15,
                                ),
                          deleteIconColor: filter.active ? Theme.of(context).colorScheme.onPrimary : null,
                          onDeleted: filter.fixed
                              ? null
                              : () {
                                  setState(() {
                                    filters.remove(filter.name);
                                    search();
                                  });
                                },
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // table of profiles, profile is the same as firebase
            // use ListTile for each profile
            FlexTable(
              selectable: false,
              scrollable: false,
              // the space bitween each item called gap
              configs: const [
                FlexTableItemConfig.square(30),
                FlexTableItemConfig.flex(2),
                FlexTableItemConfig.flex(2),
                FlexTableItemConfig.flex(2),
                FlexTableItemConfig.square(40),
              ],
              child: ListenableBuilder(
                listenable: searchController,
                builder: (context, child) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: FlexTableItem(
                          children: [
                            SizedBox(),
                            Text(
                              'Name',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            // create at
                            Text(
                              'Last Update',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Text(
                              'Roles',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            SizedBox(),
                          ],
                        ),
                      ),
                      loading.value ? const LinearProgressIndicator(minHeight: 2) : const Divider(height: 2),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (models.value != null)
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: filteredModels.length,
                              itemBuilder: (context, index) {
                                var model = filteredModels[index];
                                return InkWell(
                                  highlightColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                  focusColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                  hoverColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                  borderRadius:

                                      //  BorderRadius.circular(8),
                                      // in first
                                      index == 0
                                          ? const BorderRadius.only(
                                              bottomLeft: Radius.circular(8),
                                              bottomRight: Radius.circular(8),
                                            )
                                          : BorderRadius.circular(8),
                                  onTap: () {
                                    showDetailsModelDailog(context, model);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                                    child: FlexTableItem(
                                      children: [
                                        CircleAvatar(
                                          radius: 15,
                                          backgroundImage: NetworkImage(model.photoUrl),
                                          child: model.photoUrl.isEmpty
                                              ? Text(
                                                  model.displayName.trim().isNotEmpty == true ? model.displayName.trim()[0].toUpperCase() : "?",
                                                  style: const TextStyle(fontSize: 18),
                                                )
                                              : null,
                                        ),
                                        Text(
                                          model.displayName.isNotEmpty ? model.displayName : "(No name)",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        // roles

                                        Text(
                                          timeago.format(model.updatedAt.toLocal()),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          width: 70,
                                          child: Wrap(
                                            spacing: 5,
                                            children: [
                                              for (var role in model.roles) Text(role.name)
                                            ],
                                          ),
                                        ),
                                        MenuAnchor(
                                          builder: (context, controller, child) {
                                            return IconButton(
                                              onPressed: () {
                                                if (controller.isOpen) {
                                                  controller.close();
                                                } else {
                                                  controller.open();
                                                }
                                              },
                                              icon: const Icon(Icons.more_vert),
                                            );
                                          },
                                          menuChildren: [
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            if (widget.actions.isNotEmpty) ...[
                                              for (var action in widget.actions)
                                                MenuItemButton(
                                                  onPressed: () => action.onPressed?.call(model),
                                                  leadingIcon: action.icon,
                                                  child: action.label,
                                                ),
                                              const Divider(),
                                            ],
                                            MenuItemButton(
                                              onPressed: () {},
                                              leadingIcon: const Icon(FluentIcons.person_tag_28_regular),
                                              child: const Text('change roles'),
                                            ),
                                            const Divider(),
                                            MenuItemButton(
                                              onPressed: () {
                                                showUpdateModelDailog(context, model);
                                              },
                                              leadingIcon: const Icon(FluentIcons.edit_28_regular),
                                              child: const Text('Edit'),
                                            ),
                                            MenuItemButton(
                                              onPressed: () {
                                                showDeleteModelDailog(context, model);
                                              },
                                              leadingIcon: Icon(
                                                FluentIcons.delete_28_regular,
                                                color: Theme.of(context).colorScheme.error,
                                              ),
                                              child: Text(
                                                'Remove',
                                                style: TextStyle(color: Theme.of(context).colorScheme.error),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          Center(
                            child: SizedBox(
                              height: 80,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (loading.value)
                                    Container(
                                      margin: const EdgeInsets.all(24.0),
                                      height: 20,
                                      width: 20,
                                      child: const CircularProgressIndicator.adaptive(strokeWidth: 2),
                                    )
                                  else ...[
                                    if (models.value != null && models.value!.items.isEmpty)
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 24.0,
                                              horizontal: 12,
                                            ),
                                            child: Text('No profiles found'),
                                          ),
                                          // refresh
                                          OutlinedButton(
                                            onPressed: load,
                                            child: const Text("Refresh"),
                                          )
                                        ],
                                      )
                                    else if (hasNext)
                                      VisibilityDetector(
                                        key: Key(nextStartAt.toString()),
                                        onVisibilityChanged: (info) {
                                          if (info.visibleFraction > 0) {
                                            search(startAfter: [
                                              Timestamp.fromDate(nextStartAt!)
                                            ]);
                                          }
                                        },
                                        child: OutlinedButton(
                                          onPressed: () async {
                                            await search(startAfter: [
                                              Timestamp.fromDate(nextStartAt!)
                                            ]);
                                          },
                                          child: const Text("load more"),
                                        ),
                                      )
                                    else
                                    // you reached the end text
                                    if (models.value != null && models.value!.items.isNotEmpty)
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 24.0,
                                          horizontal: 12,
                                        ),
                                        child: Text('You reached the end.'),
                                      )
                                  ]
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  // update station
  Future<void> showCreateModelDailog(BuildContext context) async {
    var child = Container(
      constraints: const BoxConstraints(maxWidth: 500),
      child: CreateProfileForm(
        onCreated: (station) {
          ScaffoldMessenger.maybeOf(context)?.showSnackBar(
            SnackBar(
                behavior: SnackBarBehavior.floating,
                width: 400.0,
                content: Text('Profile ${station.displayName} updated'),
                action: SnackBarAction(
                  label: 'Show',
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    showUpdateModelDailog(context, station);
                  },
                )),
          );
          Navigator.of(context).pop();
          load();
        },
      ),
    );
    await showDialog(
      context: context,
      builder: (context) {
        if (MediaQuery.of(context).size.width > 600)
          return Dialog(
            clipBehavior: Clip.antiAlias,
            child: child,
          );
        else
          return Dialog.fullscreen(
            child: child,
          );
      },
    );
  }

  // update station
  Future<void> showUpdateModelDailog(BuildContext context, ProfileModel station) async {
    var child = Container(
      constraints: const BoxConstraints(maxWidth: 500),
      child: UpdateProfileForm(
        model: station,
        onUpdated: (station) {
          ScaffoldMessenger.maybeOf(context)?.showSnackBar(
            SnackBar(
                behavior: SnackBarBehavior.floating,
                width: 400.0,
                content: Text('Profile ${station.displayName} updated'),
                action: SnackBarAction(
                  label: 'Show',
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    showUpdateModelDailog(context, station as M);
                  },
                )),
          );
          Navigator.of(context).pop();
          load();
        },
      ),
    );
    await showDialog(
      context: context,
      builder: (context) {
        if (MediaQuery.of(context).size.width > 600)
          return Dialog(
            clipBehavior: Clip.antiAlias,
            child: child,
          );
        else
          return Dialog.fullscreen(
            child: child,
          );
      },
    );
  }

  // delete station, a simple dialog with a text and two buttons
  Future<void> showDeleteModelDailog(BuildContext context, ProfileModel model) async {
    bool _loading = false;
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm delete'),
        content: const Text('this action cannot be undone, are you sure you want to continue?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          StatefulBuilder(builder: (context, setState) {
            return TextButton(
              onPressed: _loading
                  ? null
                  : () async {
                      setState(() {
                        _loading = true;
                      });
                      try {
                        await widget.repository.delete(DeleteRequest(model.ref.id));
                        ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                          SnackBar(
                              behavior: SnackBarBehavior.floating,
                              width: 400.0,
                              content: Text('${model.ref.id} deleted'),
                              action: SnackBarAction(
                                label: 'Close',
                                onPressed: () {
                                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                },
                              )),
                        );
                        Navigator.of(context).pop();
                        load();
                      } catch (e) {}
                      setState(() {
                        _loading = false;
                      });
                    },
              child: _loading ? const CircularProgressIndicator.adaptive() : const Text('Delete'),
            );
          }),
        ],
      ),
    );
  }

  @override
  Future<void> showDetailsModelDailog(BuildContext context, ProfileModel model) async {
    var child = Container(
      constraints: const BoxConstraints(maxWidth: 500),
      child: FindProfileForm(
        id: model.ref.id,
        model: model,
        actions: [
          // edit
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
              showUpdateModelDailog(context, model);
            },
            icon: const Icon(FluentIcons.edit_16_regular),
          ),
          const SizedBox(
            width: 8,
          ),
        ],
      ),
    );
    await showDialog(
      context: context,
      builder: (context) {
        if (MediaQuery.of(context).size.width > 600)
          return Dialog(
            clipBehavior: Clip.antiAlias,
            child: child,
          );
        else
          return Dialog.fullscreen(
            child: child,
          );
      },
    );
  }
}
