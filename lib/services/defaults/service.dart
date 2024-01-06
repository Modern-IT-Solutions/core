
import 'package:flutter/widgets.dart';

/// [Service] abstract class for services
abstract class Service extends ChangeNotifier {
  bool _initialized = false;
  bool get initialized => _initialized;
  // id
  final String id;
  Service({required this.id});
  // ignore: unused_element
  // must call super
  @mustCallSuper
  Future<void> init() async {
    assert(!_initialized, 'Service already initialized');
    _initialized = true;
  }

  /// override == operator to compare services by id
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Service && other.id == id && other.runtimeType == runtimeType;
  }

  /// override hashCode to compare services by id
  @override
  int get hashCode => id.hashCode ^ runtimeType.hashCode;
}


/// [ServiceConfigs] abstract class for services configs
abstract class ServiceConfigs {
  const ServiceConfigs();
}