
// extension QuerySnapshot toListResult<T extends Model>(QuerySnapshot snapshot) {
import 'package:core/core.dart';

extension QuerySnapshotToListResult<T extends Model> on QuerySnapshot<T> {
  ListResult<T> toListResult() {
    return ListResult<T>(items: List<T>.from(docs.map((e) => e.data())));
  }
}