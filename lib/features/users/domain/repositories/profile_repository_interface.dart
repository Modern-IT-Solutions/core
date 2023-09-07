
import 'package:core/core.dart';



/// [ProfileRepositoryInterface]
abstract class ProfileRepositoryInterface<T extends ProfileModel>
    extends RepositoryInterface<T> {

  Future<T> create(ProfileCreateRequest<T> request);
  Future<T?> find(FindRequest<T> request);
  Future<ListResult<T>> list([ListRequest<T>? request]);
  Future<void> update(ProfileUpdateRequest<T> request);
  Future<void> delete(DeleteRequest<T> request);
    }
