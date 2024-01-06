import 'dart:async';
import 'dart:collection';

import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:universal_io/io.dart';

import '../../consts/consts.dart';
import '../service.dart';
import 'default_settings_loader_model.dart';

/// [SettingsServiceConfigs] responsible for settings configs
class SettingsServiceConfigs<L extends SettingsLoaderModel> extends ServiceConfigs {
  /// [path] settings document path
  /// the settings document contains all the settings for the app
  /// it is stored in firestore/or any other database acceppted by the app
  final String path;

  /// [loader] is [SettingsLoaderModel.fromJson] function
  // final L Function(Map<String, dynamic>)? loader;
  /// [expireAfter] settings expire after this duration
  final Duration expireAfter;
  const SettingsServiceConfigs({
    this.path = 'settings/DEFAULT',
    // this.loader,
    this.expireAfter = const Duration(days: 1),
  });
}

/// [SettingsService] responsible for settings service and all related
class SettingsService<L extends SettingsLoaderModel> extends Service {
  /// [configs] settings configs
  final SettingsServiceConfigs<L> configs;

  /// [settings] settings data
  Map<String, dynamic> _settings = {};
  UnmodifiableMapView<String, dynamic> get settings => UnmodifiableMapView(_settings);

  /// [options]
  UnmodifiableMapView<String, dynamic> get options => UnmodifiableMapView(_settings["options"] ?? {});

  /// [lastFetch] last fetch time
  DateTime? _lastFetch;
  DateTime? get lastFetch => _lastFetch;

  SettingsService({
    super.id = 'DEFAULT',
    this.configs = const SettingsServiceConfigs() 
  });

  @override
  Future<void> init() async {
    await _loadCachedSettings();
    await _loadServerSettings();
    super.init();
    log.info('App~Service: Settings initialized');
  }

  /// Loads the settings from the local storage
  Future<void> _loadCachedSettings() async {
    var prefs = getPrefs();
    var settings = prefs.getOption<Map<String, dynamic>>(configs.path);
    if (settings != null) {
      _settings = settings;
      notifyListeners();
    }
  }

  /// Loads the settings from the server
  Future<void> _loadServerSettings() async {
    var settings = await getDocument(path: configs.path);
    if (settings != null) {
      _settings = settings.data;
      notifyListeners();
    }
  }

  /// Saves the settings to the local storage
  Future<void> _setSettings() async {
    await setDocument(
      path: configs.path,
      data: _settings,
      merge: true,
    );
  }

  /// [setOption] sets a setting option
  Future<void> setOption<T>(String key, T value) async {
    _settings["options"] ??= {};
    _settings["options"][key] = value;
    notifyListeners();
    await _setSettings();
  }

  /// getOption
  FutureOr<T?> getOption<T>(String key) async {
    return settings["options"]?[key] as T?;
  }


}
