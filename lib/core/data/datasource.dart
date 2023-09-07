import 'package:core/core.dart';


abstract class DataSource<
    T extends Model> {}

abstract class NetworkDataSource {}

abstract class CacheDataSource {}

/// [FirestoreDataSource] is a mixin that implements the firestore methods
abstract class FirestoreDataSource<
    T extends Model> extends DataSource<T> {
  String get cref;
  FirebaseFirestore get db => FirebaseFirestore.instance;
  // collection getter with converter
  CollectionReference<T> get collection => db.collection(cref).withConverter<T>(
        fromFirestore: fromFirestore,
        toFirestore: toFirestore,
      );
  // collection withou converter (put ref: doc.path in the map)
  CollectionReference<Map<String, dynamic>> get collectionMap => db
          .collection(cref)
          .withConverter<Map<String, dynamic>>(fromFirestore: (snapshot, _) {
        return {"ref": snapshot.reference.path, ...snapshot.data()!};
      }, toFirestore: (model, _) {
        model.remove("ref");
        return model;
      });

  Future<T> create(CreateRequest<T> request) async {
    var map = {
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': null,
      'deletedAt': null,
      ...request.toMap(),
    };
    if (request.id != null) {
      await collectionMap.doc(request.id).set(map);
      return (await collection.doc(request.id).get()).data()!;
    }
    var result = await collectionMap.add(map);
    return fromFirestore(await result.get(), null);
  }

  Future<ListResult<T>> list(ListRequest<T> request) async {
    Query<T> dbquery = collection;
    if (request.limit != null) {
      dbquery = dbquery.limit(request.limit!);
    }
    if (!request.withDeleted) {
      dbquery = dbquery.where('deletedAt', isNull: true);
    }
    if (request.searchQuery != null && request.searchQuery?.value != null) {
      // query is a list of where clauses
      dbquery = dbquery
          .where(request.searchQuery!.field, isGreaterThanOrEqualTo: request.searchQuery!.value)
          .where(request.searchQuery!.field, isLessThanOrEqualTo: request.searchQuery!.value! + '\uf8ff');
    }
    if (request.queryBuilder != null) {
      dbquery = request.queryBuilder!(dbquery);
    }
    var ql = await dbquery.get(
      request.options == null? null: request.options,
     );
    return ql.toListResult();
  }

  update(request) async {
    var map = {
      'updatedAt': FieldValue.serverTimestamp(),
      ...request.toMap(),
    };
    await collection.doc(request.id).update(map as Map<String, dynamic>);
  }

  delete(request) async {
    if (request.softDelete) {
      await collection.doc(request.id).update({
        'deletedAt': FieldValue.serverTimestamp(),
      });
    } else
    await collection.doc(request.id).delete();
  }

  find(request) async {
    if (request.withDeleted) {
      return (await collection.doc(request.id).get()).data();
    } else {
      /// get list of documents limited to 1
      /// where deletedAt is null
      var ql = await collection
          .where('deletedAt', isNull: true)
          .where('id', isEqualTo: request.id)
          .limit(1)
          .get();
      if (ql.docs.length > 0) {
        return ql.docs.first.data();
      } else {
        return null;
      }
    }
  }

  T fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? _);
  Map<String, dynamic> toFirestore(T model, SetOptions? _) =>
      model.toJson();
}

/// [FirestoreDataSourceInterface] is an interface for firestore data sources
abstract class FirestoreDataSourceInterface<
    T extends Model> extends DataSource<T>{}

/// [FirestoreDataSourceMixin] is a mixin that implements the firestore methods
/// for a firestore data source
mixin FirestoreDataSourceMixin<
    T extends Model> implements CFLUDInterface<T> {
  String get cref;
  FirebaseFirestore get db => FirebaseFirestore.instance;
  // collection getter with converter
  CollectionReference<T> get collection => db.collection(cref).withConverter<T>(
        fromFirestore: fromFirestore,
        toFirestore: toFirestore,
      );
  // collection withou converter (put ref: doc.path in the map)
  CollectionReference<Map<String, dynamic>> get collectionMap => db
          .collection(cref)
          .withConverter<Map<String, dynamic>>(fromFirestore: (snapshot, _) {
        return {"ref": snapshot.reference.path, ...snapshot.data()!};
      }, toFirestore: (model, _) {
        model.remove("ref");
        return model;
      });

  create(request) async {
    Map<String, dynamic> map = {
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': null,
      'deletedAt': null,
      ...request.data,
    };//.toFirebaseJson();
    print(map);
    if (request.id != null) {
      await collectionMap.doc(request.id).set(map);
      return (await collection.doc(request.id).get()).data()!;
    }
    var result = await collectionMap.add(map);
    return fromFirestore(await result.get(), null);
  }

  list(request) async {
    Query<T> dbquery = collection;
    if (request.limit != null) {
      dbquery = dbquery.limit(request.limit!);
    }
    if (!request.withDeleted) {
      dbquery = dbquery.where('deletedAt', isNull: true);
    }
    if (request.searchQuery != null && request.searchQuery?.value != null) {
      // query is a list of where clauses
      dbquery = dbquery
          .where(request.searchQuery!.field, isGreaterThanOrEqualTo: request.searchQuery!.value)
          .where(request.searchQuery!.field, isLessThanOrEqualTo: request.searchQuery!.value! + '\uf8ff');
    }
    if (request.queryBuilder != null) {
      dbquery = request.queryBuilder!(dbquery);
    }
    var ql = await dbquery.get(
      request.options == null? null: request.options,
     );
    return ql.toListResult();
  }

  update(request) async {
    Map<String, dynamic> map = {
      'updatedAt': FieldValue.serverTimestamp(),
      ...request.toMap(),
    }.toFirebaseJson();
    await collection.doc(request.id).update(map);
  }

  delete(request) async {
    if (request.softDelete) {
      await collection.doc(request.id).update({
        'deletedAt': FieldValue.serverTimestamp(),
      });
    } else
    await collection.doc(request.id).delete();
  }

  find(request) async {
    if (request.withDeleted) {
      return (await collection.doc(request.id).get()).data();
    } else {
      /// get list of documents limited to 1
      /// where deletedAt is null
      var ql = await collection
          .where('deletedAt', isNull: true)
          .where('id', isEqualTo: request.id)
          .limit(1)
          .get();
      if (ql.docs.length > 0) {
        return ql.docs.first.data();
      } else {
        return null;
      }
    }
  }

  T fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? _);
  Map<String, dynamic> toFirestore(T model, SetOptions? _) =>
      model.toJson().toFirebaseJson();
}


/// [toFirebaseJson] extension on [Map<String, dynamic>]
extension FirebaseMapExtension on Map<String, dynamic> {
  Map<String, dynamic> toFirebaseJson() {
    final Map<String, dynamic> json = {};
    this.forEach((key, value) {
      if (value is DateTime) {
        json[key] = Timestamp.fromDate(value);
      }
    });
    return json;
  }
}