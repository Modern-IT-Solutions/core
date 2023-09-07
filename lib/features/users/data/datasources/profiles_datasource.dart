import 'package:core/core.dart';


abstract class ProfileDataSource<
    T extends ProfileModel>
    extends DataSource<
    T> implements CFLUDInterface<T> {}

class ProfilesFirebaseDateSource extends ProfileDataSource<
  ProfileModel
  > with FirestoreDataSourceMixin<ProfileModel> {
  @override
  String get cref => 'profiles';

  fromFirestore(snapshot, _) {
    return ProfileModel.fromJson(
      {
        ...snapshot.data()!,
        'ref': snapshot.reference.path,
      },
    );
  }
}

