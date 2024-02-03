
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


/// [endOfDay] and [startOfDay] are used to get the start and end of the day
extension DateTimeStartEndOfDay on DateTime {
  DateTime get startOfDay {
    return DateTime(year, month, day);
  }

  DateTime get endOfDay {
    return DateTime(year, month, day, 23, 59, 59, 999, 999);
  }
}