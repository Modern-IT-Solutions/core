
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';

/// [Model] is interface for all models.
/// it contains : ref, createdAt, updatedAt, deletedAt
abstract class Model {
  const Model();
  /// [toJson] is a method that converts the model to a map.
  Map<String, dynamic> toJson();

  ModelRef get ref;
  DateTime get createdAt;
  DateTime get updatedAt;
  DateTime? get deletedAt;
}

extension ModelExtension on Model {
  /// [id] getter.
  String get id => ref.id;

  /// [collection] getter.
  String get collection => ref.collection;
} 


abstract class FirestoreModel extends Model {
  static Query<Map<String, dynamic>> query(String path) => FirebaseFirestore.instance.collection(path).where(
    'deletedAt', isNull: true,
  );
  const FirestoreModel();
  /// [toJson] is a method that converts the model to a map.
  Map<String, dynamic> toFirestore();
}
