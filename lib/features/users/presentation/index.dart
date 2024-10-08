// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'dart:math';

import 'package:flutter/services.dart';

import 'package:feather_icons/feather_icons.dart';

import 'package:file_saver/file_saver.dart';

import 'package:intl/intl.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import 'package:flutter/material.dart';

import 'package:muskey/muskey.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:lib/lib.dart';

import 'package:recase/recase.dart';

import 'package:timeago/timeago.dart' as timeago;

import 'package:visibility_detector/visibility_detector.dart';

import 'package:gradient_borders/gradient_borders.dart';

import 'package:core/core.dart';

import 'package:core/services/defaults/helpers.dart';

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

  Map<String, List<ModelAction<M>>> get groupedActions {
    var map = <String, List<ModelAction<M>>>{};

    for (var action in actions) {
      if (action.group == null) {
        continue;
      }

      if (map.containsKey(action.group)) {
        map[action.group]!.add(action);
      } else {
        map[action.group!] = [
          action
        ];
      }
    }

    return map;
  }

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
          filters[filter]?.active = false;
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

              query = query.orderBy("updatedAt", descending: false);

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
                                            if (widget.groupedActions.keys.isNotEmpty) ...[
                                              for (var group in widget.groupedActions.keys) ...[
                                                for (var action in widget.groupedActions[group]!)
                                                  MenuItemButton(
                                                    onPressed: () async {
                                                      var updatedModel = await action.single?.call(context, model);

                                                      if (updatedModel != null) {
                                                        // con
                                                      }
                                                    },
                                                    leadingIcon: action.icon,
                                                    child: Text(action.label),
                                                  ),
                                                const Divider()
                                              ]
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
                                                'Remove?',
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
                                      height: 15,
                                      width: 15,
                                      child: const CircularProgressIndicator.adaptive(strokeWidth: 2, strokeCap: StrokeCap.round),
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
                                            child: Text('Nothing to show'),
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
                                        child: OutlinedButton.icon(
                                          onPressed: () async {
                                            await search(startAfter: [
                                              Timestamp.fromDate(nextStartAt!)
                                            ]);
                                          },
                                          label: const Text("LOAD MORE"),
                                          icon: const Icon(FluentIcons.chevron_down_24_regular),
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
        onCreated: (model) {
          ScaffoldMessenger.maybeOf(context)?.showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              width: 400.0,
              content: Text('Profile ${model.displayName} updated'),
              action: SnackBarAction(
                label: 'Show',
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();

                  showUpdateModelDailog(context, model);
                },
              ),
            ),
          );

          Navigator.of(context).pop();

          // load();
        },
      ),
    );

    await showDialog(
      context: context,
      builder: (context) {
        if (MediaQuery.of(context).size.width > 600) {
          return Dialog(
            clipBehavior: Clip.antiAlias,
            child: child,
          );
        } else {
          return Dialog.fullscreen(
            child: child,
          );
        }
      },
    );
  }

  // update station

  Future<void> showUpdateModelDailog(BuildContext context, ProfileModel model) async {
    var child = Container(
      constraints: const BoxConstraints(maxWidth: 500),
      child: Center(
        child: UpdateProfileForm(
          model: model,
          onUpdated: (model) {
            ScaffoldMessenger.maybeOf(context)?.showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                width: 400.0,
                content: Text('Profile ${model.displayName} updated'),
                action: SnackBarAction(
                  label: 'Show',
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();

                    showUpdateModelDailog(context, model as M);
                  },
                ),
              ),
            );

            Navigator.of(context).pop();

            // load();
          },
        ),
      ),
    );

    await showDialog(
      context: context,
      builder: (context) {
        if (MediaQuery.of(context).size.width > 600) {
          return Dialog(
            clipBehavior: Clip.antiAlias,
            child: child,
          );
        } else {
          return Dialog.fullscreen(
            child: child,
          );
        }
      },
    );
  }

  // // delete station, a simple dialog with a text and two buttons

  // Future<void> showDeleteModelDailog(BuildContext context, ProfileModel model) async {

  //   bool _loading = false;

  //   await showDialog(

  //     context: context,

  //     builder: (context) => AlertDialog(

  //       title: const Text('Confirm delete'),

  //       content: const Text('this action cannot be undone, are you sure you want to continue?'),

  //       actions: [

  //         TextButton(

  //           onPressed: () {

  //             Navigator.of(context).pop();

  //           },

  //           child: const Text('Cancel'),

  //         ),

  //         StatefulBuilder(builder: (context, setState) {

  //           return TextButton(

  //             onPressed: _loading

  //                 ? null

  //                 : () async {

  //                     setState(() {

  //                       _loading = true;

  //                     });

  //                     try {

  //                       await widget.repository.delete(DeleteRequest(model.ref.id));

  //                       ScaffoldMessenger.maybeOf(context)?.showSnackBar(

  //                         SnackBar(

  //                             behavior: SnackBarBehavior.floating,

  //                             width: 400.0,

  //                             content: Text('${model.ref.id} deleted'),

  //                             action: SnackBarAction(

  //                               label: 'Close',

  //                               onPressed: () {

  //                                 ScaffoldMessenger.of(context).hideCurrentSnackBar();

  //                               },

  //                             )),

  //                       );

  //                       Navigator.of(context).pop();

  //                       load();

  //                     } catch (e) {}

  //                     setState(() {

  //                       _loading = false;

  //                     });

  //                   },

  //             child: _loading ? const CircularProgressIndicator.adaptive() : const Text('Delete'),

  //           );

  //         }),

  //       ],

  //     ),

  //   );

  // }

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
        if (MediaQuery.of(context).size.width > 600) {
          return Dialog(
            clipBehavior: Clip.antiAlias,
            child: child,
          );
        } else {
          return Dialog.fullscreen(
            child: child,
          );
        }
      },
    );
  }
}

class ModelListView<M extends Model> extends StatefulWidget {
  final ModelListViewController<M> controller;

  final bool enableSelectOnTap;

  final Widget? header;

  final double gap;

  final Widget Function(M model)? itemBuilder;

  final List<
      ({
        FlexTableItemConfig config,
        Widget header,
        Widget Function(M model) builder
      })>? flexTableItemBuilders;

  final bool useFlexTable;

  final List<FlexTableItemConfig> flexTableConfigs;

  final Widget? flexTableHeader;

  final void Function(M model)? onModelTap;

  final void Function()? onAddPressed;

  // final List<({Icon icon, String label, Future<Null> Function() onTap})>? addOptions;

  const ModelListView({
    super.key,
    this.enableSelectOnTap = false,
    required this.controller,
    this.header,

    // this.addOptions,

    this.gap = 14,
    this.itemBuilder,
    this.useFlexTable = true,
    this.flexTableConfigs = const [
      FlexTableItemConfig.square(30),
      FlexTableItemConfig.flex(2),
      FlexTableItemConfig.flex(2),
      FlexTableItemConfig.flex(2),
    ],
    this.flexTableHeader,
    this.flexTableItemBuilders,
    this.onModelTap,
    this.onAddPressed,
  }) : assert(itemBuilder == null || flexTableItemBuilders == null, "you can't use both itemBuilder and flexTableItemBuilder");

  @override
  State<ModelListView<M>> createState() => _ModelListViewState<M>();
}

class _ModelListViewState<M extends Model> extends State<ModelListView<M>> {
  /// [_allowMultipleFilters]

  /// its good tool but in maney cases it requires creating a new index in firestore

  bool _allowMultipleFilters = false;

  var searchController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.controller.load();
    });

    super.initState();
  }

  Future<String?> _exportModels(Set<M> selectedModels) async {
    var models = selectedModels.toList();

    var raw = "[${models.map((e) => jsonEncode(e.toJson(),

            // in case of time stamp

            toEncodable: (object) {
          if (object is Timestamp) {
            return object.toDate().toIso8601String();
          }
        })).join(",")}]";

    var rawAsBytes = const Utf8Codec(allowMalformed: true).encode(raw);

    String? dir;

    if (Platforms.isWeb) {
      dir = await FileSaver.instance.saveFile(
        bytes: rawAsBytes,
        mimeType: MimeType.microsoftExcel,
        name: "export_${DateFormat("yyyy-MM-dd").format(DateTime.now())}",
        ext: 'csv',
      );
    } else {
      dir = await FileSaver.instance.saveAs(
        bytes: rawAsBytes,
        mimeType: MimeType.microsoftExcel,
        name: "export_${DateFormat("yyyy-MM-dd").format(DateTime.now())}",
        ext: 'csv',
      );
    }

    return dir;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyMedium!,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      child: ValueListenableBuilder<ModelListViewValue<M>?>(
        valueListenable: widget.controller,
        builder: (context, value, _) {
          var child = RefreshIndicator.adaptive(
            triggerMode: RefreshIndicatorTriggerMode.anywhere,
            onRefresh: widget.controller.load,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: widget.gap, left: widget.gap, right: widget.gap),
                    child: Row(children: [
                      Flexible(
                        child: Row(
                          children: [
                            Flexible(
                              flex: 2,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  widget.controller.description.name,
                                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            if (value?.models?.length != null && value?.models?.length != 0)
                              Flexible(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 8),
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.primary.withOpacity(.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      // n/ infinty symbol

                                      "${value?.models?.length}/${value?.count ?? "∞"}",

                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),

                      if (widget.onAddPressed != null)
                        SizedBox(
                          child: FilledButton.icon(
                            onPressed: widget.onAddPressed,
                            label: const Text('Add'),
                            icon: const Icon(FeatherIcons.plus),
                          ),
                        ),

                      // export/import

                      const SizedBox(
                        width: 10,
                      ),

                      // TextButton.icon(

                      //   onPressed: () {

                      //     showModelExportDialog(context, widget.controller);

                      //   },

                      //   label: const Text('Export'),

                      //   icon: const Icon(

                      //     FluentIcons.archive_32_regular,

                      //     size: 18,

                      //   ),

                      // ),

                      MenuAnchor(
                        builder: (context, controller, child) {
                          return IconButton(
                            icon: const Icon(
                              FluentIcons.more_vertical_24_regular,
                            ),

                            onPressed: () => controller.isOpen ? controller.close() : controller.open(),

                            // label: Text(value!.searchQuery!.field),
                          );
                        },
                        menuChildren: [
                          const SizedBox(height: 8),

                          MenuItemButton(
                            leadingIcon: const Icon(
                              FluentIcons.archive_32_regular,
                              size: 18,
                            ),
                            onPressed: () {
                              showModelExportDialog(context, widget.controller);
                            },
                            child: const Text('Export'),
                          ),

                          // MenuItemButton(

                          //   leadingIcon: const Icon(

                          //     FluentIcons.archive_arrow_back_16_regular,

                          //     size: 18,

                          //   ),

                          //   onPressed: () {

                          //     // showModelImportDialog(context, widget.controller);

                          //   },

                          //   child: const Text('Import'),

                          // ),

                          const Divider(),

                          Container(
                            // min width is 300

                            constraints: const BoxConstraints(minWidth: 250),

                            padding: const EdgeInsets.all(12),

                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: AppTextFormField(
                                    decoration: const InputDecoration(
                                      prefixIcon: SizedBox(child: Icon(FluentIcons.search_20_regular)),
                                      label: Text('Limit'),
                                      alignLabelWithHint: true,
                                    ),
                                    controller: TextEditingController(text: widget.controller.value?.limit.toString() ?? "50"),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      MuskeyFormatter(
                                        masks: [
                                          '####'
                                        ],
                                        overflow: OverflowBehavior.forbidden(),
                                      ),
                                    ],
                                    onChanged: (value) {
                                      widget.controller.setLimit(int.tryParse(value) ?? 50);
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),

                          // alow multiple filter combinations

                          SwitchListTile(
                            value: _allowMultipleFilters,
                            onChanged: (value) {
                              setState(() {
                                _allowMultipleFilters = value;
                              });
                            },
                            title: const Text('Allow multiple filters'),
                          ),

                          const SizedBox(height: 8),
                        ],
                      ),
                    ]),
                  ),
                ),

                // /// filters chips

                SliverToBoxAdapter(
                  child: SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        SizedBox(
                          width: widget.gap,
                        ),
                        if (widget.controller.value!.selectedModels.isNotEmpty)
                          Center(
                            child: Container(
                              margin: EdgeInsetsDirectional.only(end: widget.gap / 2),
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: GradientBoxBorder(
                                  gradient: LinearGradient(
                                    colors: [
                                      Theme.of(context).colorScheme.primary,
                                      Theme.of(context).colorScheme.inversePrimary,
                                      Theme.of(context).colorScheme.secondary,
                                    ],
                                    begin: const Alignment(-1.0, 0.0),
                                    end: const Alignment(1.0, 0.0),
                                    transform: const GradientRotation(pi / 4),
                                  ),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(width: 10),
                                  Text("${widget.controller.value!.selectedModels.length}"),
                                  const SizedBox(width: 10),
                                  Container(
                                    height: 30,
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: VerticalDivider(width: 1),
                                  ),
                                  TextButton.icon(
                                    style: TextButton.styleFrom(shape: const RoundedRectangleBorder()),
                                    onPressed: () => widget.controller.unselectAll(),
                                    label: const Text("unselect"),
                                    icon: const Icon(
                                      FluentIcons.dismiss_24_regular,
                                      size: 18,
                                    ),
                                  ),
                                  Container(
                                    height: 30,
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: VerticalDivider(width: 1),
                                  ),
                                  TextButton.icon(
                                    style: TextButton.styleFrom(shape: const RoundedRectangleBorder()),
                                    onPressed: () {
                                      // _exportModels(widget.controller.value!.selectedModels);

                                      showModelExportDialog(context, widget.controller, widget.controller.value!.selectedModels.toList());
                                    },
                                    label: const Text("export"),
                                    icon: const Icon(
                                      FluentIcons.archive_32_regular,
                                      size: 18,
                                    ),
                                  ),
                                  Container(
                                    height: 30,
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: VerticalDivider(width: 1),
                                  ),
                                  TextButton.icon(
                                    style: TextButton.styleFrom(shape: const RoundedRectangleBorder()),
                                    onPressed: () {
                                      showDeleteModelsDailog(context, widget.controller.value!.selectedModels.toList());
                                    },
                                    label: const Text("delete"),
                                    icon: const Icon(
                                      FluentIcons.delete_16_regular,
                                      size: 18,
                                    ),
                                  ),
                                  for (var action in widget.controller.description.actions.where((e) => e.multiple != null)) ...[
                                    const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 5),
                                      child: VerticalDivider(width: 1),
                                    ),
                                    TextButton(
                                      style: TextButton.styleFrom(shape: const RoundedRectangleBorder()),

                                      onPressed: () async {
                                        await action.multiple!(context, widget.controller.value!.selectedModels.toList());

                                        // TODO: refresh after done

                                        // widget.controller.load();
                                      },

                                      child: Text(action.label),

                                      // icon: action.icon == null? SizedBox() : Icon(

                                      //   action.icon!,

                                      //   size: 18,

                                      // ),
                                    ),
                                  ]
                                ],
                              ),
                            ),
                          ),
                        Container(
                          width: 300,

                          height: 40,

                          // max with is view port -50

                          constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width - 50),

                          child: Center(
                            child: AppTextFormField.min(
                              controller: searchController,

                              // enabled: !loading.value,

                              onSubmitted: (String value) {
                                widget.controller.value = widget.controller.value!.copyWith(
                                  searchQuery: SearchQuery(
                                    field: widget.controller.value!.searchQuery?.field ?? widget.controller.description.fields.firstOrNull?.name ?? "",
                                    value: value,
                                  ),
                                );

                                widget.controller.search();
                              },

                              onChanged: (String value) async {
                                widget.controller.setSearchQueryValue(value);
                              },

                              decoration: InputDecoration(
                                prefixIcon: const Icon(FluentIcons.search_24_regular),

                                label: Text(
                                  'Search${value!.searchQuery!.field.isNotEmpty == true ? " (${value.searchQuery!.field})" : ""}',
                                  maxLines: 1,
                                  softWrap: false,
                                ),

                                alignLabelWithHint: true,

                                // select search field

                                suffixIcon: value?.searchQuery == null
                                    ? null
                                    : MenuAnchor(
                                        builder: (context, controller, child) {
                                          return IconButton(
                                            icon: const Icon(
                                              FluentIcons.filter_24_regular,
                                            ),

                                            onPressed: () => controller.open(),

                                            // label: Text(value!.searchQuery!.field),
                                          );
                                        },
                                        menuChildren: [
                                          for (var field in widget.controller.description.fields)
                                            MenuItemButton(
                                              leadingIcon: const Icon(FeatherIcons.user),
                                              trailingIcon: value!.searchQuery!.field == field ? const Icon(FluentIcons.checkmark_24_regular) : null,
                                              onPressed: value.searchQuery!.field == field
                                                  ? null
                                                  : () {
                                                      widget.controller.setSearchQueryField(field.name);
                                                    },
                                              child: Text(field.name.titleCase),
                                            ),
                                        ],
                                      ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: widget.gap / 2,
                        ),
                        for (var filter in widget.controller.value!.filters)
                          Padding(
                            padding: EdgeInsets.only(right: widget.gap / 2),
                            child: SizedBox(
                              height: 40,
                              child: Builder(
                                builder: (context) {
                                  bool isActive = filter.active ?? false;

                                  bool isFixed = filter.fixed ?? false;

                                  return GestureDetector(
                                    onTap: () {
                                      widget.controller.updateFilter(filter.copyWith(active: !filter.active), _allowMultipleFilters);
                                    },
                                    child: Chip(
                                      label: Text(filter.name.titleCase),
                                      backgroundColor: isActive == true ? Theme.of(context).colorScheme.primary : null,
                                      side: isActive == true ? const BorderSide(color: Colors.transparent) : BorderSide(color: Theme.of(context).colorScheme.onSurface.withOpacity(.12)),
                                      labelStyle: TextStyle(color: isActive == true ? Theme.of(context).colorScheme.onPrimary : null),
                                      deleteIcon: isFixed == true
                                          ? null
                                          : const Icon(
                                              FluentIcons.dismiss_24_regular,
                                              size: 15,
                                            ),
                                      deleteIconColor: isActive == true ? Theme.of(context).colorScheme.onPrimary : null,
                                      onDeleted: isFixed == true
                                          ? null
                                          : () {
                                              widget.controller.removeFilter(filter);
                                            },
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        Padding(
                          padding: EdgeInsets.only(right: widget.gap / 2),
                          child: SizedBox(
                            height: 40,
                            child: ActionChip(
                              label: const Icon(
                                FluentIcons.add_28_regular,
                                size: 20,
                              ),
                              onPressed: () async {
                                var filter = await showFilterWizard(context, widget.controller.description);

                                print(filter);

                                if (filter != null) {
                                  widget.controller.value = widget.controller.value!.copyWith(filters: [
                                    ...widget.controller.value!.filters,
                                    filter
                                  ]);
                                }
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: widget.gap,
                        ),
                      ],
                    ),
                  ),
                ),

                // put the past widget here, but un sliver

                // SliverToBoxAdapter(

                //   child: Padding(

                //     padding: EdgeInsets.only( left: widget.gap, right: widget.gap),

                //     child: Row(

                //       children: [

                //         Expanded(

                //           child: AppTextFormField.min(

                //             controller: searchController,

                //             // enabled: !loading.value,

                //             onSubmitted: (String value) {

                //               widget.controller.value = widget.controller.value!.copyWith(

                //                 searchQuery: SearchQuery(

                //                   field: widget.controller.value!.searchQuery?.field ?? widget.controller.description.fields.firstOrNull?.name ?? "",

                //                   value: value,

                //                 ),

                //               );

                //               widget.controller.search();

                //             },

                //             onChanged: (String value) async {

                //               widget.controller.setSearchQueryValue(value);

                //             },

                //             decoration: InputDecoration(

                //               prefixIcon: const Icon(FluentIcons.search_24_regular),

                //               label: const Text('Search'),

                //               alignLabelWithHint: true,

                //               // select search field

                //               suffixIcon: value?.searchQuery == null

                //                   ? null

                //                   : MenuAnchor(

                //                       builder: (context, controller, child) {

                //                         return TextButton.icon(

                //                           icon: const Icon(

                //                             FluentIcons.filter_24_regular,

                //                           ),

                //                           onPressed: () => controller.open(),

                //                           label: Text(value!.searchQuery!.field),

                //                         );

                //                       },

                //                       menuChildren: [

                //                         for (var field in widget.controller.description.fields)

                //                           MenuItemButton(

                //                             leadingIcon: const Icon(FeatherIcons.user),

                //                             trailingIcon: value!.searchQuery!.field == field ? const Icon(FluentIcons.checkmark_24_regular) : null,

                //                             onPressed: value.searchQuery!.field == field

                //                                 ? null

                //                                 : () {

                //                                     widget.controller.setSearchQueryField(field.name);

                //                                   },

                //                             child: Text(field.name.titleCase),

                //                           ),

                //                       ],

                //                     ),

                //             ),

                //           ),

                //         ),

                //       ],

                //     ),

                //   ),

                // ),

                // SizedBox(height: widget.gap),

                if (widget.useFlexTable)
                  SliverToBoxAdapter(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: widget.gap + 8),
                          child: widget.flexTableHeader ??
                              FlexTableItem(
                                isHeader: true,
                                selected: widget.controller.filtered?.length == widget.controller.value!.selectedModels.length
                                    ? true
                                    : widget.controller.value!.selectedModels.isEmpty == true
                                        ? false
                                        : null,
                                onSelectChanged: (val) {
                                  if (val == true) {
                                    widget.controller.value = widget.controller.value!.copyWith(selectedModels: widget.controller.models!.toSet());
                                  } else {
                                    widget.controller.value = widget.controller.value!.copyWith(selectedModels: const {});
                                  }
                                },
                                children: [
                                  if (widget.flexTableItemBuilders == null) ...[
                                    const SizedBox(),
                                    const Text(
                                      'Title',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    const Text(
                                      'Subtitle',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    const Text(
                                      'Last Update',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ] else
                                    for (var item in widget.flexTableItemBuilders!) item.header,
                                  const Icon(
                                    FluentIcons.chevron_down_24_regular,
                                    size: 20,
                                  )
                                ],
                              ),
                        ),
                        value.loading == true ? const LinearProgressIndicator(minHeight: 2) : Divider(height: 2, color: Theme.of(context).colorScheme.onSurface.withOpacity(.12)),
                      ],
                    ),
                  ),

                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      M? prevModel = index == 0 ? null : widget.controller.filtered![index - 1];

                      M? nextModel = index == widget.controller.filtered!.length - 1 ? null : widget.controller.filtered![index + 1];

                      var model = widget.controller.filtered![index];

                      var tile = widget.controller.description.tileBuilder(model);

                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: widget.gap),
                        child: widget.itemBuilder?.call(model) ??
                            ModelTile(
                              isOdd: index.isOdd,
                              prevSelected: prevModel == null ? false : widget.controller.value!.selectedModels.contains(prevModel),
                              nextSelected: nextModel == null ? false : widget.controller.value!.selectedModels.contains(nextModel),
                              selected: widget.controller.value!.selectedModels.contains(model),
                              onTap: () {
                                if (!widget.enableSelectOnTap && widget.controller.value!.selectedModels.isEmpty) {
                                  widget.onModelTap?.call(model);
                                } else {
                                  if (widget.controller.value!.selectedModels.contains(model)) {
                                    widget.controller.value = widget.controller.value!.copyWith(selectedModels: {
                                      ...widget.controller.value!.selectedModels..remove(model),
                                    });
                                  } else {
                                    widget.controller.value = widget.controller.value!.copyWith(selectedModels: {
                                      ...widget.controller.value!.selectedModels,
                                      model
                                    });
                                  }
                                }
                              },
                              child: FlexTableItem(
                                selected: widget.controller.value!.selectedModels.contains(model),
                                onSelectChanged: (val) {
                                  if (val == true) {
                                    widget.controller.value = widget.controller.value!.copyWith(selectedModels: {
                                      ...widget.controller.value!.selectedModels,
                                      model
                                    });
                                  } else {
                                    widget.controller.value = widget.controller.value!.copyWith(selectedModels: {
                                      ...widget.controller.value!.selectedModels..remove(model),
                                    });
                                  }
                                },
                                children: [
                                  if (widget.flexTableItemBuilders != null) ...[
                                    for (var item in widget.flexTableItemBuilders!) item.builder(model),
                                  ] else ...[
                                    if (tile.leading != null) tile.leading! else const SizedBox(),

                                    Text(
                                      tile.title ?? "(No title)",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),

                                    Text(
                                      tile.subtitle ?? "(No subtitle)",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),

                                    // create at

                                    Text(
                                      timeago.format(model.updatedAt.toLocal()),
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ],
                                  if (tile.trailing != null)
                                    tile.trailing!
                                  else
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

                                        // copy ref button

                                        if (widget.controller.description.groupedActions.keys.isNotEmpty) ...[
                                          for (var group in widget.controller.description.groupedActions.keys) ...[
                                            for (var action in widget.controller.description.groupedActions[group]!)
                                              MenuItemButton(
                                                onPressed: () async {
                                                  var updatedModel = await action.single?.call(context, model);

                                                  if (updatedModel != null) {
                                                    widget.controller.replaceModel(model, updatedModel);
                                                  }
                                                },
                                                leadingIcon: action.icon,
                                                child: Text(action.label),
                                              ),
                                            const Divider()
                                          ]
                                        ],

                                        MenuItemButton(
                                          onPressed: () async {
                                            await Clipboard.setData(ClipboardData(text: model.ref.path));

                                            ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                                              const SnackBar(
                                                behavior: SnackBarBehavior.floating,
                                                width: 400.0,
                                                content: Text('ref copied to clipboard'),
                                              ),
                                            );
                                          },
                                          leadingIcon: const Icon(FluentIcons.copy_24_regular),
                                          child: const Text("Copy ref"),
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
                    childCount: widget.controller.filtered?.length ?? 0,
                  ),
                ),

                SliverToBoxAdapter(
                  child: Center(
                    child: Container(
                      constraints: const BoxConstraints(minHeight: 80),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (widget.controller.needIndexError != null)
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 24.0,
                                    horizontal: 12,
                                  ),
                                  child: Text(widget.controller.needIndexError!.name),
                                ),
                                Wrap(
                                  alignment: WrapAlignment.center,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: 12.0,
                                  runSpacing: 12.0,
                                  children: [
                                    // refresh

                                    OutlinedButton(
                                      onPressed: () async {
                                        await launchUrl(Uri.parse(widget.controller.needIndexError!.url));
                                      },
                                      child: const Text("Create index"),
                                    ),

                                    // clear search

                                    if (widget.controller.value!.searchQuery != null)
                                      TextButton(
                                        onPressed: () async {
                                          searchController.clear();

                                          await widget.controller.clearSearch();
                                        },
                                        child: const Text("Clear search"),
                                      ),

                                    // un select filters

                                    if (widget.controller.value!.filters.isNotEmpty)
                                      TextButton(
                                        onPressed: () {
                                          widget.controller.clearFilters();
                                        },
                                        child: const Text("Clear filters"),
                                      ),
                                  ],
                                ),
                              ],
                            )
                          else if (value?.loading != false)
                            Center(
                                child: Container(
                              margin: const EdgeInsets.all(24.0),
                              height: 15,
                              width: 15,
                              child: const CircularProgressIndicator.adaptive(strokeWidth: 2, strokeCap: StrokeCap.round),
                            ))

                          // if controller.filtered is empty but controller.value is not empty suggest to clear searchQuery

                          else if (widget.controller.value?.models != null && widget.controller.value!.models!.isEmpty && widget.controller.value!.searchQuery != null)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 24.0,
                                    horizontal: 12,
                                  ),
                                  child: Column(
                                    children: [
                                      Icon(
                                        FluentIcons.search_info_24_regular,
                                        size: 54,
                                      ),
                                      Text('Nothing to show'),
                                    ],
                                  ),
                                ),

                                // refresh

                                if (searchController.text.isNotEmpty)
                                  OutlinedButton(
                                    onPressed: () async {
                                      searchController.clear();

                                      await widget.controller.clearSearch();
                                    },
                                    child: const Text("Clear search"),
                                  )
                              ],
                            )
                          else if (widget.controller.value!.models?.isEmpty == true)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 24.0,
                                    horizontal: 12,
                                  ),
                                  child: Text('Nothing to show'),
                                ),

                                // refresh

                                OutlinedButton(
                                  onPressed: widget.controller.load,
                                  child: const Text("Refresh"),
                                )
                              ],
                            )
                          else if (widget.controller.value?.hasNext == true)

                            // VisibilityDetector(

                            //   key: Key(controller..toString()),

                            //   onVisibilityChanged: (info) {

                            //     if (info.visibleFraction > 0) {

                            //       search(startAfter: [

                            //         Timestamp.fromDate(nextStartAt!)

                            //       ]);

                            //     }

                            //   },

                            //   child:

                            OutlinedButton.icon(
                              onPressed: () async {
                                await widget.controller.more();
                              },
                              label: const Text("LOAD MORE"),
                              icon: const Icon(FluentIcons.chevron_down_24_regular),
                            )

                          // )

                          else

                          // you reached the end text

                          if (widget.controller.value?.models != null && widget.controller.value!.models!.isNotEmpty)
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 24.0,
                                horizontal: 12,
                              ),
                              child: Text('You reached the end.'),
                            )
                        ],
                      ),
                    ),
                  ),
                ),

                // Expanded(

                //   child: RefreshIndicator.adaptive(

                //     triggerMode: RefreshIndicatorTriggerMode.anywhere,

                //     onRefresh: widget.controller.load,

                //     child: Stack(

                //       children: [

                //         Positioned.fill(

                //           child: Padding(

                //             padding: EdgeInsets.symmetric(horizontal: widget.gap),

                //             child: Column(

                //               mainAxisSize: MainAxisSize.min,

                //               mainAxisAlignment: MainAxisAlignment.center,

                //               children: [

                //                 if (widget.controller.filtered != null)

                //                   Expanded(

                //                     child: ListView.builder(

                //                       // physics: const NeverScrollableScrollPhysics(),

                //                       // shrinkWrap: true,

                //                       itemCount: widget.controller.filtered!.length,

                //                       itemBuilder: (context, index) {

                //                         var model = widget.controller.filtered![index];

                //                         var tile = widget.controller.description.tileBuilder(model);

                //                         return widget.itemBuilder?.call(model) ??

                //                             ModelTile(

                //                               selected: widget.controller.value!.selectedModels.contains(model),

                //                               onTap: () {

                //                                 widget.onModelTap?.call(model);

                //                               },

                //                               child: FlexTableItem(

                //                                 selected: widget.controller.value!.selectedModels.contains(model),

                //                                 onSelectChanged: (val) {

                //                                   if (val == true) {

                //                                     widget.controller.value = widget.controller.value!.copyWith(selectedModels: {

                //                                       ...widget.controller.value!.selectedModels,

                //                                       model

                //                                     });

                //                                   } else {

                //                                     widget.controller.value = widget.controller.value!.copyWith(selectedModels: {

                //                                       ...widget.controller.value!.selectedModels..remove(model),

                //                                     });

                //                                   }

                //                                 },

                //                                 children: [

                //                                   if (widget.flexTableItemBuilders != null) ...[

                //                                     for (var item in widget.flexTableItemBuilders!) item.builder(model),

                //                                   ] else ...[

                //                                     if (tile.leading != null) tile.leading! else const SizedBox(),

                //                                     Text(

                //                                       tile.title ?? "(No title)",

                //                                       maxLines: 1,

                //                                       overflow: TextOverflow.ellipsis,

                //                                     ),

                //                                     Text(

                //                                       tile.subtitle ?? "(No subtitle)",

                //                                       maxLines: 1,

                //                                       overflow: TextOverflow.ellipsis,

                //                                     ),

                //                                     // create at

                //                                     Text(

                //                                       timeago.format(model.updatedAt.toLocal()),

                //                                       style: const TextStyle(fontWeight: FontWeight.bold),

                //                                       overflow: TextOverflow.ellipsis,

                //                                       maxLines: 1,

                //                                     ),

                //                                   ],

                //                                   if (tile.trailing != null)

                //                                     tile.trailing!

                //                                   else

                //                                     MenuAnchor(

                //                                       builder: (context, controller, child) {

                //                                         return IconButton(

                //                                           onPressed: () {

                //                                             if (controller.isOpen) {

                //                                               controller.close();

                //                                             } else {

                //                                               controller.open();

                //                                             }

                //                                           },

                //                                           icon: const Icon(Icons.more_vert),

                //                                         );

                //                                       },

                //                                       menuChildren: [

                //                                         const SizedBox(

                //                                           height: 8,

                //                                         ),

                //                                         if (widget.controller.description.groupedActions.keys.isNotEmpty) ...[

                //                                           for (var group in widget.controller.description.groupedActions.keys) ...[

                //                                             for (var action in widget.controller.description.groupedActions[group]!)

                //                                               MenuItemButton(

                //                                                 onPressed: () => action.single?.call(model),

                //                                                 leadingIcon: action.icon,

                //                                                 child: Text(action.label),

                //                                               ),

                //                                             const Divider()

                //                                           ]

                //                                         ],

                //                                         const SizedBox(

                //                                           height: 8,

                //                                         ),

                //                                       ],

                //                                     )

                //                                 ],

                //                               ),

                //                             );

                //                       },

                //                     ),

                //                   ),

                //               ],

                //             ),

                //           ),

                //         ),

                //         if (widget.controller.value?.selectedModels.isNotEmpty == true)

                //           Positioned(

                //             left: 0,

                //             right: 0,

                //             bottom: 0,

                //             child: Center(

                //               child: Container(

                //                 // constraints: BoxConstraints(maxWidth: 600),

                //                 margin: EdgeInsets.all(12),

                //                 // height: 50,

                //                 child: Material(

                //                   // color: Theme.of(context).colorScheme.primary,

                //                   borderRadius: BorderRadius.circular(50),

                //                   child: Padding(

                //                     padding: const EdgeInsets.all(8.0),

                //                     child: Row(

                //                       children: [

                //                         IconButton(onPressed: () {}, icon: Icon(Icons.close)),

                //                         for (var action in widget.controller.description.actions.where((e) => e.multiple != null))

                //                           TextButton.icon(

                //                             onPressed: () {

                //                               // action.multiple?.call(controller.value!.selectedModels);

                //                             },

                //                             icon: action.icon ?? const SizedBox(),

                //                             label: Text(action.label),

                //                           ),

                //                       ],

                //                     ),

                //                   ),

                //                 ),

                //               ),

                //             ),

                //           ),

                //       ],

                //     ),

                //   ),

                // ),
              ],
            ),
          );

          if (!widget.useFlexTable) return child;

          return FlexTable(
            selectable: true,
            scrollable: false,
            configs: widget.flexTableItemBuilders != null
                ? [
                    ...widget.flexTableItemBuilders!.map((e) => e.config).toList(),
                    const FlexTableItemConfig.square(40),
                  ]
                : [
                    ...widget.flexTableConfigs,
                    const FlexTableItemConfig.square(40),
                  ],
            child: child,
          );
        },
      ),
    );
  }
}

class ModelTile extends StatelessWidget {
  const ModelTile({
    super.key,
    required this.child,
    this.onTap,
    this.selected = false,
    this.prevSelected = false,
    this.nextSelected = false,
    this.isOdd = false,
  });

  final Widget child;

  final VoidCallback? onTap;

  final bool selected;

  final bool prevSelected;

  final bool nextSelected;

  final bool isOdd;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Theme.of(context).colorScheme.primary.withOpacity(isOdd ? 0.1 : 0.2),
      focusColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      hoverColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(prevSelected ? 0 : 8),
        bottom: Radius.circular(nextSelected ? 0 : 8),
      ),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),

        // child: Text("${prevSelected}/${nextSelected}"),

        child: child,

        // when selected

        decoration: selected
            ? BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(prevSelected ? 0 : 8),
                  bottom: Radius.circular(nextSelected ? 0 : 8),
                ),
                color: Theme.of(context).colorScheme.primary.withOpacity(isOdd ? 0.1 : 0.15),
              )
            : null,
      ),
    );
  }
}

typedef LocalFilterBuilder<T extends Model> = bool Function(T model);

typedef RemoteFilterBuilder<T extends Model> = Query<T> Function(Query<T> query);

typedef RemoteJsonFilterBuilder = Query<Map<String, dynamic>> Function(Query<Map<String, dynamic>> query);

/// [IndexViewFilter] is a class to hold the state of the filter

class IndexViewFilter<T extends Model> {
  final String name;

  final LocalFilterBuilder<T> local;

  final RemoteJsonFilterBuilder remote;

  final bool active;

  final bool fixed;

  final bool strict;

  const IndexViewFilter({
    required this.name,
    this.local = _defaultLocalFilter,
    this.remote = _defaultRemoteFilter,
    this.active = false,
    this.fixed = false,
    this.strict = true,
  });

  static bool _defaultLocalFilter(model) {
    return true;
  }

  static Query<Map<String, dynamic>> _defaultRemoteFilter(Query<Map<String, dynamic>> query) {
    return query;
  }

  IndexViewFilter<T> copyWith({
    String? name,
    LocalFilterBuilder<T>? local,
    RemoteJsonFilterBuilder? remote,
    bool? active,
    bool? fixed,
    bool? strict,
  }) {
    return IndexViewFilter<T>(
      name: name ?? this.name,
      local: local ?? this.local,
      remote: remote ?? this.remote,
      active: active ?? this.active,
      fixed: fixed ?? this.fixed,
      strict: strict ?? this.strict,
    );
  }

  IndexViewFilter<T> toggle() {
    return copyWith(active: !active);
  }
}

// typedef IndexViewFilter<M extends Model> = ({

//   bool? active,

//   bool? fixed,

//   bool Function(M)? local,

//   Query<Map<String, dynamic>> Function(Query<Map<String, dynamic>>)? remote,

//   String name,

// });

typedef ModelIndexType<M extends Model> = (
  M,
  int
);

/// [ModelListViewValue] is a class to hold the state of the view

class ModelListViewValue<M extends Model> {
  final bool loading;

  final bool forceFilter;

  final bool hasNext;

  final int? count;

  final List<M>? models;

  final SearchQuery? searchQuery;

  final List<IndexViewFilter<M>> filters;

  final Set<M> selectedModels;

  final List<ModelIndexType<M>> history;

  final Map<String, dynamic> metadata;

  final String? error;

  /// [limit] (max items loaded each time)

  final int limit;

  const ModelListViewValue({
    this.count,
    this.forceFilter = false,
    this.loading = false,
    this.hasNext = true,
    this.models,
    this.searchQuery,
    this.filters = const [],
    this.selectedModels = const {},
    this.history = const [],
    this.metadata = const {},
    this.error,
    this.limit = 50,
  });

  ModelListViewValue<M> copyWith({
    int? count,
    bool? loading,
    bool? hasNext,
    bool? forceFilter,
    List<M>? models,
    SearchQuery? searchQuery,
    List<IndexViewFilter<M>>? filters,
    Set<M>? selectedModels,
    List<ModelIndexType<M>>? history,
    Map<String, dynamic>? metadata,
    String? error,
    int? limit,
  }) {
    return ModelListViewValue<M>(
      count: count ?? this.count,
      loading: loading ?? this.loading,
      hasNext: hasNext ?? this.hasNext,
      forceFilter: forceFilter ?? this.forceFilter,
      models: models ?? this.models,
      searchQuery: searchQuery ?? this.searchQuery,
      filters: filters ?? this.filters,
      selectedModels: selectedModels ?? this.selectedModels,
      history: history ?? this.history,
      metadata: metadata ?? this.metadata,
      error: error ?? this.error,
      limit: limit ?? this.limit,
    );
  }
}

/// [ModelListViewController] just like other controllers in flutter

class ModelListViewController<M extends Model> extends ValueNotifier<ModelListViewValue<M>?> {
  final ModelDescription<M> description;

  // where

  final bool Function(M model)? where;

  ModelListViewController({ModelListViewValue<M>? value, required this.description, this.where})
      : super(value?.copyWith(
          searchQuery: value.searchQuery ??
              SearchQuery(
                field: description.fields.firstOrNull?.name ?? "",
                value: "",
              ),
        ));

  /// need index error

  ({
    String name,
    String url
  })? needIndexError;

  /// [setLimit] is a function to set the limit

  void setLimit(int limit) {
    value = value?.copyWith(
      limit: limit,
    );

    notifyListeners();
  }

  /// [search] is a function to search for models

  Future<void> search({Iterable<String>? startAfter, bool concat = false, int? limit}) async {
    needIndexError = null;

    value = (value ?? ModelListViewValue<M>()).copyWith(
      loading: true,
      hasNext: true,
    );

    limit = limit ?? value!.limit;

    try {
      value = value!.copyWith(
        models: concat ? value!.models : null,
        count: (await getCount(
          path: description.path,
          builder: (query) {
            var strict = false;

            if (value?.filters.isEmpty == false) {
              for (var filter in value!.filters) {
                if (!filter.active) continue;

                if (filter.strict) {
                  strict = true;
                }

                var d = filter.remote.call(query);

                if (d != null) {
                  query = d;
                }
              }
            }

            return query;
          },
        ))
            ?.count,
      );

      notifyListeners();

      var _models = await getModelCollection(
        path: description.path,
        fromJson: description.fromJson,
        behavior: true ? FetchBehavior.serverOnly : FetchBehavior.serverFirst,
        startAfter: startAfter,
        builder: (query) {
          var strict = false;

          if (value?.filters.isEmpty == false) {
            for (var filter in value!.filters) {
              if (!filter.active) continue;

              if (filter.strict) {
                strict = true;
              }

              var d = filter.remote.call(query);

              if (d != null) {
                query = d;
              }
            }
          }

          return query;
        },
        limit: limit,
      );

      if (_models.length < limit) {
        value = value!.copyWith(hasNext: false);
      }

      if (concat) {
        // check if the first item equal to the last item in the current models

        if (value?.models?.lastOrNull != null && value!.models!.lastOrNull!.ref.path == _models.firstOrNull?.ref.path) {
          // delete the last item

          value!.models!.removeAt(value!.models!.length - 1);
        }

        value = value!.copyWith(
          models: [
            ...(value!.models ?? []),
            ..._models
          ],
          loading: false,
        );
      } else {
        value = value?.copyWith(
          models: _models,
          loading: false,
        );
      }
    }

    // need index error from firebase

    on FirebaseException catch (e) {
      if (e.code == "failed-precondition") {
        var data = e.message!.split("https");

        var message = data[0];

        var url = "https${data[1]}";

        needIndexError = (
          name: message,
          url: url,
        );

        value = value?.copyWith(
          error: e.toString(),
          loading: false,
          models: [],
        );
      } else {
        value = value?.copyWith(
          error: e.toString(),
          loading: false,
        );
      }
    } catch (e) {
      value = value?.copyWith(
        error: e.toString(),
        loading: false,
      );
    }

    /// sync selected models

    syncSelectedModels();
  }

  /// remove selected items that are not in the list

  void syncSelectedModels() {
    value = value?.copyWith(
      selectedModels: value!.selectedModels.where((e) => value!.models!.contains(e)).toSet(),
    );
  }

  /// [load] is a function to load models

  Future<void> load() async {
    return search();
  }

  /// [more] is a function to load more models

  Future<void> more() async {
    return search(startAfter: [
      if (value?.models?.last.ref.path != null) value!.models!.last.ref.path

      // why 3 seconds? because we are not really sure about the date are the same

      // Timestamp.fromDate((value?.models?.last.updatedAt ?? DateTime.now()).add(const Duration(seconds: 3)))
    ], concat: true);
  }

  /// [models] getter to get the models

  List<M>? get models => value?.models;

  /// [filtered] is a function to get the filtered models

  List<M>? get filtered {
    print(where);

    if (models == null) {
      return null;
    }

    bool _filters(M model) {
      for (var filter in value?.filters ?? <IndexViewFilter<M>>[]) {
        if (!filter.active) continue;

        if (filter.local != null) {
          if (filter.local!(model) == false) {
            return false;
          }
        }
      }

      return where?.call(model) ?? true;
    }

    if (value?.searchQuery?.value?.isEmpty == true) {
      return models!.where(_filters).toList() ?? [];
    }

    // search in display name and email and phone number and uid

    return models!.where((model) {
      if (!_filters(model)) {
        return false;
      }

      var query = value?.searchQuery?.value?.toLowerCase();

      if (query != null) {
        return model.toString().toLowerCase().contains(query);
      } else {
        return true;
      }
    }).toList();
  }

  /// [activateFilter]

  Future<void> updateFilter(IndexViewFilter<M> filter, bool allowMultipleFilters) async {
    // check filter if extst, take the index and activat it

    var index = value!.filters.indexWhere((f) => f.name == filter.name);

    if (index >= 0) {
      if (value?.forceFilter == true) {
        var currentActive = value!.filters.where((e) => e.active).firstOrNull;

        if (currentActive != null && currentActive.name == filter.name && filter.active == false) {
          return;
        }
      }

      value!.filters[index] = filter;
    } else {
      value!.filters.add(filter);
    }

    if (!allowMultipleFilters) {
      value = value?.copyWith(
        filters: value!.filters.map((e) => e.copyWith(active: e.name == filter.name && filter.active)).toList(),
      );
    }

    // value = value?.copyWith(

    //   // disable all filters except the one we want to activate and add it to the list

    //   filters: value!.filters.map((e) => e.copyWith(active: e.name == filter.name && filter.active)).toList(),

    // );

    await search();
  }

  /// remove filter

  Future<void> removeFilter(IndexViewFilter<M> filter) async {
    if (value?.forceFilter == true) {
      // if no active filters prevent from removing

      if (value!.filters.where((e) => e.active).length <= 1) {
        return;
      }
    }

    value = value?.copyWith(
      filters: value!.filters.where((e) => e.name != filter.name).toList(),
    );

    await search();
  }

  /// replaceModel

  void replaceModel(M oldModel, M newModel) {
    value = value?.copyWith(
      models: value!.models?.map((e) => e.ref.path == oldModel.ref.path ? newModel : e).toList(),
    );
  }

  /// [addModel]

  void addModel(M model) {
    value = value?.copyWith(
      models: [
        model,
        ...(value?.models ?? [])
      ],
    );
  }

  /// [clearFilters]

  Future<void> clearFilters({bool refresh = true}) async {
    value = value?.copyWith(
      filters: value!.filters.map((e) => e.copyWith(active: false)).toList(),
    );

    if (refresh) await search();
  }

  /// [clearSearch]

  Future<void> clearSearch({bool refresh = true}) async {
    value = value?.copyWith(
      searchQuery: SearchQuery(
        field: value!.searchQuery?.field ?? "ref",
        value: "",
      ),
    );

    await search();
  }

  /// [history]

  Map<M, bool> history = {};

  /// to make sure that the controller is mounted on the view

  var _mounted = false;

  bool get mounted => _mounted;

  void setSearchQuery(SearchQuery query) {
    value = value?.copyWith(searchQuery: query);
  }

  void setSearchQueryField(String field) {
    value = value?.copyWith(
      searchQuery: SearchQuery(
        field: field,
        value: value?.searchQuery?.value ?? "",
      ),
    );
  }

  void setSearchQueryValue(String _value) {
    value = value?.copyWith(
        searchQuery: SearchQuery(
      field: value?.searchQuery?.field ?? description.fields.firstOrNull?.name ?? "",
      value: _value,
    ));
  }

  /// [mounted] is a function to mount the controller on the view and bind it to the view

  /// selectAll

  void selectAll() {
    value = value?.copyWith(
      selectedModels: value!.models!.toSet(),
    );
  }

  /// unselectAll

  void unselectAll() {
    value = value?.copyWith(
      selectedModels: const {},
    );
  }
}

enum FieldGroup {
  primary,

  secondary,

  metadata,

  hidden,
}

enum FieldType {
  number,

  text,

  date,

  time,

  datetime,

  email,

  phone,

  url,

  image,

  file,

  color,

  boolean,

  reference,

  listNumber,

  listText,

  listDate,

  listTime,

  listDatetime,

  listEmail,

  listPhone,

  listUrl,

  listImage,

  listFile,

  listColor,

  listBoolean,

  listReference,
}

/// FieldDescription

class FieldDescription<M> {
  final String name;

  final String path;

  final bool nullable;

  final String? details;

  final FieldGroup group;

  // type

  final FieldType type;

  // mapping

  final Object? Function(M model) map;

  final Widget Function(M model)? builder;

  final Widget Function(M model)? header;

  const FieldDescription({
    required this.name,
    required this.path,
    this.nullable = false,
    required this.map,
    required this.type,
    this.details,
    this.group = FieldGroup.primary,
    this.builder,
    this.header,
  });

  /// copyWith

  FieldDescription<M> copyWith({
    String? name,
    String? path,
    bool? nullable,
    String? details,
    FieldType? type,
    FieldGroup? group,
    Object? Function(M model)? map,
    Widget Function(M model)? builder,
    Widget Function(M model)? header,
  }) {
    return FieldDescription<M>(
      name: name ?? this.name,
      path: path ?? this.path,
      nullable: nullable ?? this.nullable,
      details: details ?? this.details,
      type: type ?? this.type,
      group: group ?? this.group,
      map: map ?? this.map,
      builder: builder ?? this.builder,
      header: header ?? this.header,
    );
  }

  @override
  String toString() {
    return name;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FieldDescription<M> && other.name == name;
  }

  @override
  int get hashCode {
    return name.hashCode;
  }
}

/// [ModelDescription] is a class to describe a model

class ModelDescription<T extends Model> {
  // fields to search in

  final Set<FieldDescription<T>> fields;

  // name of the collection

  final String name;

  // path to collection

  final String path;

  // fromJson

  final T Function(Map<String, dynamic> data) fromJson;

  // semantics (general title, description, icon, etc..)

  final ModelGeneralData Function(T model) tileBuilder;

  /// actions

  final List<ModelAction<T>> actions;

  const ModelDescription({
    required this.fields,
    required this.name,
    required this.path,
    required this.fromJson,
    required this.tileBuilder,
    required this.actions,
  });

  Map<String, List<ModelAction<T>>> get groupedActions {
    var map = <String, List<ModelAction<T>>>{};

    for (var action in actions) {
      if (action.group == null) {
        continue;
      }

      if (map.containsKey(action.group)) {
        map[action.group]!.add(action);
      } else {
        map[action.group!] = [
          action
        ];
      }
    }

    return map;
  }

  // copyWith

  ModelDescription<T> copyWith({
    Set<FieldDescription<T>>? fields,
    String? name,
    String? path,
    T Function(Map<String, dynamic> data)? fromJson,
    ModelGeneralData Function(T model)? tileBuilder,
    List<ModelAction<T>>? actions,
  }) {
    return ModelDescription<T>(
      fields: fields ?? this.fields,
      name: name ?? this.name,
      path: path ?? this.path,
      fromJson: fromJson ?? this.fromJson,
      tileBuilder: tileBuilder ?? this.tileBuilder,
      actions: actions ?? this.actions,
    );
  }
}

class ModelGeneralData {
  final String? title;

  final String? subtitle;

  final Widget? leading;

  final Widget? trailing;

  ModelGeneralData({
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
  });
}

/// [showFilterWizard] is a function to show a filter wizard dailog

/// it is very useful to create a filter

/// it contains a list of fields and a list of operators

/// the operation dropdown will change based on the field selected

/// the value field will change based on the operator selected

Future<IndexViewFilter<M>?> showFilterWizard<M extends Model>(BuildContext context, ModelDescription<M> description) async {
  // var _operator = QueryOperations.equal;

  dynamic value;

  TextEditingController fieldController = TextEditingController();

  TextEditingController operatorController = TextEditingController();

  TextEditingController valueController = TextEditingController();

  FieldType fieldType = FieldType.text;

  FieldType? _fieldType() => description.fields.where((e) => e.name == fieldController.text).firstOrNull?.type;

  FieldDescription? _field() => description.fields.where((e) => e.name == fieldController.text).firstOrNull;

  QueryOperations? _operator() => QueryOperations.values.where((e) => e.symbol == operatorController.text).firstOrNull;

  String? _value() => valueController.text;

  return await showDialog<IndexViewFilter<M>?>(
    context: context,
    builder: (context) {
      return StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          title: const Text('Add filter'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // field

              MenuAnchor(
                builder: (context, controller, child) {
                  return AppTextFormField(
                    key: Key((_field()?.path).toString()),
                    controller: fieldController,
                    onTap: (v) => controller.open(),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(FluentIcons.filter_24_regular),
                      label: Text('Field path${_field()?.path.nullIfEmpty == null ? "" : "{${_field()!.path}}"}'),
                      alignLabelWithHint: true,
                    ),
                  );

                  // return TextButton.icon(

                  //   icon: const Icon(FluentIcons.filter_24_regular),

                  //   onPressed: () => controller.open(),

                  //   label: Text(_field?.name.titleCase ?? "Select field"),

                  // );
                },
                menuChildren: [
                  for (var field in description.fields)
                    MenuItemButton(
                      leadingIcon: const Icon(FluentIcons.filter_24_regular),
                      trailingIcon: fieldController.text == field.name ? const Icon(FluentIcons.checkmark_24_regular) : null,
                      onPressed: fieldController.text == field.name
                          ? null
                          : () {
                              setState(() {
                                fieldController.text = field.path;

                                fieldType = _fieldType() ?? fieldType;
                              });
                            },
                      child: Text(field.name.titleCase),
                    ),
                ],
              ),

              const SizedBox(height: 8),

              // operator

              MenuAnchor(
                builder: (context, controller, child) {
                  return AppTextFormField(
                    controller: operatorController,
                    onTap: (v) => controller.open(),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(FluentIcons.calculator_24_regular),
                      label: Text('Operator'),
                      alignLabelWithHint: true,
                    ),
                  );
                },
                menuChildren: [
                  for (var operator in QueryOperations.values)
                    MenuItemButton(
                      leadingIcon: const Icon(FluentIcons.calculator_24_regular),
                      trailingIcon: operatorController.text == operator.symbol ? Text(operatorController.text) : null,
                      onPressed: operatorController.text == operator.symbol
                          ? null
                          : () {
                              setState(() {
                                operatorController.text = operator.symbol;
                              });
                            },
                      child: Text(operator.name.titleCase),
                    ),
                ],
              ),

              const SizedBox(height: 8),

              // value type, depending on this it may show things to help

              // use filter chips

              // operator

              MenuAnchor(
                builder: (context, controller, child) {
                  return AppTextFormField(
                    key: Key(fieldType.name),
                    initialValue: fieldType.name,
                    onTap: (v) => controller.open(),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(FluentIcons.data_area_24_regular),
                      label: Text('Data Type'),
                      alignLabelWithHint: true,
                    ),
                  );
                },
                menuChildren: [
                  for (var type in [
                    FieldType.text,
                    FieldType.number,
                    FieldType.boolean,
                    FieldType.date,
                    FieldType.time,
                    FieldType.datetime,
                  ])
                    MenuItemButton(
                      leadingIcon: const Icon(FluentIcons.calculator_24_regular),
                      trailingIcon: fieldType == type ? Text(fieldType.toString()) : null,
                      onPressed: fieldType == type
                          ? null
                          : () {
                              setState(() {
                                fieldType = type;
                              });
                            },
                      child: Text(type.toString().titleCase),
                    ),
                ],
              ),

              const SizedBox(height: 8),

              // value

              if (fieldType == FieldType.text || fieldType == FieldType.number)
                AppTextFormField(
                  onChanged: (String v) async {
                    value = v;
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(FluentIcons.search_24_regular),
                    label: Text(fieldType.name.titleCase),
                    alignLabelWithHint: true,
                  ),
                )
              else if (fieldType == FieldType.boolean)
                SwitchListTile(
                  value: value == true,
                  onChanged: (v) {
                    value = v;

                    setState(() {});
                  },
                  title: const Text('Activate'),
                )
              else if (fieldType == FieldType.date || fieldType == FieldType.time || fieldType == FieldType.datetime)
                AppTextFormField(
                  key: Key(value?.toString() ?? ""),
                  initialValue: value?.toString(),
                  onTap: (v) async {
                    DateTime? date;

                    if (fieldType == FieldType.date || fieldType == FieldType.datetime) {
                      date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2050),
                      );
                    }

                    if (fieldType == FieldType.time || fieldType == FieldType.datetime) {
                      var time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );

                      if (time == null) return null;

                      date = DateTime(
                        date?.year ?? DateTime.now().year,
                        date?.month ?? DateTime.now().month,
                        date?.day ?? DateTime.now().day,
                        time!.hour,
                        time!.minute,
                      );
                    }

                    setState(() {
                      value = date;
                    });
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(FluentIcons.calendar_20_regular),
                    label: Text(fieldType.name),
                    alignLabelWithHint: true,
                  ),
                )
              else
                const SizedBox(),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: (fieldController.text.nullIfEmpty ?? operatorController.text.nullIfEmpty ?? valueController.text.nullIfEmpty) == null
                  ? null
                  : () {
                      var filter = IndexViewFilter<M>(
                        name: "${fieldController.text}${operatorController.text}${value}",
                        remote: (query) {
                          if (_fieldType() == FieldType.number) value = num.tryParse(value) ?? value;

                          return _operator()!.remote(query: query, field: _field()?.name ?? fieldController.text, value: value);
                        },
                        local: (model) {
                          return _operator()!.local(
                            field: _field()?.name ?? fieldController.text,
                            value: value,
                            model: model,
                          );
                        },
                      );

                      print(filter);

                      Navigator.of(context).pop<IndexViewFilter<M>>(filter);
                    },
              child: const Text('Add'),
            ),
          ],
        );
      });
    },
  );
}

class SearchFilter {
  final List<dynamic> query;

  const SearchFilter({required this.query});
}

/// [showModelExportDialog]

/// [showModelExportDialog] is a function to show a model export dialog

/// it takes a [context] and a [controller]

/// it will show a dialog with a list of fields to export

/// it will export the data as a csv file

Future<void> showModelExportDialog<M extends Model>(BuildContext context, ModelListViewController<M> controller, [List<M>? selectedModels]) async {
  var fields = controller.description.fields.toList();

  var selectedFields = fields.where((e) => e.group != FieldGroup.hidden).toList();

  var selectedFieldsController = TextEditingController(text: selectedFields.map((e) => e.path).join(","));

  getGelectedFields() {
    // just in case the user used arabic comma i added the replaceAll

    return selectedFieldsController.text.replaceAll("،", ",").split(",");
  }

  var limit = 100;

  await showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          title: const Text('Export'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // fields

              MenuAnchor(
                builder: (context, controller, child) {
                  return AppTextFormField(
                    controller: TextEditingController(text: selectedFields.map((e) => e.path).join(",")),
                    onTap: (v) => controller.open(),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(FluentIcons.filter_24_regular),
                      label: Text('Fields (paths)'),
                      alignLabelWithHint: true,
                    ),
                    onChanged: (v) {
                      selectedFieldsController.text = v;

                      selectedFields = fields.where((e) => getGelectedFields().contains(e.path)).toList();
                    },
                  );
                },
                menuChildren: [
                  for (var field in fields)
                    MenuItemButton(
                      leadingIcon: const Icon(FluentIcons.filter_24_regular),
                      trailingIcon: selectedFields.contains(field) ? const Icon(FluentIcons.checkmark_24_regular) : null,
                      onPressed: () {
                        setState(() {
                          if (selectedFields.contains(field)) {
                            selectedFields.remove(field);
                          } else {
                            selectedFields.add(field);
                          }
                        });
                      },
                      child: Text(field.name.titleCase),
                    ),
                ],
              ),

              const SizedBox(height: 8),

              // limit

              if (selectedModels == null)
                AppTextFormField(
                  controller: TextEditingController(text: limit.toString()),
                  onChanged: (v) {
                    limit = int.tryParse(v) ?? 100;
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(FluentIcons.filter_24_regular),
                    label: Text('Limit'),
                    alignLabelWithHint: true,
                  ),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                var models = selectedModels;

                if (models == null) {
                  await controller.search(limit: limit);

                  models = controller.value!.models;
                }

                // download directly

                // var dir = await getExternalStorageDirectory();

                var rawFields = selectedFieldsController.text.replaceAll("،", ",").split(",");

                var raw = "${rawFields.join(";")}\n${models!.map((e) {
                  var data = <String>[];

                  for (var field in rawFields) {
                    // field coud be "name" or "name.first"

                    // use while loop to get the value and add it to the data

                    Map? map = e.toJson();

                    while (field.contains(".")) {
                      var key = field.split(".").first;

                      field = field.split(".").sublist(1).join(".");

                      if (map == null) {
                        break;
                      }

                      map = map[key];
                    }

                    data.add(map?[field]?.toString() ?? "");
                  }

                  return data.join(";");
                }).join("\n")}";

                var rawAsBytes = const Utf8Codec(allowMalformed: true).encode(raw);

                String? dir;

                if (Platforms.isWeb) {
                  dir = await FileSaver.instance.saveFile(
                    bytes: rawAsBytes,
                    mimeType: MimeType.microsoftExcel,
                    name: "export_${controller.description.name}_${DateFormat("yyyy-MM-dd").format(DateTime.now())}",
                    ext: 'csv',
                  );
                } else {
                  dir = await FileSaver.instance.saveAs(
                    bytes: rawAsBytes,
                    mimeType: MimeType.microsoftExcel,
                    name: "export_${controller.description.name}_${DateFormat("yyyy-MM-dd").format(DateTime.now())}",
                    ext: 'csv',
                  );
                }

                // show dailog with path

                // ignore: use_build_context_synchronously

                await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Export'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Exported to $dir"),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                      ],
                    );
                  },
                );

                Navigator.of(context).pop();
              },
              child: const Text('Export'),
            ),
          ],
        );
      });
    },
  );
}
