import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:core/services/consts/consts.dart';
// ignore: depend_on_referenced_packages

import '../services.dart';
import 'firebase/database.dart';
import 'helpers.dart';
import 'service.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:cloud_firestore/cloud_firestore.dart';



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
    // print("PreferencesService.get<$T>($key) => $value");
    return null;
  }

  // Future<void> setOption<T>(String key, T value) async {
  //   // save to local storage
  //   _preferences[key] = {
  //     'value': value,
  //     'updatedAt': DateTime.now(),
  //   };
  // }

  Future<void> setOptions(Map<String, dynamic> options) async {
    await updateDocument(
      path: "preferences/options", data: options,
      setMetadate: false,
    );
  }

  Future<void> setEvents(Map<String, dynamic> events) async {
    await FirebaseFirestore.instance.collection("preferences").doc("events").set(events);
    // await setDocument(
    //   path: "preferences/events", data: events,
    //   setMetadate: false,
    // );
  }

  Future<void> setHomeSections(Map<String, dynamic> sections) async {
    await FirebaseFirestore.instance.collection("preferences").doc("homeSections").set(sections);
    // await updateDocument(
    //   path: "preferences/homeSections", data: {
    //     "sections": "sections",
    //   },
    //   setMetadate: false,
    // );
  }

  Future<void> setHomeAds(Map<String, dynamic> ads) async {
    await FirebaseFirestore.instance.collection("preferences").doc("homeAds").set(ads);
  }


  FormatDateShape formatDateShape = FormatDateShape.full;

  String? formatDate(DateTime? dateTime) {
    return switch(formatDateShape){
      FormatDateShape.full => dateTime?.formatFull(),
      FormatDateShape.onlyDate=> dateTime?.formatOnlyDate(),
      FormatDateShape.timeago=> dateTime?.formatTimeAgo()
    };
  }
}


enum FormatDateShape {
  full,
  onlyDate,
  timeago
}

// extension
extension FormatDate on DateTime {
  String formatFull() {
    return "$day/$month/$year $hour:$minute";
  }
  String formatOnlyDate() {
    return "$day/$month/$year";
  }
  String formatTimeAgo() {
    return timeago.format(this);
  }
}
