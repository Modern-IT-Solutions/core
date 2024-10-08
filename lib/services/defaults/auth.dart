import 'dart:async';

import 'package:core/core.dart';
import 'package:core/features/users/data/models/role.dart';
import 'package:lib/lib.dart';

import '../consts/consts.dart';
import '../../imports/firebase.dart' as fb;
import 'service.dart';

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
      notifyListeners();
    });
  }

  /// auth state changes
  /// listen to auth state changes
  /// if the user is logged in, get the user profile
  Future<void> _initAuthStateChanges() async {
    _authStateChangesSubscription = fb.FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        log.info('App: Auth state changes: user logged in');
        _listenToCurrentProfile();
        notifyListeners();
      } else {
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
}
