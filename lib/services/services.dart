import 'dart:async';
import 'consts/consts.dart';
import 'defaults/service.dart';

/// [AuthServices] responsible for initializing all services and app lifecycle
export './defaults/auth.dart';
/// [FirebaseService] responsible for initializing all services and app lifecycle
export 'defaults/firebase/firebase.dart';
/// [NotificationsService] responsible for initializing all services and app lifecycle
export './defaults/notifications.dart';
/// [StorageService] responsible for initializing all services and app lifecycle
export './defaults/storage.dart';
/// [PreferencesService] responsible for initializing all services and app lifecycle
export './defaults/preferences.dart';
/// [SettingsService] responsible for initializing all services and app lifecycle
export './defaults/settings/settings.dart';
/// [ThemeService] responsible for initializing all services and app lifecycle
export './defaults/theme.dart';

// more
export './consts/consts.dart';

/// [Services] responsible for initializing all services and app lifecycle
class Services {
  final Set<Service> _services =  {};
   Services._();
  static final instance = Services._();

  /// stream controller for SevicesEvent
  final _eventController = StreamController<SevicesEvent>.broadcast();

  /// steam for SevicesEvent
  Stream<T> onEvent<T extends SevicesEvent>() {
    return _eventController.stream.where((event) => event is T).cast<T>();
  }


  /// stream controller for init on every service
  final _initController = StreamController<Service>.broadcast();

  /// steam for init on every service
  Stream<Service> get onInit => _initController.stream;


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
        _initController.add(service);
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
      service?.dispose();
      log.info('Service ${service.runtimeType} disposed');
    }
    _initController.close();

    log.info('All services disposed');
  }

  T? get<T extends Service>([String? id]) {
    var list = _services.whereType<T>();
    if (id != null) {
      list = list.where((s) => s.id == id);
    }
    return list.firstOrNull;
  }
}

abstract class SevicesEvent {}


/// [ServicesInitEvent] fired when init any service
class ServicesInitEvent extends SevicesEvent {
  final Service service;
  ServicesInitEvent(this.service);
}

/// [ServicesDisposeEvent] fired when dispose any service
class ServicesDisposeEvent extends SevicesEvent {
  final Service service;
  ServicesDisposeEvent(this.service);
}

/// [ServicesRegisterEvent] fired when register any service
class ServicesRegisterEvent extends SevicesEvent {
  final Service service;
  ServicesRegisterEvent(this.service);
}

/// [ServicesRegisterAllEvent] fired when register all services
class ServicesRegisterAllEvent extends SevicesEvent {
  final List<Service> services;
  ServicesRegisterAllEvent(this.services);
}

/// [ServicesInitAllEvent] fired when init all services
class ServicesInitAllEvent extends SevicesEvent {
  final List<Service> services;
  ServicesInitAllEvent(this.services);
}
