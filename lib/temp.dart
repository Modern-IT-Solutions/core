import 'dart:math';

import 'package:core/services/defaults/helpers.dart';
import 'package:flutter/material.dart';

import 'models/base.dart';

/// ModelRefMixin
class ModelRef {
  /// random() is a static method that returns a random string of length [length]
  static ModelRef random(String col,[int length = 11]) {
    var r = Random();
    return ModelRef(col+"/"+generateDocumentId(length));
  }

  final String path;
  const ModelRef(
    this.path,
  );

  // empty
  static const empty = ModelRef('');

  String get id => path.split('/').lastOrNull ?? 'noid';
  String get collection {
    var tokens = path.split('/');
    // remove last token if exists
    if (tokens.lastOrNull == id) {
      tokens.removeLast();
    } else {
      return 'no_collection';
    }
    return tokens.join('/');
  }


  ModelRef copyWith({
    String? ref,
  }) {
    return ModelRef(
      ref ?? this.path,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'ref': path,
    };
  }

  factory ModelRef.fromJson(dynamic map) {
    return ModelRef(
      map.toString(),
    );
  }

  @override
  String toString() => '$path';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ModelRef &&
      other.path == path;
  }

  @override
  int get hashCode => path.hashCode;
}



////

//////

// delete assistance, a simple dialog with a text and two buttons
Future<void> showDeleteModelDailog(BuildContext context, Model model) async {
  bool _loading = false;
  bool skipRecycleBin = false;
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Confirm delete'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('this action cannot be undone, are you sure you want to continue?'),
          Padding(
            padding: const EdgeInsets.all(12),
            child: StatefulBuilder(builder: (context, setState) {
              return SwitchListTile(
                contentPadding: const EdgeInsets.only(left: 12),
                visualDensity: const VisualDensity(vertical: -3),
                title: const Text('Skip recycle bin'),
                value: skipRecycleBin,
                onChanged: (e) => setState(() {
                  skipRecycleBin = e;
                }),
              );
            }),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        StatefulBuilder(builder: (context, setState) {
          return TextButton(
            onPressed: _loading
                ? null
                : () async {
                    setState(() {
                      _loading = true;
                    });
                    try {
                      await deleteDocument(path: model.ref.path, softDelete: !skipRecycleBin);
                      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                        SnackBar(
                            behavior: SnackBarBehavior.floating,
                            width: 400.0,
                            content: Text('${model.ref.id} deleted'),
                            action: SnackBarAction(
                              label: 'Close',
                              onPressed: () {
                                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                              },
                            )),
                      );
                      Navigator.of(context).pop();
                    } catch (e) {}
                    setState(() {
                      _loading = false;
                    });
                  },
            child: _loading ? CircularProgressIndicator.adaptive() : const Text('Delete'),
          );
        }),
      ],
    ),
  );
}


// delete assistance, a simple dialog with a text and two buttons
Future<void> showDeleteModelsDailog(BuildContext context, List<Model> models) async {
  bool _loading = false;
  bool skipRecycleBin = false;
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Confirm delete ${models.length} items'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('this action cannot be undone, are you sure you want to continue?'),
          Padding(
            padding: const EdgeInsets.all(12),
            child: StatefulBuilder(builder: (context, setState) {
              return SwitchListTile(
                contentPadding: const EdgeInsets.only(left: 12),
                visualDensity: const VisualDensity(vertical: -3),
                title: const Text('Skip recycle bin'),
                value: skipRecycleBin,
                onChanged: (e) => setState(() {
                  skipRecycleBin = e;
                }),
              );
            }),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        StatefulBuilder(builder: (context, setState) {
          return TextButton(
            onPressed: _loading
                ? null
                : () async {
                    setState(() {
                      _loading = true;
                    });
                    try {
                      for (var model in models) {
                        await deleteDocument(path: model.ref.path, softDelete: !skipRecycleBin);
                      }
                      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                        SnackBar(
                            behavior: SnackBarBehavior.floating,
                            width: 400.0,
                            content: Text('${models.length} items deleted ${skipRecycleBin ? "permanently" : ""}'),
                            action: SnackBarAction(
                              label: 'Close',
                              onPressed: () {
                                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                              },
                            )),
                      );
                      Navigator.of(context).pop();
                    } catch (e) {}
                    setState(() {
                      _loading = false;
                    });
                  },
            child: _loading ? CircularProgressIndicator.adaptive() : const Text('Delete'),
          );
        }),
      ],
    ),
  );
}


// [A-Z][0-9]
const _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
String generateDocumentId([int length=11]) {
  var r = Random();
  var result = "";
  for (var i = 0; i < length; i++) {
    result += _chars[r.nextInt(_chars.length)];
  }
  return result;
}