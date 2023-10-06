
/// ModelRefMixin
class ModelRef {
  final String path;
  ModelRef(
    this.path,
  );

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
