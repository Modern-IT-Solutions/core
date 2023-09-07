
// abstract class Model {
//   Map<String, dynamic> toMap();

//   // createdAt
//   DateTime? get createdAt => null;
//   // updatedAt
//   DateTime? get updatedAt => null;
//   // deletedAt
//   DateTime? get deletedAt => null;
//   // expiredAt
//   DateTime? get expiredAt => null;
// }

/// firestore model
/// the deffrence between firestore model and model is that firestore model
/// has a reference to the document id,
/// the reference is used to update and delete the document but not in model it self
// abstract class FirestoreModel extends Model {
//   static Query<Map<String, dynamic>> query(String path) => FirebaseFirestore.instance.collection(path).where(
//     'deletedAt', isNull: true,
//   );
  
//   // static Query<Map<String, dynamic>> add(Map<String,dynamic> data) => FirebaseFirestore.instance.collection(path).where(
//   //   'deletedAt', isNull: true,
//   // );
  

//   String get ref;

//   // reference getter
//   DocumentReference get reference => FirebaseFirestore.instance.doc(ref);

//   // id getter
//   String get id => ref.split('/').last;

//   // toFirestore method
//   // it same as toMap but it exclude the ref field
//   Map<String, dynamic> toFirestore() {
//     final map = toMap();
//     map.remove('ref');
//     return map;
//   }


//   // softDelete()
//   Future<void> softDelete() async {
//     await reference.update({
//       'deletedAt': FieldValue.serverTimestamp(),
//     });
//   }
// }