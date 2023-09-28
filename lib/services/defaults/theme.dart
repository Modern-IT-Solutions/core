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
  ThemeService({
    super.id = 'DEFAULT',
    ThemeData? defaultTheme,
  }) : _themeData = defaultTheme ?? ThemeData();

  late SharedPreferences prefs;

  @override
  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    // SystemUiOverlayStyle

    super.init();
    log.info('App~Service: Theme initialized');
  }

  late ThemeData _themeData;
  ThemeData get themeData => _themeData;

  // mode
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  void setThemeData(ThemeData themeData)  {
    _themeData = themeData;
    notifyListeners();
  }

  void setThemeMode(ThemeMode themeMode)  {
    _themeMode = themeMode;
    notifyListeners();
  }

  void setColorScheme(ColorScheme colorScheme)  {
    _themeData = _themeData.copyWith(
      colorScheme: colorScheme,
      primaryColor: colorScheme.primary,
      scaffoldBackgroundColor: colorScheme.primaryContainer,
      brightness: colorScheme.brightness,
      appBarTheme: _themeData.appBarTheme.copyWith(
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.primary,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
        ),
      ),
      bottomNavigationBarTheme: _themeData.bottomNavigationBarTheme.copyWith(
        backgroundColor: colorScheme.primaryContainer,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.primary.withOpacity(0.5),
      ),
      tabBarTheme: _themeData.tabBarTheme.copyWith(
        labelColor: colorScheme.primary,
        unselectedLabelColor: colorScheme.primary.withOpacity(0.5),
      ),
      textTheme: GoogleFonts.notoKufiArabicTextTheme().copyWith(
        headline1: GoogleFonts.notoKufiArabic(
          color: colorScheme.primary,
          fontSize: 96,
          fontWeight: FontWeight.w300,
          letterSpacing: -1.5,
        ),
        headline2: GoogleFonts.notoKufiArabic(
          color: colorScheme.primary,
          fontSize: 60,
          fontWeight: FontWeight.w300,
          letterSpacing: -0.5,
        ),
        headline3: GoogleFonts.notoKufiArabic(
          color: colorScheme.primary,
          fontSize: 48,
          fontWeight: FontWeight.w400,
        ),
        headline4: GoogleFonts.notoKufiArabic(
          color: colorScheme.primary,
          fontSize: 34,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
        ),
        headline5: GoogleFonts.notoKufiArabic(
          color: colorScheme.primary,
          fontSize: 24,
          fontWeight: FontWeight.w400,
        ),
        headline6: GoogleFonts.notoKufiArabic(
          color: colorScheme.primary,
          fontSize: 20,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
        ),
        subtitle1: GoogleFonts.notoKufiArabic(
          color: colorScheme.primary,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.15,
        ),
        subtitle2: GoogleFonts.notoKufiArabic(
          color: colorScheme.primary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
        ),
        bodyText1: GoogleFonts.notoKufiArabic(
          color: colorScheme.primary,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
        ),
        bodyText2: GoogleFonts.notoKufiArabic(
          color: colorScheme.primary,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
        ),
        button: GoogleFonts.notoKufiArabic(
          color: colorScheme.primary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25,
        ),
        caption: GoogleFonts.notoKufiArabic(
          color: colorScheme.primary,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
        ),
        overline: GoogleFonts.notoKufiArabic(
          color: colorScheme.primary,
          fontSize: 10,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.5,
        ),
      ),

    );
    notifyListeners();
  }

  Future<void> setColorSchemeFromImage(ImageProvider image) async {
    final colorSchema = await ColorScheme.fromImageProvider(provider: image);
     setColorScheme(colorSchema);
  }

  void setColorSchemeColor(Color color) {
    final colorSchema = ColorScheme.fromSeed(seedColor: color);
     setColorScheme(colorSchema);
  }

}
