// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cloud_functions/cloud_functions.dart';
// import 'package:dashboard/core/data/datasource.dart';
// import 'package:dashboard/core/data/results.dart';
// import 'package:flutter/foundation.dart';
// import 'package:shared/models/base.dart';

// import '../../domain/request/requests.dart';
// import '../models/user_model.dart';
// import '../repositories/repository.dart';

// abstract class UserDataSource<T extends Model>
//     extends DataSource<T> {
//   Future<void> updateCustomClaims(String uid, Map<String, dynamic> claims);
//   Future<UserModel?> findByPhone(String phone);
//   Future<UserModel?> findByEmail(String email);
//   Future<void> addOfflineSuplier(String uid, DateTime? expires);
//   Future<void> removeOfflineSuplier(String uid);
//   // users_logout
//   Future<void> revokeRefreshTokens(String uid);
// }

// class UsersFirebaseDateSource extends UserDataSource<UserModel> {
//   // call
//   Future<HttpsCallableResult<T>> call<T>(String function, [dynamic parameters]) async {
//     debugPrint('>>> $function($parameters))');
//     return await FirebaseFunctions.instance
//         .httpsCallable(function)
//         .call(parameters);
//   }

//   list({max = 20, next,query}) async {
//     var query = <String, dynamic>{'max': max};
//     if (next != null) query['next'] = next;

//     var result = await call('users_list',query);
//     return ListResult.fromMapWithConverter<UserModel>(
//         map: result.data, converter: UserModel.fromMap);
//   }

//   create(user) async {
//     var result = await call('users_create',user.toMap());
//     return UserModel.fromMap(result.data);
//   }

//   update(uid, request) async {
//     await call('users_update', {'uid': uid, 'form': request.toMap()});
//   }

//   delete(uid) async {
//     await call('users_delete', {'uid': uid});
//   }

//   updateCustomClaims(uid, claims) async {
//     await call('users_update_custom_claims', {'uid': uid, 'claims': claims});
//   }

//   find(uid) async {
//     var result = await call('users_find', {'value': uid, 'by': 'uid'});
//     return UserModel.fromMap(result.data);
//   }

//   findByPhone(String phone) async {
//     var result = await call('users_find', {'value': phone, 'by': 'phone'});
//     return UserModel.fromMap(result.data);
//   }

//   findByEmail(String email) async {
//     var result = await call('users_find', {'value': email, 'by': 'email'});
//     return UserModel.fromMap(result.data);
//   }

//   addOfflineSuplier(String uid, DateTime? expires) {
//     return call('users_add_offline_suplier', {'uid': uid, 'expires': expires});
//   }

//   removeOfflineSuplier(String uid) {
//     return call('users_remove_offline_suplier', {'uid': uid});
//   }

//   revokeRefreshTokens(String uid) {
//     return call('users_revoke_refresh_tokens', {'uid': uid});
//   }

//   /// helpers
//   /// fromFirestore:
//   UserModel fromFirestore(
//       DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? _) {
//     return UserModel.fromMap(snapshot.data()!);
//   }

//   /// toFirestore:
//   Map<String, dynamic> toFirestore(UserModel user, SetOptions? _) {
//     return user.toJson();
//   }
// }
