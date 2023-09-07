// import '../../domain/repositories/user_repositor_interface.dart';
// import '../datasources/users_datasource.dart';
// import '../models/user_model.dart';

// /// [StationRepository] is a class that contains all the CRUD of user
// class UserRepository<T extends UserModel>
//     extends UserRepositoryInterface<T> {
//   final UserDataSource<T> source;

//   /// singleton class
//   UserRepository(this.source);
//   static final instance = UserRepository<UserModel>(UsersFirebaseDateSource());

//   updateCustomClaims(
//       {required String uid, required Map<String, dynamic> claims}) async {
//     await source.updateCustomClaims(uid, claims);
//   }

  
//   @override
//   Future<UserModel?> findByPhone(String phone) {
//     return source.findByPhone(phone);
//   }

//   @override
//   Future<UserModel?> findByEmail(String email) {
//     return source.findByEmail(email);
//   }

//   @override
//   Future<void> addOfflineSuplier(String uid, DateTime? expires) {
//     return source.addOfflineSuplier(uid, expires);
//   }

//   @override
//   Future<void> removeOfflineSuplier(String uid) {
//     return source.removeOfflineSuplier(uid);
//   }

//   @override
//   Future<void> revokeRefreshTokens(String uid) {
//     return source.revokeRefreshTokens(uid);
//   }
// }
