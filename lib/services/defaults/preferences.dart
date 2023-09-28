import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:core/services/consts/consts.dart';
// ignore: depend_on_referenced_packages

import '../services.dart';
import 'firebase/database.dart';
import 'helpers.dart';
import 'service.dart';



/// [PreferencesService] responsible for preferences of the app content and users
class PreferencesService extends Service {
  late DatabaseService database;

  PreferencesService({
    super.id = 'DEFAULT',
  });
  @override
  Future<void> init() async {
    assert(!initialized, 'PreferencesService already initialized');
    database = Services.instance.get<DatabaseService>()!;
    _listenServerPreferences();
    super.init();
    log.info('App~Service: Preferences initialized');
  }

  @override
  void dispose() {
    _preferencesSubscription?.cancel();
    super.dispose();
    log.info('App~Service: Preferences disposed');
  }


  StreamSubscription<Map<String, Map<String, dynamic>>>? _preferencesSubscription;
  Map<String,Map<String, dynamic>> _preferences = {};
  Map<String,Map<String, dynamic>> get preferences => _preferences;
  Map<String, dynamic>? get options {
    try {
      return preferences['options'];
    } catch (e) {
      return null;
    }
  }
  /// Loads the server preferences from the local storage
  void _listenServerPreferences() {
    /// data in this app stored in firestore
    /// preferences stored in path: /preferences
    /// it contains documents, each document is a preference for a specific feature
    _preferencesSubscription = database.getPreferencesStream().listen((event) {
      _preferences = event;
      notifyListeners();
    });
  }


  T? getOption<T>(String key, {T? defaults}) {
    T? value;
    try {
      var item = getCurrentProfile()?.customClaims["preferences"]?[key] ?? options?[key] ?? preferences[key];
      if (item != null) {
        value = item['value'] as T?;
      }
    } catch (e) {}
    if (value == null) {
      return defaults;
    }
    if (value is Duration) {
      return Duration(milliseconds: int.parse(value.toString())) as T;
    }
    if (value is T) {
      return value;
    }
      print("PreferencesService.get<$T>($key) => $value");
    return null;
  }
}

