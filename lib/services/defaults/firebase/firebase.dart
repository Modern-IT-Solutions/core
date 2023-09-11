import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_apple/firebase_ui_oauth_apple.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/foundation.dart';
import 'package:universal_io/io.dart';
import '../../consts/consts.dart';
import '../../../imports/firebase.dart' as fb;
import '../service.dart';

/// [FirebaseService] responsible for firebase services
class FirebaseService extends Service {
  /// nul = auto
  final bool? webRecaptureEnabled;
  final String? webRecaptureSiteKey;

  final bool useFunctionsEmulator;
  final bool useFirestoreEmulator;
  final bool useAuthEmulator;
  final bool useStorageEmulator;
  final bool useDatabaseEmulator;

  final String functionsEmulatorHost;
  final int functionsEmulatorPort;
  final String firestoreEmulatorHost;
  final int firestoreEmulatorPort;
  final String authEmulatorHost;
  final int authEmulatorPort;
  final String storageEmulatorHost;
  final int storageEmulatorPort;
  final String databaseEmulatorHost;
  final int databaseEmulatorPort;

  final fb.ActionCodeSettings? actionCodeSettings;

  final String? googleClientIdAndroid;
  final String? googleClientIdIOS;
  final String? googleClientIdWeb;

  final fb.FirebaseOptions options;

  FirebaseService({
    super.id = 'DEFAULT',
    /// required
    this.webRecaptureSiteKey,
    this.actionCodeSettings,
    this.googleClientIdAndroid,
    this.googleClientIdIOS,
    this.googleClientIdWeb,
    required this.options,

    /// optional
    this.webRecaptureEnabled,
    this.useFunctionsEmulator = false,
    this.useFirestoreEmulator = false,
    this.useAuthEmulator = false,
    this.useStorageEmulator = false,
    this.useDatabaseEmulator = false,
    this.functionsEmulatorHost = 'localhost',
    this.functionsEmulatorPort = 5001,
    this.firestoreEmulatorHost = 'localhost',
    this.firestoreEmulatorPort = 8080,
    this.authEmulatorHost = 'localhost',
    this.authEmulatorPort = 9099,
    this.storageEmulatorHost = 'localhost',
    this.storageEmulatorPort = 9199,
    this.databaseEmulatorHost = 'localhost',
    this.databaseEmulatorPort = 9000,
  });

  @override
  Future<void> init() async {
    await fb.Firebase.initializeApp(options: options);

    await _initEmulator();
    await _initAppCheck();
    await _initAuth();
    await _initCrashlytics();
    await _initAnalytics();

    super.init();
    log.info('App~Service: Firebase initialized');
  }

  /// Emulator initialization
  /// config to connect to local emulators
  Future<void> _initEmulator() async {
    if (kDebugMode) {
      try {
        if (useFunctionsEmulator) {
          log.info('useFunctionsEmulator = true');
          fb.FirebaseFunctions.instance.useFunctionsEmulator(functionsEmulatorHost, functionsEmulatorPort);
        }
        if (useFirestoreEmulator) {
          log.info('useFirestoreEmulator = true');
          fb.FirebaseFirestore.instance.useFirestoreEmulator(firestoreEmulatorHost, firestoreEmulatorPort);
        }
        if (useAuthEmulator) {
          log.info('useAuthEmulator = true');
          await fb.FirebaseAuth.instance.useAuthEmulator(authEmulatorHost, authEmulatorPort);
        }
      } catch (e) {
        // ignore: avoid_print
        print(e);
      }
    }

    log.info('Emulator initialized');
  }

  /// App Check initialization
  /// App check responsible for protecting your backend resources from abuse, such as billing fraud or phishing.
  /// https://firebase.flutter.dev/docs/app-check/usage
  Future<void> _initAppCheck() async {
    if (webRecaptureSiteKey != null) {
      await fb.FirebaseAppCheck.instance.activate(webRecaptchaSiteKey: webRecaptureSiteKey);
      log.info('App~Service: App check initialized');
    } else {
      log.info('App~Service: App check not initialized');
    }
  }

  String? get _getCliendId {
    if (kIsWeb && googleClientIdWeb != null) {
      return googleClientIdWeb;
    } else if (Platform.isAndroid && googleClientIdAndroid != null) {
      return googleClientIdAndroid;
    } else if (Platform.isIOS && googleClientIdIOS != null) {
      return googleClientIdIOS;
    }
    return null;
  }

  /// Auth initialization
  /// in this section we will initialize providers like google, facebook, email, phone...
  /// https://firebase.flutter.dev/docs/auth/usage
  Future<void> _initAuth() async {
    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
      if (_getCliendId != null)
      GoogleProvider(
        clientId: _getCliendId!,
        redirectUri: actionCodeSettings?.url,
      ),
      AppleProvider(),
    ]);
    log.info('App~Service: Auth initialized');
  }

  /// Crashlytics initialization
  /// Crashlytics is a crash reporter that helps you track, prioritize, and fix stability issues that erode your app quality.
  /// https://firebase.flutter.dev/docs/crashlytics/usage
  Future<void> _initCrashlytics() async {
    // enable automatic data collection
    if (!kIsWeb) {
      if (kDebugMode) {
        await fb.FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
      } else {
        await fb.FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
      }
    }
    // report fatal flutter errors
    FlutterError.onError = fb.FirebaseCrashlytics.instance.recordFlutterError;
    log.info('App~Service: Crashlytics initialized');
  }

  /// Analytics initialization
  /// Analytics is a free app measurement solution that provides insight on app usage and user engagement.
  /// https://firebase.flutter.dev/docs/analytics/usage
  Future<void> _initAnalytics() async {
    await fb.FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
    log.info('App~Service: Analytics initialized');
  }
}
