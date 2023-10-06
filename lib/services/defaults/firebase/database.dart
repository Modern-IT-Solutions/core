// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';

// ignore: depend_on_referenced_packages
import 'package:crypto/crypto.dart';
import 'package:core/services/consts/consts.dart';
// ignore: depend_on_referenced_packages
import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
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
  
    return 
      other.field == field &&
      other.descending == descending;
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

  bool get isEmpty => _cachedDocuments.isEmpty && _cachedCollections.isEmpty;
  int get length => _cachedDocuments.length + 
    // get inner docs length
    _cachedCollections.fold(0, (previousValue, element) => previousValue + element.documents.length);

  Future<void> clearCache() async {
     await prefs.clear();
    _cachedDocuments = [];
    _cachedCollections = [];
     notifyListeners();
  }

  Future<void> _loadCache() async {
    final cachedDocuments = prefs.getStringList('cached_documents');
    if (cachedDocuments != null) {
      _cachedDocuments = cachedDocuments.map((e) => CachedDocument.fromJson(jsonDecode(e))).toList();
    }

    final cachedCollections = prefs.getStringList('cached_collections');
    if (cachedCollections != null) {
      _cachedCollections = cachedCollections.map((e) => CachedCollection.fromJson(jsonDecode(e))).toList();
    }
  }

  Future<void> _saveCache() async {
    final cachedDocuments = _cachedDocuments.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList('cached_documents', cachedDocuments);

    final cachedCollections = _cachedCollections.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList('cached_collections', cachedCollections);
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
    Iterable<CachedCollection> cachedCollection;
    if (query == null) {
      cachedCollection = _cachedCollections.where((e) => e.ref == path);
    } else {
      cachedCollection = _cachedCollections.where((e) => e.ref == path && e.query == query);
    }
    if (cachedCollection.isEmpty) {
      return null;
    }
    cachedCollection = cachedCollection.where((e) => e.expiresAt == null || e.expiresAt!.isAfter(DateTime.now()));
    if (cachedCollection.isEmpty) {
      return null;
    }
    return cachedCollection.first;
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
    await _saveCache();
    return cachedDocument;
  }

  /// delete a document
  Future<void> deleteDocument({
    required String path,
  }) async {
    await FirebaseFirestore.instance.doc(path).delete();
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
  Future<CachedCollection?> getCollection({
    String? cacheId,
    OrderBy? orderBy,
    required String path,
    bool withExpired = false,
    // withTrashed
    bool  withTrashed = false,
    FetchBehavior behavior = FetchBehavior.serverFirst,
    int limit = 100,
    Query<Map<String, dynamic>> Function(Query<Map<String, dynamic>> collection)? builder,

    /// time between each update, within this time will return the cached collection instead of going to server if behavior is serverFirst
    Duration minmumUpdateDuration = const Duration(seconds: 5),

  }) async {
    // orderBy ??= const OrderBy(field: "updatedAt", descending: true);
    Query<Map<String, dynamic>> query = FirebaseFirestore.instance.collection(path);

    if (builder != null) {
      query = builder(query);
    }
    print(query.parameters);


    query = query
        // .where(
        //   'deletedAt',
        //   isNull: true,
        // )
        .limit(limit);

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
          Query<Map<String, dynamic>> query2 = query.where(
            'updatedAt',
            isGreaterThan: Timestamp.fromDate(cachedCollection.updatedAtOrCachedAt),
          );
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
