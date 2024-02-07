import 'dart:async';

import 'package:core/core.dart';
import 'package:core/features/users/data/models/profile_session.dart';
import 'package:lib/lib.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../imports/firebase.dart' as fb;

/// [AuthServiceConfigs] responsible for auth service configs
class AuthServiceConfigs extends ServiceConfigs {
  const AuthServiceConfigs();
}

/// [AuthService]
class AuthService extends Service {
  /// auth state changes subscription
  StreamSubscription<fb.User?>? _authStateChangesSubscription;

  final AuthServiceConfigs configs;

  AuthService({
    super.id = 'DEFAULT',
    this.configs = const AuthServiceConfigs(),
  });

  @override
  Future<void> init() async {
    await _initAuthStateChanges();

    super.init();
    log.info('App~Service: Auth initialized');
  }

  @override
  void dispose() {
    super.dispose();
    _authStateChangesSubscription?.cancel();
    _currentProfileStreamSubscription?.cancel();
    log.info('App~Service: Auth disposed');
  }

  /// currentProfile
  /// get the current profile
  ProfileModel? get currentProfile => _currentProfile;
  ProfileModel? _currentProfile;

  /// currentProfileStream
  StreamSubscription<FutureOr<ProfileModel?>>? _currentProfileStreamSubscription;

  /// listen to current profile
  Future<void> _listenToCurrentProfile() async {
    _currentProfileStreamSubscription?.cancel();
    _currentProfileStreamSubscription = null;
    _currentProfile = null;
    notifyListeners();

    _currentProfileStreamSubscription = FirebaseFirestore.instance.collection('profiles').doc(fb.FirebaseAuth.instance.currentUser!.uid).snapshots().map((doc) async {
      if (!doc.exists && fb.FirebaseAuth.instance.currentUser != null && (Platforms.isAndroid || Platforms.isIOS || Platforms.isMacOS)) {
        // create a new profile using the current user
        final profile = ProfileModel(
          ref: ModelRef("profiles/${fb.FirebaseAuth.instance.currentUser!.uid}"),
          displayName: fb.FirebaseAuth.instance.currentUser!.displayName ?? '',
          email: fb.FirebaseAuth.instance.currentUser!.email ?? '',
          phoneNumber: fb.FirebaseAuth.instance.currentUser!.phoneNumber ?? '',
          birthday: null,
          photoUrl: fb.FirebaseAuth.instance.currentUser!.photoURL ?? '',
          address: null,
          uid: fb.FirebaseAuth.instance.currentUser!.uid,
          disabled: false,
          roles: [],
          emailVerified: fb.FirebaseAuth.instance.currentUser!.emailVerified,
          metadata: {},
          customClaims: {},
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          deletedAt: null,
          lastSignInAt: null,
        );
        await FirebaseFirestore.instance.collection('profiles').doc(fb.FirebaseAuth.instance.currentUser!.uid).set({
          ...profile.toJson(),
          "_fromLocal": true,
        });
        return null;
      }
      return ProfileModel.fromJson(doc.data()!);
    }).listen((profile) async {
      _currentProfile = await profile;
      if (_currentProfile != null) {
        await handleSession();
      }
      notifyListeners();
    });
  }

  /// auth state changes
  /// listen to auth state changes
  /// if the user is logged in, get the user profile
  Future<void> _initAuthStateChanges() async {
    _authStateChangesSubscription = fb.FirebaseAuth.instance.authStateChanges().listen((user) async {
      if (user != null) {
        log.info('App: Auth state changes: user logged in');
        await _listenToCurrentProfile();
        notifyListeners();
      } else {
        await clearDeviceId();
        log.info('App: Auth state changes: user logged out');
        _currentProfileStreamSubscription?.cancel();
        _currentProfileStreamSubscription = null;
        _currentProfile = null;
        notifyListeners();
      }
    });

    log.info('App: Auth state changes initialized');
  }

  /// signout
  Future<void> signout() async {
    await fb.FirebaseAuth.instance.signOut();
    log.info('App: Auth signout');
  }

  // generate device id and save it to shared preferences (Random 20 characters string)
  Future<String> _generateDeviceId() async {
    final prefs = await SharedPreferences.getInstance();
    final deviceId = generateDocumentId(20);
    await prefs.setString('deviceId', deviceId);
    return deviceId;
  }

  /// getDeviceId
  Future<String> getDeviceId() async {
    // await clearDeviceId();
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('deviceId') ?? await _generateDeviceId();
  }

  /// clearDeviceId
  Future<void> clearDeviceId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('deviceId');
  }

  /// handle session
  /// this by add the current device id to the metadata.sessions with its timestamp
  /// if the id already exists, do nothing
  Future<void> handleSession() async {
    final deviceId = await getDeviceId();
    final profile = currentProfile!;
    if (profile == null) {
      return;
    }
    // check if the device id already exists
    final sessions = profile.sessions;
    if (sessions[deviceId] != null) {
      // check if the session is valid
      if (!sessions[deviceId]!.valid) {
        await signout();
      }
      return;
    }
    ProfileSession session = ProfileSession(
      token: deviceId,
      createdAt: DateTime.now(),
      valid: true,
    );
    // add the session to the profile
    await updateDocument(
      path: profile.ref.path,
      data: {
        "sessions.$deviceId": {
          ...session.toJson(),
          "createdAt": FieldValue.serverTimestamp(),
        },
      },
    );
  }




  /// handle session
  /// this by add the current device id to the metadata.sessions with its timestamp
  /// if the id already exists, do nothing
  // Future<void> handleSession() async {
  //   final deviceId = await getDeviceId();
  //   final profile = currentProfile!;
  //   if (profile == null) {
  //     return;
  //   }
  //   // check if the device id already exists
  //   final sessions = profile.sessions;
  //   if (sessions[deviceId] != null) {
  //     // check if the session is valid
  //     if (!sessions[deviceId]!.valid) {
  //       await signout();
  //     }
  //     return;
  //   }
  //   int maxSessionsPerUser = getPrefs().maxSessionsPerUser;
  //   List<String> needLogout = [];
  //   if (maxSessionsPerUser > 0) {
  //     // keep the last maxSessionsPerUser sessions (must be also valid)
  //     var validSessions = sessions.values.where((s) => s.valid).toList();
  //     List<String> sortedSessions = sessions.values.toList()
  //       ..sort((a, b) => a!.createdAt.compareTo(b!.createdAt));
  //     // if the number of valid sessions is more than maxSessionsPerUser
  //     if (validSessions.length > maxSessionsPerUser) {
  //       // get the sessions that need to be logged out
  //       needLogout = sortedSessions.sublist(0, validSessions.length - maxSessionsPerUser).map((s) => s.token).toList();
  //     }
  //   }
  //   ProfileSession session = ProfileSession(
  //     token: deviceId,
  //     createdAt: DateTime.now(),
  //     valid: true,
  //   );
  //   // add the session to the profile
  //   await updateDocument(
  //     path: profile.ref.path,
  //     data: {
  //       "sessions.$deviceId": {
  //         ...session.toJson(),
  //         "createdAt": FieldValue.serverTimestamp(),
  //       },
  //       for (var token in needLogout) "sessions.$token.valid": false,
  //     },
  //   );
  // }
}
