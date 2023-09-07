// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:core/core.dart';

/// [ProfileRepository] is a class that contains all the CRUD of user
class ProfileRepository<T extends ProfileModel>
    extends ProfileRepositoryInterface<ProfileModel> {
  @override
  final ProfileDataSource<T> source;

  /// singleton class
  ProfileRepository(this.source);
  static final instance = ProfileRepository(ProfilesFirebaseDateSource());

  @override
  Future<T> create(ProfileCreateRequest<ProfileModel> request) async => await source.create(request as CreateRequest<T>);
  @override
  Future<T?> find(FindRequest<ProfileModel> request) async => await source.find(request as FindRequest<T>);
  @override
  Future<void> update(ProfileUpdateRequest<ProfileModel> request) async => await source.update(request as UpdateRequest<T>);
  @override
  Future<void> delete(DeleteRequest<ProfileModel> request) async => await source.delete(request as DeleteRequest<T>);
  
  @override
  Future<ListResult<ProfileModel>> list([ListRequest<ProfileModel>? request]) async {
    return await source.list(request as ListRequest<T>);
  }



}
