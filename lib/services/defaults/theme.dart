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

/// [ThemeService] responsible for database of the app content and users
class ThemeService extends Service {
  /// [mode]
  final Color colorSeed;
  ThemeService({
    super.id = 'DEFAULT',
    ThemeMode themeMode = ThemeMode.system,
    this.colorSeed = Colors.yellow,
    ThemeData? defaultTheme,
    ThemeData? defaultDarkTheme,
  })  : _themeMode = themeMode,
        _themeData = defaultTheme ??
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
    prefs = await SharedPreferences.getInstance();
    // SystemUiOverlayStyle

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

  void setThemeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void setDarkThemeData(ThemeData themeData) {
    _darkThemeData = themeData;
    notifyListeners();
  }

  void setThemeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }

  void setColorScheme(ColorScheme colorScheme) {
    _themeData = _themeData.copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: colorScheme.primary,
        brightness: Brightness.light,
      )
    );
    _darkThemeData = _darkThemeData.copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: colorScheme.primary,
        brightness: Brightness.dark,
      )
    );
    notifyListeners();
  }

  Future<void> setColorSchemeFromImage(ImageProvider image) async {
    final colorSchema = await ColorScheme.fromImageProvider(provider: image);
    setColorScheme(colorSchema);
  }

  void setColorSeed(Color color) {
    final colorSchema = ColorScheme.fromSeed(seedColor: color);
    setColorScheme(colorSchema);
  }
}
