import 'dart:async';

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
    log.info('App~Service: Auth disposed');
  }

  /// auth state changes
  /// listen to auth state changes
  /// if the user is logged in, get the user profile
  Future<void> _initAuthStateChanges() async {
    _authStateChangesSubscription = fb.FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        // TODO: uncomment this line
        // _profileService.getProfile(user.uid);
      } else {
        // await logout();
      }
    });

    log.info('App: Auth state changes initialized');
  }
}
