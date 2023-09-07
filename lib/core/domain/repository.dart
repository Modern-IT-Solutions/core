import 'package:core/core.dart';


abstract class RepositoryInterface<
  T extends Model>
  
  //  extends CFLUDInterface<T> 
   
   {
  // data source getter
  DataSource<T> get source;

  // Future<T> create(C request) async => await source.create(request);
  // Future<T?> find(F request) async => await source.find(request);
  // Future<ListResult<T>> list(L request) async => await source.list(request);
  // Future<void> update(U request) async => await source.update(request);
  // Future<void> delete(D request) async => await source.delete(request);
}

// CRUD interface
abstract class CFLUDInterface<
  T extends Model
  // , 
  // F extends FindRequest,
  // C extends CreateRequest,
  // L extends ListRequest, 
  // U extends UpdateRequest,
  // D extends DeleteRequest
  > {
  Future<T> create(CreateRequest<T> request);
  Future<T?> find(FindRequest<T> request);
  Future<ListResult<T>> list(ListRequest<T> request);
  Future<void> update(UpdateRequest<T> request);
  Future<void> delete(DeleteRequest<T> request);
}


/// [SearchQuery] is a class to build a query to search
class SearchQuery {
  final String field;
  final String? value;

  const SearchQuery({required this.field,this.value});

  Map<String, dynamic> toMap() => {
    'field': field,
    'value': value,
  };
}