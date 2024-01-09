import 'package:core/core.dart';
import 'package:core/services/defaults/preferences.dart';

import '../../models/cached_document.dart';
import 'firebase/database.dart';
import 'theme.dart';

/// database helper

ProfileModel? getCurrentProfile() {
  return Services.instance.get<AuthService>()?.currentProfile;
}

Future<CachedCollection?> getCollection({
  String? cacheId,
  required String path,
  bool withExpired = false,
  FetchBehavior behavior = FetchBehavior.serverFirst,
  int limit = 100,
  bool useRef = true,
  Query<Map<String, dynamic>> Function(Query<Map<String, dynamic>>)? builder,
  required Duration minmumUpdateDuration,
  OrderBy? orderBy,
  Iterable<Object?>? startAfter,
}) async {
  if (getPrefs().getOption<bool>("useCache", defaults: true) == false) {
    behavior = FetchBehavior.serverOnly;
    minmumUpdateDuration = Duration(seconds: 2);
  }
  return await Services.instance.get<DatabaseService>()!.getCollection(
        cacheId: cacheId,
        path: path,
        withExpired: withExpired,
        behavior: behavior,
        limit: limit,
        useRef: useRef,
        builder: builder,
        minmumUpdateDuration: minmumUpdateDuration,
        orderBy: orderBy,
        startAfter:startAfter,
      );
}

// getCount
Future<CachedCount?> getCount({
  String? cacheId,
  required String path,
  bool withExpired = false,
  FetchBehavior behavior = FetchBehavior.cacheFirst,
  Query<Map<String, dynamic>> Function(Query<Map<String, dynamic>>)? builder,
  Duration minmumUpdateDuration = const Duration(minutes: 10),
  OrderBy? orderBy,
  Iterable<Object?>? startAfter,
}) async {
  return await Services.instance.get<DatabaseService>()!.getCount(
        cacheId: cacheId,
        path: path,
        withExpired: withExpired,
        behavior: behavior,
        builder: builder,
        minmumUpdateDuration: minmumUpdateDuration,
        orderBy: orderBy,
        startAfter:startAfter,
      );
}

Future<List<T>> getModelCollection<T>({
  String? cacheId,
  required String path,
  bool withExpired = false,
  FetchBehavior behavior = FetchBehavior.serverFirst,
  int limit = 100,
  bool useRef = false,
  Query<Map<String, dynamic>> Function(Query<Map<String, dynamic>>)? builder,
  required T Function(Map<String, dynamic> data) fromJson,
  Duration minmumUpdateDuration = const Duration(seconds: 5),
  OrderBy? orderBy,
  // startAfterDocument,
  Iterable<Object?>? startAfter,
}) async {
  var collection = await getCollection(
    cacheId: cacheId,
    path: path,
    withExpired: withExpired,
    behavior: behavior,
    limit: limit,
    useRef: useRef,
    builder: builder,
    minmumUpdateDuration: minmumUpdateDuration,
    orderBy: orderBy,
    startAfter: startAfter,
  );
  if (collection == null) {
    return [];
  }
  return collection.documents
      .map((e) => fromJson({
            ...e.data,
            "ref": e.ref,
          }))
      .toList();
}

Future<CachedDocument?> getDocument({
  required String path,
  bool withExpired = false,
  FetchBehavior behavior = FetchBehavior.serverFirst,
  Duration minmumUpdateDuration = const Duration(seconds: 20),
}) async {
  return await Services.instance.get<DatabaseService>()!.getDocument(
        path: path,
        withExpired: withExpired,
        behavior: behavior,
        minmumUpdateDuration: minmumUpdateDuration,
      );
}

/// createDocument
Future<CachedDocument> createDocument({
  required String path,
  required Map<String, dynamic> data,
}) async {
  return await Services.instance.get<DatabaseService>()!.createDocument(
        path: path,
        data: data,
      );
}
/// createDocument
Future<CachedDocument> setDocument({
  required String path,
  required Map<String, dynamic> data,
  bool merge = false,
}) async {
  return await Services.instance.get<DatabaseService>()!.setDocument(
        path: path,
        data: data,
        merge: merge,
      );
}

/// updateDocument
Future<CachedDocument> updateDocument({
  required String path,
  required Map<String, dynamic> data,
}) async {
  return await Services.instance.get<DatabaseService>()!.updateDocument(
        path: path,
        data: data,
      );
}

/// deleteDocument
Future<void> deleteDocument({
  required String path,
  bool softDelete = false,
}) async {
  return await Services.instance.get<DatabaseService>()!.deleteDocument(
        path: path,
        softDelete: softDelete,
      );
}

Future<T?> getModelDocument<T>({
  required String path,
  bool withExpired = false,
  FetchBehavior behavior = FetchBehavior.serverFirst,
  required T Function(Map<String, dynamic> data) fromJson,
}) async {
  var document = await getDocument(
    path: path,
    withExpired: withExpired,
    behavior: behavior,
  );
  if (document == null) {
    return null;
  }
  return fromJson({
    ...document.data,
    "ref": document.ref,
  });
}

///

AuthService getAuth() {
  return Services.instance.get<AuthService>()!;
}

DatabaseService getDB() {
  return Services.instance.get<DatabaseService>()!;
}

ThemeService getTheme() {
  return Services.instance.get<ThemeService>()!;
}

PreferencesService getPrefs() {
  return Services.instance.get<PreferencesService>()!;
}
