// ignore_for_file: public_member_api_docs, sort_constructors_first, no_leading_underscores_for_local_identifiers
import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';

// ignore: depend_on_referenced_packages
import 'package:crypto/crypto.dart';
import 'package:core/services/consts/consts.dart';
// ignore: depend_on_referenced_packages
import 'package:core/core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/cached_document.dart';

enum FetchBehavior {
  cacheOnly,
  serverOnly,
  cacheFirst,
  serverFirst,
}

// OrderBy
class OrderBy {
  final Object field;
  final bool descending;
  const OrderBy({
    required this.field,
    required this.descending,
  });

  OrderBy copyWith({
    Object? field,
    bool? descending,
  }) {
    return OrderBy(
      field: field ?? this.field,
      descending: descending ?? this.descending,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'field': field,
      'descending': descending,
    };
  }

  factory OrderBy.fromMap(Map<String, dynamic> map) {
    return OrderBy(
      field: map['field'],
      descending: map['descending'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderBy.fromJson(String source) => OrderBy.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'OrderBy(field: $field, descending: $descending)';

  @override
  bool operator ==(covariant OrderBy other) {
    if (identical(this, other)) return true;

    return other.field == field && other.descending == descending;
  }

  @override
  int get hashCode => field.hashCode ^ descending.hashCode;
}

/// [DatabaseService] responsible for database of the app content and users
class DatabaseService extends Service {
  DatabaseService({
    super.id = 'DEFAULT',
  });

  late SharedPreferences prefs;

  @override
  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    super.init();
    await _loadCache();
    log.info('App~Service: Database initialized');
  }

  List<CachedDocument> _cachedDocuments = [];
  List<CachedDocument> get cachedDocuments => _cachedDocuments;
  List<CachedCollection> _cachedCollections = [];
  List<CachedCollection> get cachedCollections => _cachedCollections;
  List<CachedAggregate> _cachedAggregates = [];
  List<CachedAggregate> get cachedAggregates => _cachedAggregates;

  bool get isEmpty => _cachedDocuments.isEmpty && _cachedCollections.isEmpty;
  int get length =>
      _cachedDocuments.length +
      // get inner docs length
      _cachedCollections.fold(0, (previousValue, element) => previousValue + element.documents.length);

  Future<void> clearCache() async {
    await prefs.clear();
    _cachedDocuments = [];
    _cachedCollections = [];
    _cachedAggregates = [];
    notifyListeners();
  }

  Future<void> _loadCache() async {
    if (kIsWeb) {
      return;
    }
    final cachedDocuments = prefs.getStringList('cached_documents');
    if (cachedDocuments != null) {
      _cachedDocuments = cachedDocuments.map((e) => CachedDocument.fromJson(jsonDecode(e))).toList();
    }

    final cachedCollections = prefs.getStringList('cached_collections');
    if (cachedCollections != null) {
      _cachedCollections = cachedCollections.map((e) => CachedCollection.fromJson(jsonDecode(e))).toList();
    }

    final cachedCounts = prefs.getStringList('cached_counts');
    if (cachedCounts != null) {
      _cachedAggregates = cachedCounts.map((e) => CachedAggregate.fromJson(jsonDecode(e))).toList();
    }
  }

  Future<void> _saveCache() async {
    if (kIsWeb) {
      return;
    }
    dateToJson(e) {
      if (e is DateTime) {
        return e.toIso8601String();
      } else if (e is Timestamp) {
        return e.toDate().toIso8601String();
      } else if (e is GeoPoint) {
        return [
          e.latitude,
          e.longitude
        ];
      }
      return e;
    }

    List<String> cachedDocuments = [];
    try {
      cachedDocuments = _cachedDocuments
          .map((e) => jsonEncode(
                e.toJson(),
                toEncodable: dateToJson,
              ))
          .toList();
      await prefs.setStringList('cached_documents', cachedDocuments);

      final cachedCollections = _cachedCollections.map((e) => jsonEncode(e.toJson(), toEncodable: dateToJson)).toList();
      await prefs.setStringList('cached_collections', cachedCollections);

      final cachedCounts = _cachedAggregates.map((e) => jsonEncode(e.toJson(), toEncodable: dateToJson)).toList();
      await prefs.setStringList('cached_counts', cachedCounts);
    } catch (e) {
      print(e);
    }
  }

  /// getCachedDocument
  CachedDocument? getCachedDocument({
    required String path,
    bool withExpired = false,
  }) {
    var cachedDocument = _cachedDocuments.where((e) {
      return e.ref == path;
    }).toList();
    final collaction = getCachedCollection(path: ModelRef(path).collection, query: null);
    if (collaction != null) {
      cachedDocument.addAll(collaction.documents.where((e) => e.ref == path));
    }
    cachedDocument = cachedDocument.where((e) => e.expiresAt == null || e.expiresAt!.isAfter(DateTime.now())).toList();
    if (cachedDocument.isEmpty) {
      return null;
    } else if (cachedDocument.length > 1) {
      log.warning('App~Service: Database has more than one document with the same path: $path');
      // get the latest one
      cachedDocument.sort((a, b) => a.cachedAt.compareTo(b.cachedAt));
      // remove all except the latest one
      /// TODO: test this
    }
    return cachedDocument.first;
  }

  /// getCachedCollection
  CachedCollection? getCachedCollection({
    required String path,
    String? query = "",
    bool withExpired = false,
  }) {
    List<CachedCollection> cachedCollection;
    if (query == null) {
      cachedCollection = _cachedCollections.where((e) => e.ref == path).toList();
    } else {
      cachedCollection = _cachedCollections.where((e) => e.ref == path && e.query == query).toList();
    }
    if (cachedCollection.isEmpty) {
      return null;
    }
    cachedCollection = cachedCollection.where((e) => e.expiresAt == null || e.expiresAt!.isAfter(DateTime.now())).toList();
    if (cachedCollection.isEmpty) {
      return null;
    }
    return cachedCollection.first;
  }

  /// getCachedCount
  CachedAggregate? getCachedAggregate({
    required String path,
    String? query = "",
    bool withExpired = false,
  }) {
    Iterable<CachedAggregate> cachedCount;
    if (query == null) {
      cachedCount = _cachedAggregates.where((e) => e.ref == path);
    } else {
      cachedCount = _cachedAggregates.where((e) => e.ref == path && e.query == query);
    }
    if (cachedCount.isEmpty) {
      return null;
    }
    cachedCount = cachedCount.where((e) => e.expiresAt == null || e.expiresAt!.isAfter(DateTime.now()));
    if (cachedCount.isEmpty) {
      return null;
    }
    return cachedCount.first;
  }

  Stream<Map<String, dynamic>> getDocumentStream({
    required ModelRef ref,
  }) {
    final document = FirebaseFirestore.instance.doc(ref.parentDocumentRef?.path ?? ref.path).snapshots();
    return document.where((event) => event.data() != null).map((e) {
      if (ref.isEmbedded) {
        return e.data()![ref.fieldPath!];
      }
      return e.data()!;
    });
  }

  Future<CachedDocument?> getDocument({
    required String path,
    String? cacheId,
    OrderBy? orderBy,
    bool withExpired = false,
    FetchBehavior behavior = FetchBehavior.serverFirst,
    Query<Map<String, dynamic>> Function(Query<Map<String, dynamic>> collection)? builder,

    /// time between each update, within this time will return the cached collection instead of going to server if behavior is serverFirst
    Duration minmumUpdateDuration = const Duration(minutes: 5),
  }) async {
    var collaction = ModelRef(path).collection;
    var doc = await getCollection(
      cacheId: cacheId,
      path: collaction,
      orderBy: orderBy,
      withExpired: withExpired,
      behavior: behavior,
      limit: 1,
      useRef: false,
      builder: (collection) {
        if (builder != null) {
          collection = builder(collection);
        }
        return collection.where(
          'ref',
          isEqualTo: path,
        );
      },
      minmumUpdateDuration: minmumUpdateDuration,
    );
    if (doc == null || doc.documents.isEmpty) {
      return null;
    }
    assert(doc.documents.length == 1, "more than one document with the same path");
    return doc.documents.first;
  }

  /// create a new document
  Future<CachedDocument> createDocument({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final document = await FirebaseFirestore.instance.collection(path).add(data);
    final cachedDocument = CachedDocument(
      ref: document.path,
      data: data,
      cachedAt: DateTime.now(),
    );
    _cachedDocuments.removeWhere((e) => e.ref == path);
    _cachedDocuments.add(cachedDocument);
    await _saveCache();
    return cachedDocument;
  }

  /// create a new document
  Future<CachedDocument> setDocument({
    required String path,
    required Map<String, dynamic> data,
    bool merge = false,
  }) async {
    var doc = FirebaseFirestore.instance.doc(path);
    final document = await doc.set({
      'updatedAt': FieldValue.serverTimestamp(),
      'createdAt': FieldValue.serverTimestamp(),
      'deletedAt': null,
      'ref': path,
      ...data,
    }, SetOptions(merge: merge));
    final cachedDocument = CachedDocument(
      ref: doc.path,
      data: data,
      cachedAt: DateTime.now(),
    );
    _cachedDocuments.removeWhere((e) => e.ref == path);
    _cachedDocuments.add(cachedDocument);
    try {
      await _saveCache();
    } catch (e) {
      print(e);
    }
    return cachedDocument;
  }

  /// update a document
  Future<CachedDocument> updateDocument({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    await FirebaseFirestore.instance.doc(path).update({
      ...data,
      'updatedAt': FieldValue.serverTimestamp(),
    });
    final cachedDocument = CachedDocument(
      ref: path,
      data: data,
      cachedAt: DateTime.now(),
    );
    _cachedDocuments.removeWhere((e) => e.ref == path);
    _cachedDocuments.add(cachedDocument);
    try {
      await _saveCache();
    } catch (e) {
      print(e);
    }
    return cachedDocument;
  }

  /// delete a document
  Future<void> deleteDocument({
    required String path,
    bool softDelete = true,
  }) async {
    if (softDelete) {
      await FirebaseFirestore.instance.doc(path).update({
        'deletedAt': FieldValue.serverTimestamp(),
      });
    } else {
      await FirebaseFirestore.instance.doc(path).delete();
    }
    _cachedDocuments.removeWhere((e) => e.ref == path);
    await _saveCache();
  }

  /// getDocument
  /// first check cache,
  ///   if found:
  ///     if not expired or cached befor less than 30min return it
  ///    else:
  ///    get it from firestore and cache it
  ///
  /// this function has params:
  ///  path: the path of the document in firestore
  ///  withExpired: if true, bypass the expired check
  ///  behavior: it can be: cacheOnly, serverOnly, cacheFirst, serverFirst
  // Future<CachedDocument?> getDocument({
  //   required String path,
  //   bool withExpired = false,
  //   FetchBehavior behavior = FetchBehavior.serverFirst,
  //   Duration minmumUpdateDuration = const Duration(seconds: 20),
  // }) async {
  //   if (behavior != FetchBehavior.serverOnly) {
  //     final cachedDocument = getCachedDocument(path: path, withExpired: withExpired);
  //     if (cachedDocument != null) {
  //       if (behavior == FetchBehavior.cacheOnly || behavior == FetchBehavior.cacheFirst || (!kDebugMode && cachedDocument.updatedAtOrCachedAt != null && cachedDocument.updatedAtOrCachedAt!.difference(DateTime.now()) < minmumUpdateDuration)) {
  //         return cachedDocument;
  //       }
  //       if (behavior == FetchBehavior.serverFirst) {
  //         ModelRef modelRef = ModelRef(path);
  //         final updatedAt = cachedDocument.updatedAtOrCachedAt == null ? null : Timestamp.fromDate(cachedDocument.updatedAtOrCachedAt!);

  //         /// go to current document collection
  //         /// then serach for the document with the same id where updatedAt is greater than the cached one
  //         var query = FirebaseFirestore.instance.collection(modelRef.collection).where(
  //               'ref',
  //               isEqualTo: modelRef.path,
  //             );
  //         if (updatedAt != null) {
  //           query = query
  //               .where(
  //                 'updatedAt',
  //                 isGreaterThan: updatedAt,
  //               )
  //               .where(
  //                 'deletedAt',
  //                 isNull: true,
  //               )
  //               .limit(1);
  //         }
  //         final document = await query.get();
  //         if (document.docs.isNotEmpty) {
  //           final cachedDocument = CachedDocument(
  //             ref: path,
  //             data: document.docs.first.data(),
  //             cachedAt: DateTime.now(),
  //           );
  //           _cachedDocuments.removeWhere((e) => e.ref == path);
  //           _cachedDocuments.add(cachedDocument);
  //           // await
  //           _saveCache();
  //           return cachedDocument;
  //         } else {
  //           return cachedDocument;
  //         }
  //       }
  //     }
  //   } else if (behavior == FetchBehavior.cacheOnly) {
  //     return null;
  //   }
  //   final document = await FirebaseFirestore.instance.doc(path).get();
  //   if (document.exists) {
  //     final cachedDocument = CachedDocument(
  //       ref: path,
  //       data: document.data()!,
  //       cachedAt: DateTime.now(),
  //     );
  //     _cachedDocuments.removeWhere((e) => e.ref == path);
  //     _cachedDocuments.add(cachedDocument);
  //     await _saveCache();
  //     return cachedDocument;
  //   }
  //   return null;
  // }

  /// pagination map.
  /// this map is used to store the last document of each page by the queryString as id
  Map<String, DocumentSnapshot<Map<String, dynamic>>> _paginationMap = {};

  /// getCollection
  /// first check cache,
  ///  if found:
  ///   if not expired or cached befor less than 30min return it
  /// else:
  /// get it from firestore and cache it
  /// this function has params:
  /// path: the path of the collection in firestore
  ///  withExpired: if true, bypass the expired check
  ///  behavior: it can be: cacheOnly, serverOnly, cacheFirst, serverFirst
  ///
  ///
  ///
  Future<CachedCollection?> getCollection({
    String? cacheId,
    OrderBy? orderBy,
    required String path,
    bool withExpired = false,
    bool useRef = true,
    bool useDeletedAt = true,
    // withTrashed
    bool withTrashed = false,
    FetchBehavior behavior = FetchBehavior.serverFirst,
    int limit = 100,
    Query<Map<String, dynamic>> Function(Query<Map<String, dynamic>> collection)? builder,

    /// time between each update, within this time will return the cached collection instead of going to server if behavior is serverFirst
    Duration minmumUpdateDuration = const Duration(seconds: 5),

    // startAfterRef
    Iterable<Object?>? startAfter,
  }) async {
    late Query<Map<String, dynamic>> query = FirebaseFirestore.instance.collection(path);
    if (builder != null) {
      query = builder(query);
    }

    bool hasOrderBy(String field) {
      var list = <dynamic>[];
      if (query.parameters.containsKey("orderBy")) {
        list = [
          ...query.parameters["orderBy"]
        ];
      }
      for (var item in list) {
        if (item.toString().contains(field)) {
          return true;
        }
      }
      return false;
    }

    if (!hasOrderBy("deletedAt")) {
      query = query.orderBy("deletedAt", descending: false);
    }
    if (!hasOrderBy("updatedAt")) {
      query = query.orderBy("updatedAt", descending: true);
    }

    if (startAfter != null) {
      query = query.orderBy("ref");
      query = query.startAfter(startAfter);
    }
    query = query.limit(limit);

    //
    var queryId = smallCacheId((cacheId ?? "") + path, query.parameters);
    // load cached version
    final cachedCollection = getCachedCollection(path: path, query: queryId, withExpired: withExpired);
    if (cachedCollection != null) {
      // if its cached in less than 5min then return it
      var now = DateTime.now();
      var diff = now.difference(cachedCollection.updatedAtOrCachedAt);
      if (diff < minmumUpdateDuration) {
        return cachedCollection.filter(withTrashed: withTrashed);
      }
    }

    final collection = await query.get();
    print("collection.docs.length ${collection.docs.length}");
    if (collection.docs.isNotEmpty) {
      final cachedCollection = CachedCollection(
        ref: path,
        query: queryId,
        documents: collection.docs
            .map(
              (e) => CachedDocument(
                ref: e.reference.path,
                data: e.data(),
                cachedAt: DateTime.now(),
              ),
            )
            .toList(),
        cachedAt: DateTime.now(),
      );
      _cachedCollections.removeWhere((e) => e.ref == path);
      _cachedCollections.add(cachedCollection);
      await _saveCache();
      var data = cachedCollection.filter(withTrashed: withTrashed);
      return data;
    }
    return null;
  }

  Future<CachedCollection?> getCollectionX({
    String? cacheId,
    OrderBy? orderBy,
    required String path,
    bool withExpired = false,
    bool useRef = true,
    bool useDeletedAt = true,
    // withTrashed
    bool withTrashed = false,
    FetchBehavior behavior = FetchBehavior.serverFirst,
    int limit = 100,
    Query<Map<String, dynamic>> Function(Query<Map<String, dynamic>> collection)? builder,

    /// time between each update, within this time will return the cached collection instead of going to server if behavior is serverFirst
    Duration minmumUpdateDuration = const Duration(seconds: 5),

    // startAfterRef
    Iterable<Object?>? startAfter,
  }) async {
    Query<Map<String, dynamic>> query = FirebaseFirestore.instance.collection(path);
    if (useRef) {
      query = query.orderBy("ref");
    }
    if (startAfter != null) {
      query = query.startAfter(startAfter);
    }

    if (builder != null) {
      query = builder(FirebaseFirestore.instance.collection(path));
      if (useRef) {
        query = query.orderBy("ref");
      }
      if (startAfter != null) {
        query = query.startAfter(startAfter);
      }
    }

    if (useDeletedAt) {
      query = query.where('deletedAt', isNull: true);
    }

    query = query.limit(limit);

    var queryString = smallCacheId((cacheId ?? "") + path, {
      ...query.parameters,
      "orderBy": orderBy.toString(),
    });

    if (behavior != FetchBehavior.serverOnly) {
      final cachedCollection = getCachedCollection(path: path, query: queryString, withExpired: withExpired);
      if (cachedCollection != null) {
        // if its cached in less than 5min then return it
        var now = DateTime.now();
        var diff = now.difference(cachedCollection.updatedAtOrCachedAt);
        if (diff < minmumUpdateDuration) {
          return cachedCollection.filter(withTrashed: withTrashed);
        }
        if (behavior == FetchBehavior.cacheOnly || behavior == FetchBehavior.cacheFirst) {
          return cachedCollection.filter(withTrashed: withTrashed);
        }
        if (behavior == FetchBehavior.serverFirst) {
          /// go to current document collection
          /// then serach for the document with the same id where updatedAt is greater than the cached one
          Query<Map<String, dynamic>> query2;
          try {
            query2 = query.where(
              'updatedAt',
              isGreaterThan: Timestamp.fromDate(cachedCollection.updatedAtOrCachedAt),
            );
          } catch (e) {
            query2 = FirebaseFirestore.instance.collection(path).where(
                  'updatedAt',
                  isGreaterThan: Timestamp.fromDate(cachedCollection.updatedAtOrCachedAt),
                );
          }
          if (orderBy != null) {
            query2 = query.orderBy(orderBy.field, descending: orderBy.descending);
          }

          final document = await query2.get();
          if (document.docs.isNotEmpty) {
            if (kDebugMode) {
              print("update ${document.docs.length}/${cachedCollection.documents.length} for $path");
            }
            final ncachedCollection = cachedCollection.addAllAndClone(
              document.docs
                  .map(
                    (e) => CachedDocument(
                      ref: e.reference.path,
                      data: e.data(),
                      cachedAt: DateTime.now(),
                    ),
                  )
                  .toList(),
            );
            _cachedCollections.removeWhere((e) => e.ref == path);
            _cachedCollections.add(ncachedCollection);
            // i commented this line because it takes time to save the cache and it will block the ui
            // await
            _saveCache();
            return ncachedCollection.filter(withTrashed: withTrashed);
          } else {
            return cachedCollection.filter(withTrashed: withTrashed);
          }
        }
      }
    } else if (behavior == FetchBehavior.cacheOnly) {
      return null;
    }

    if (orderBy != null) {
      query = query.orderBy(orderBy.field, descending: orderBy.descending);
    }
    final collection = await query.get();
    if (collection.docs.isNotEmpty) {
      final cachedCollection = CachedCollection(
        ref: path,
        query: queryString,
        documents: collection.docs
            .map(
              (e) => CachedDocument(
                ref: e.reference.path,
                data: e.data(),
                cachedAt: DateTime.now(),
              ),
            )
            .toList(),
        cachedAt: DateTime.now(),
      );
      _cachedCollections.removeWhere((e) => e.ref == path);
      _cachedCollections.add(cachedCollection);
      // await
      _saveCache();
      var data = cachedCollection.filter(withTrashed: withTrashed);
      return data;
    }
    return null;
  }

  List<CachedDocument> _filterTrashed(List<CachedDocument> docs) {
    return docs.where((doc) => doc.data["deletedAt"] == null).toList();
  }

  /// count cache
  Map<String, int> _countCache = {};

  /// [getAverage]
  Future<CachedAggregate?> getAverage({
    required String field,
    String? cacheId,
    OrderBy? orderBy,
    required String path,
    bool withExpired = false,
    // withTrashed
    bool withTrashed = false,
    FetchBehavior behavior = FetchBehavior.cacheFirst,
    Query<Map<String, dynamic>> Function(Query<Map<String, dynamic>> collection)? builder,

    /// time between each update, within this time will return the cached collection instead of going to server if behavior is serverFirst
    Duration minmumUpdateDuration = const Duration(seconds: 5),

    // startAfterRef
    Iterable<Object?>? startAfter,
  }) async {
    Query<Map<String, dynamic>> query = FirebaseFirestore.instance.collection(path).orderBy("ref");
    if (startAfter != null) {
      query = query.startAfter(startAfter);
    }

    if (builder != null) {
      query = builder(FirebaseFirestore.instance.collection(path));
      query = query.orderBy("ref");
      if (startAfter != null) {
        query = query.startAfter(startAfter);
      }
    }

    query = query.where(
      'deletedAt',
      isNull: true,
    );

    var queryString = smallCacheId("average_${cacheId ?? ""}$path", {
      ...query.parameters,
      "orderBy": orderBy.toString(),
    });
    CachedAggregate? _cachedAverage;
    CachedAggregate? _average;
    CachedAggregate? _getCachedAggregate() {
      _cachedAverage = _cachedAverage ?? getCachedAggregate(path: path, query: queryString, withExpired: withExpired);
      return _cachedAverage;
    }

    Future<CachedAggregate?> _getAverage() async {
      if (_average != null) {
        return Future.value(_average);
      }
      // try {
      var response = await query.aggregate(average(field)).get();
      _average = CachedAggregate(
        ref: path,
        query: queryString,
        value: response.getAverage(field)!,
        cachedAt: DateTime.now(),
        expiresAt: DateTime.now().add(minmumUpdateDuration),
      );
      _cachedAggregates.removeWhere((e) => e.ref == path);
      _cachedAggregates.add(_average!);
      await _saveCache();
      return _average;
      // } catch (e) {
      //   _average = null;
      //   print(e);
      //   rethrow;
      // }
    }

    if (behavior == FetchBehavior.cacheOnly) {
      return _getCachedAggregate();
    } else if (behavior == FetchBehavior.serverOnly) {
      await _getAverage();
      return _average;
    } else if (behavior == FetchBehavior.cacheFirst) {
      return _getCachedAggregate() ?? await _getAverage();
    } else if (behavior == FetchBehavior.serverFirst) {
      return await _getAverage() ?? _getCachedAggregate();
    }

    return null;
  }

  /// [getSum]
  Future<CachedAggregate?> getSum({
    required String field,
    String? cacheId,
    OrderBy? orderBy,
    required String path,
    bool withExpired = false,
    // withTrashed
    bool withTrashed = false,
    FetchBehavior behavior = FetchBehavior.cacheFirst,
    Query<Map<String, dynamic>> Function(Query<Map<String, dynamic>> collection)? builder,

    /// time between each update, within this time will return the cached collection instead of going to server if behavior is serverFirst
    Duration minmumUpdateDuration = const Duration(seconds: 5),

    // startAfterRef
    Iterable<Object?>? startAfter,
  }) async {
    Query<Map<String, dynamic>> query = FirebaseFirestore.instance.collection(path).orderBy("ref");
    if (startAfter != null) {
      query = query.startAfter(startAfter);
    }

    if (builder != null) {
      query = builder(FirebaseFirestore.instance.collection(path));
      query = query.orderBy("ref");
      if (startAfter != null) {
        query = query.startAfter(startAfter);
      }
    }

    query = query.where(
      'deletedAt',
      isNull: true,
    );

    var queryString = smallCacheId("sum_${cacheId ?? ""}$path", {
      ...query.parameters,
      "orderBy": orderBy.toString(),
    });
    CachedAggregate? _cachedSum;
    CachedAggregate? _sum;
    CachedAggregate? _getCachedAggregate() {
      _cachedSum = _cachedSum ?? getCachedAggregate(path: path, query: queryString, withExpired: withExpired);
      return _cachedSum;
    }

    Future<CachedAggregate?> _getSum() async {
      if (_sum != null) {
        return Future.value(_sum);
      }
      // try {
      var response = await query.aggregate(sum(field)).get();
      _sum = CachedAggregate(
        ref: path,
        query: queryString,
        value: response.getSum(field)!,
        cachedAt: DateTime.now(),
        expiresAt: DateTime.now().add(minmumUpdateDuration),
      );
      _cachedAggregates.removeWhere((e) => e.ref == path);
      _cachedAggregates.add(_sum!);
      await _saveCache();
      return _sum;
      // } catch (e) {
      //   _sum = null;
      //   print(e);
      //   rethrow;
      // }
    }

    if (behavior == FetchBehavior.cacheOnly) {
      return _getCachedAggregate();
    } else if (behavior == FetchBehavior.serverOnly) {
      await _getSum();
      return _sum;
    } else if (behavior == FetchBehavior.cacheFirst) {
      return _getCachedAggregate() ?? await _getSum();
    } else if (behavior == FetchBehavior.serverFirst) {
      return await _getSum() ?? _getCachedAggregate();
    }

    return null;
  }

  /// [getCount]
  Future<CachedAggregate?> getCount({
    String? cacheId,
    OrderBy? orderBy,
    required String path,
    bool withExpired = false,
    // withTrashed
    bool withTrashed = false,
    FetchBehavior behavior = FetchBehavior.cacheFirst,
    Query<Map<String, dynamic>> Function(Query<Map<String, dynamic>> collection)? builder,

    /// time between each update, within this time will return the cached collection instead of going to server if behavior is serverFirst
    Duration minmumUpdateDuration = const Duration(seconds: 5),

    // startAfterRef
    Iterable<Object?>? startAfter,
  }) async {
    Query<Map<String, dynamic>> query = FirebaseFirestore.instance.collection(path).orderBy("ref");
    if (startAfter != null) {
      query = query.startAfter(startAfter);
    }

    if (builder != null) {
      query = builder(FirebaseFirestore.instance.collection(path));
      query = query.orderBy("ref");
      if (startAfter != null) {
        query = query.startAfter(startAfter);
      }
    }

    query = query.where(
      'deletedAt',
      isNull: true,
    );

    var queryString = smallCacheId("count_${cacheId ?? ""}$path", {
      ...query.parameters,
      "orderBy": orderBy.toString(),
    });
    CachedAggregate? _cachedCount;
    CachedAggregate? _count;
    CachedAggregate? _getCachedAggregate() {
      _cachedCount = _cachedCount ?? getCachedAggregate(path: path, query: queryString, withExpired: withExpired);
      return _cachedCount;
    }

    Future<CachedAggregate?> _getCount() async {
      if (_count != null) {
        return Future.value(_count);
      }
      // try {
      var response = await query.aggregate(count()).get();
      _count = CachedAggregate(
        ref: path,
        query: queryString,
        value: response.count!,
        cachedAt: DateTime.now(),
        expiresAt: DateTime.now().add(minmumUpdateDuration),
      );
      _cachedAggregates.removeWhere((e) => e.ref == path);
      _cachedAggregates.add(_count!);
      await _saveCache();
      return _count;
      // } catch (e) {
      //   _count = null;
      //   print(e);
      //   rethrow;
      // }
    }

    if (behavior == FetchBehavior.cacheOnly) {
      return _getCachedAggregate();
    } else if (behavior == FetchBehavior.serverOnly) {
      await _getCount();
      return _count;
    } else if (behavior == FetchBehavior.cacheFirst) {
      return _getCachedAggregate() ?? await _getCount();
    } else if (behavior == FetchBehavior.serverFirst) {
      return await _getCount() ?? _getCachedAggregate();
    }

    return null;
  }

  // String _firestoreQueryToString(String id, Query<Map<String, dynamic>> query) {
  //   return jsonEncode(
  //     query.parameters,
  //     toEncodable: (e) {
  //       if (e is FieldPath) {
  //         return e.components;
  //       } else {
  //         return e.toString();
  //       }
  //     },
  //   );
  // }

  String smallCacheId(String id, Map<String, dynamic> query) {
    var map = {
      "id": id,
      "query": query,
    };
    var json = jsonEncode(
      map,
      toEncodable: (e) {
        if (e is FieldPath) {
          return e.components;
        } else {
          return e.toString();
        }
      },
    );
    return json.hashCode.toString();
    var hash = sha256.convert(utf8.encode(json)).toString();
    var confirmHash = sha256.convert(utf8.encode(json)).toString();
    assert(confirmHash == hash, "hash is not correct");
    return hash;
  }

  @override
  void dispose() {
    super.dispose();
    log.info('App~Service: Database disposed');
  }

  /// getPreferences
  Future<List<Map<String, dynamic>>> getPreferences() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    /// data in this app stored in firestore
    final prefs = await firestore.collection('preferences').get();

    /// here we load all documents in the collection "preferences"
    return prefs.docs.map((e) {
      return {
        'id': e.id,
        ...e.data(),
      };
    }).toList();
  }

  /// getPreferencesStream
  Stream<Map<String, Map<String, dynamic>>> getPreferencesStream() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    /// data in this app stored in firestore
    final prefs = firestore.collection('preferences').snapshots();

    /// here we load all documents in the collection "preferences"
    return prefs.map((e) {
      return {
        for (var doc in e.docs) doc.id: doc.data(),
      };
    });
  }

  /// getProfile
  Future<ProfileModel> getProfile({
    required String uid,
    cacheFirst = true,
  }) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    DocumentSnapshot<Map<String, dynamic>> profile;
    final query = firestore.collection('profiles').doc(uid);
    if (cacheFirst) {
      profile = await query.getCacheFirst();
    } else {
      profile = await query.get();
    }

    /// here we load all documents in the collection "profiles"
    return ProfileModel.fromJson({
      'ref': profile.reference.path,
      ...profile.data()!,
    });
  }

  /// getProfileStream
  Stream<ProfileModel> getProfileStream({
    required String uid,
  }) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    DocumentReference<Map<String, dynamic>> profile;
    final query = firestore.collection('profiles').doc(uid);

    /// here we load all documents in the collection "profiles"
    return query.snapshots().map((e) {
      return ProfileModel.fromJson({
        'ref': e.reference.path,
        ...e.data()!,
      });
    });
  }
}
