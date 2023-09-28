
// extension QuerySnapshot toListResult<T extends Model>(QuerySnapshot snapshot) {
import 'package:core/core.dart';

extension QuerySnapshotToListResult<T extends Model> on QuerySnapshot<T> {
  ListResult<T> toListResult() {
    List<T> items = [];
    for (var i = 0; i < docs.length; i++) {
      if (i>50) break;
      items.add(docs[i].data());
    }
    return ListResult<T>(items: 
    // List<T>.from(docs.map((e) => e.data()))
    items,

    );
  }
}