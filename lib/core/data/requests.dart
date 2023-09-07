// update request
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';

import '../domain/repository.dart';

/// [BaseRequest] is a base class for requests
abstract class BaseRequest<T extends Model> {
  const BaseRequest();
  Map<String, dynamic> toMap();
  /// [toJsonMap] remove fields that are not json serializable
  Map<String, dynamic> toJsonMap() {
    var map = toMap();
    var serializableTypes = [
      String,
      int,
      double,
      bool,
      List,
      Map,
    ];
    map.removeWhere((key, value) {
      return !serializableTypes.contains(value.runtimeType);
    });
    return map;
  }
}
/// [UpdateRequest] is a base class for update requests
abstract class UpdateRequest<T extends Model> extends BaseRequest<T> {
  final Map<String, dynamic> data;
  final String id;
  UpdateRequest({required this.id, this.data = const {}});

  /// [toMap] returns a map with the request data
  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'data': data,
    };
  }}
// create request
 class CreateRequest<T extends Model> extends BaseRequest<T> {

  final Map<String, dynamic> data;
  final String? id;
  CreateRequest({this.id,this.data = const {}});

  /// [toMap] returns a map with the request data
  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'data': data,
    };
  }
}
// delete request
 class DeleteRequest<T extends Model> extends BaseRequest<T> {
  final String id;
  /// [softDelete] if true, set deletedAt field without remove the document
  /// if false, remove the document
  final bool softDelete;
  DeleteRequest(this.id, {this.softDelete = true});

  /// [toMap] returns a map with the request data
  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'softDelete': softDelete,
    };
  }
}
/// [ListRequest] is a base class for list requests
class ListRequest<T extends Model> extends BaseRequest<T> {
  /// [withDeleted] if true, return deleted documents
  final bool withDeleted;

  /// [options] is a list of options to apply to the query
  final GetOptions? options;

  /// limit of documents to return
  final int? limit;
  /// custom query builder
  final Query<T> Function<T>(Query<T> query)? queryBuilder;
  /// search query
  final SearchQuery? searchQuery;

  ListRequest({
    this.queryBuilder,
    this.searchQuery,
    this.limit,
    this.withDeleted = false,
    this.options,
  });

  /// [search] constructor
  ListRequest.search(String search, {
    required String field,
    this.queryBuilder,
    this.limit,
    this.withDeleted = false,
    this.options,
  }) : searchQuery = SearchQuery(
    field: field,
    value: search,
  );

  /// [toMap] returns a map with the request data
  @override
  Map<String, dynamic> toMap() {
    return {
      'withDeleted': withDeleted,
      'limit': limit,
      // 'queryBuilder': queryBuilder,
      'searchQuery': searchQuery?.toMap(),
    };
  }}
/// [FindRequest] is a base class for find requests
 class FindRequest<T extends Model> extends BaseRequest<T> {
  final String id;
  final bool withDeleted;
  const FindRequest({
    required this.id,
    this.withDeleted = false});

  /// [toMap] returns a map with the request data
  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'withDeleted': withDeleted,
    };
  }}
