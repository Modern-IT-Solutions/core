import 'dart:async';
import 'consts/consts.dart';
import 'defaults/service.dart';
export './defaults/auth.dart';
export 'defaults/firebase/firebase.dart';
export './defaults/notifications.dart';
export './defaults/storage.dart';

/// [Services] responsible for initializing all services and app lifecycle
class Services {
  final Set<Service> _services =  {};
   Services._();
  static final instance = Services._();


  /// register a new service
  void register(Service service) {
    _services.add(service);
  }

  /// register all
  void registerAll(Set<Service> services) {
    for (var service in services) {
      register(service);
    }
  }

  /// init all services
  Future<void> init() async {
    for (final service in _services) {
      if (!service.initialized) {
        await service.init();
        log.info('Service ${service.runtimeType} initialized');
      } else {
        log.info('Service ${service.runtimeType} already initialized!');
      }
    }
    log.info('All services initialized');
  }

  /// dispose all services
  void dispose() {
    for (final service in _services) {
      service.dispose();
      log.info('Service ${service.runtimeType} disposed');
    }
    log.info('All services disposed');
  }

  T get<T extends Service>([String? id]) {
    var list = _services.whereType<T>();
    if (id != null) {
      list = list.where((s) => s.id == id);
    }
    return list.first;
  }
}

// abstract class AppBase {
//   Services get services;
//   Future<void> init() async {
//     await services.init();
//     log.info('App initialized');
//   }

//   void dispose() {
//     services.dispose();
//     log.info('All services disposed');
//   }
// }
