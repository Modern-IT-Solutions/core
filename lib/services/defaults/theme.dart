import 'dart:async';
import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:core/services/consts/consts.dart';
// ignore: depend_on_referenced_packages
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show describeEnum, kIsWeb;

/// [ThemeService] responsible for database of the app content and users
class ThemeService extends Service {
  Key _themeKey = UniqueKey();

  Key get themeKey => _themeKey;

  @override
  void notifyListeners() {
    _themeKey = UniqueKey();
    super.notifyListeners();
  }

  /// [backgroundImage]
  ImageProvider? _backgroundImage;
  set backgroundImage(ImageProvider? value) {
    _backgroundImage = value;
    notifyListeners();
  }

  ImageProvider? get backgroundImage => _backgroundImage;

  /// [mode]
  Color colorSeed;

  /// [_blurEnabled]
  bool _blurEnabled;
  set blurEnabled(bool value) {
    _blurEnabled = value;
    notifyListeners();
  }

  bool get blurEnabled => _blurEnabled;

  /// [animationEnabled]
  bool _animationEnabled;
  set animationEnabled(bool value) {
    _animationEnabled = value;
    notifyListeners();
  }

  bool get animationEnabled => _animationEnabled;

  ThemeService({
    super.id = 'DEFAULT',
    ThemeMode themeMode = ThemeMode.system,
    this.colorSeed = Colors.orange,
    ThemeData? defaultTheme,
    ThemeData? defaultDarkTheme,
    bool blurEnabled = true,
    bool animationEnabled = true,
    ImageProvider? backgroundImage,
    // "https://images2.alphacoders.com/130/1305211.png"
    // "https://i.redd.it/jn2ear0ah9n91.jpg",
  })  : _animationEnabled = animationEnabled,
        _backgroundImage = backgroundImage,
        _themeMode = themeMode,
        _blurEnabled = blurEnabled,
        _themeData = defaultTheme ??
            ThemeData(
              badgeTheme: BadgeThemeData(backgroundColor: colorSeed, textColor: Colors.white),
              chipTheme: ChipThemeData(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              listTileTheme: const ListTileThemeData(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              textTheme: GoogleFonts.poppinsTextTheme(
                ThemeData().textTheme.apply(),
              ),
              colorScheme: ColorScheme.fromSeed(
                seedColor: colorSeed,
                brightness: Brightness.light,
              ),
              useMaterial3: true,
              tabBarTheme: const TabBarTheme(
                dividerColor: Colors.transparent,
              ),
              scaffoldBackgroundColor: Colors.transparent,
            ),
        _darkThemeData = defaultDarkTheme ??
            ThemeData(
              chipTheme: ChipThemeData(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              listTileTheme: const ListTileThemeData(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              textTheme: GoogleFonts.poppinsTextTheme(
                ThemeData().textTheme.apply(
                      bodyColor: Colors.white,
                      displayColor: Colors.white,
                    ),
              ),
              colorScheme: ColorScheme.fromSeed(
                seedColor: colorSeed,
                brightness: Brightness.dark,
              ),
              useMaterial3: true,
              tabBarTheme: const TabBarTheme(
                dividerColor: Colors.transparent,
              ),
              scaffoldBackgroundColor: Colors.transparent,
            );

  late SharedPreferences prefs;

  // _themeData.copyWith(
  //       colorScheme: _themeData.colorScheme.copyWith(
  //         brightness: Brightness.dark,
  //       ),
  //     );

  @override
  Future<void> init() async {
    // in web desible blurEnabled
    if (kIsWeb) {
      _blurEnabled = false;
    }
    prefs = await SharedPreferences.getInstance();
    await load();
    super.init();

    log.info('App~Service: Theme initialized');
  }

  late ThemeData _themeData;
  ThemeData get themeData => _themeData;

  late ThemeData _darkThemeData;
  ThemeData get darkThemeData => _darkThemeData;

  // mode
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  // save (shared preferences)
  Future<void> save() async {
    await prefs.setString('themeMode', _themeMode.name);
    await prefs.setString('colorSeed', colorSeed.value.toString());
  }

  // load (shared preferences)
  Future<void> load() async {
    final themeMode = prefs.getString('themeMode');
    if (themeMode != null) {
      _themeMode = ThemeMode.values.firstWhere((e) => e.name == themeMode);
    }
    final colorSeed = prefs.getString('colorSeed');
    if (colorSeed != null) {
      setColorSeed(Color(int.parse(colorSeed)));
    }
    notifyListeners();
  }

  void setThemeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
    save();
  }

  void setCurrentThemeData(ThemeData themeData) {
    if (_themeMode == ThemeMode.light) {
      _themeData = themeData;
    } else {
      _darkThemeData = themeData;
    }
    notifyListeners();
    save();
  }

  void setDarkThemeData(ThemeData themeData) {
    _darkThemeData = themeData;
    notifyListeners();
    save();
  }

  void setThemeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
    save();
  }

  void setColorScheme(ColorScheme colorScheme) {
    _themeData = _themeData.copyWith(
        colorScheme: ColorScheme.fromSeed(
      seedColor: colorScheme.primary,
      brightness: Brightness.light,
    ));
    _darkThemeData = _darkThemeData.copyWith(
        colorScheme: ColorScheme.fromSeed(
      seedColor: colorScheme.primary,
      brightness: Brightness.dark,
    ));
    notifyListeners();
    save();
  }

  Future<void> setColorSchemeFromImage(ImageProvider image) async {
    final colorSchema = await ColorScheme.fromImageProvider(provider: image);
    setColorScheme(colorSchema);
  }

  void setColorSeed(Color color) {
    final colorSchema = ColorScheme.fromSeed(seedColor: color);
    colorSeed = color;
    setColorScheme(colorSchema);
  }
}
