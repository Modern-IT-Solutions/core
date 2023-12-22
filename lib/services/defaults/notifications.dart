import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:universal_io/io.dart';

import '../consts/consts.dart';
import 'service.dart';

/// [NotificationServiceConfigs] responsible for notification configs
class NotificationServiceConfigs extends ServiceConfigs {
  /// android icon
  final String icon;

  const NotificationServiceConfigs({
    this.icon = 'ic_launcher_foreground',
  });
}

/// [NotificationService] responsible for notifications
class NotificationService extends Service {
  final _plugin = FlutterLocalNotificationsPlugin();
  FlutterLocalNotificationsPlugin get plugin => _plugin;

  // stream controller
  final StreamController<NotificationResponse> _onDidReceiveNotificationResponseStreamController = StreamController.broadcast();
  // stream for receiving notifications
  Stream<NotificationResponse> get onDidReceiveNotificationResponseStream => _onDidReceiveNotificationResponseStreamController.stream;

  // [notificationAppLaunchDetails]
  NotificationAppLaunchDetails? appLaunchDetails;

  // for checking if notification is enabled on android
  bool? isAndroidPermissionGranted;

  NotificationResponse? notificationResponse;
  ReceivedNotification? receivedNotification;

  @pragma('vm:entry-point')
  static void notificationTapBackground(NotificationResponse notificationResponse) {
    // ignore: avoid_print
    print('notification(${notificationResponse.id}) action tapped: '
        '${notificationResponse.actionId} with'
        ' payload: ${notificationResponse.payload}');
    if (notificationResponse.input?.isNotEmpty ?? false) {
      // ignore: avoid_print
      print('notification action tapped with input: ${notificationResponse.input}');
    }
  }

  final NotificationServiceConfigs configs;

  NotificationService({
    super.id = 'DEFAULT',
    this.configs = const NotificationServiceConfigs(),
  });

  @override
  Future<void> init() async {
    await _initLocalNotifications();
    if (Platform.isAndroid) await _checkAndroidPermission();
    await _requestPermission();
    await _initMessaging();
    await _initLunchDetails();
    super.init();
    log.info('App~Service: Notification initialized');
  }

  /// init lunch details
  Future<void> _initLunchDetails() async {
    appLaunchDetails = await _plugin.getNotificationAppLaunchDetails();
    if (appLaunchDetails?.didNotificationLaunchApp ?? false) {
      notificationResponse = appLaunchDetails!.notificationResponse;
      notifyListeners();
      log.info('App~Service: received notification on launch: ${notificationResponse!.payload}');
    }
  }

  Future<void> _checkAndroidPermission() async {
    isAndroidPermissionGranted = await _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.areNotificationsEnabled() ?? false;
    notifyListeners();
  }

  /// init local notifications
  /// https://pub.dev/packages/flutter_local_notifications
  Future<void> _initLocalNotifications() async {
    final NotificationAppLaunchDetails? notificationAppLaunchDetails = !kIsWeb && Platform.isLinux ? null : await _plugin.getNotificationAppLaunchDetails();
    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      notificationResponse = notificationAppLaunchDetails!.notificationResponse;
      notifyListeners();
      log.info('App~Service: received notification on launch: ${notificationResponse!.payload}');
    }
    // platforms initialization settings
    late AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings(
      (configs).icon,

    );
    final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {
        receivedNotification = ReceivedNotification(
          id: id,
          title: title,
          body: body,
          payload: payload,
        );
        notifyListeners();
        log.info('App~Service: received notification: $payload');
      },
    );

    /// for linux
    // final LinuxInitializationSettings initializationSettingsLinux = LinuxInitializationSettings(
    //   defaultActionName: 'Open notification',
    //   defaultIcon: AssetsLinuxIcon('icons/app_icon.png'),
    // );

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
      // linux: initializationSettingsLinux,
    );
    await _plugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) {
        notificationResponse = notificationResponse;
        notifyListeners();
        _onDidReceiveNotificationResponseStreamController.add(notificationResponse);
        log.info('App~Service: received notification: ${notificationResponse.payload}');
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
    log.info('App~Service: Local notifications initialized');
  }

  /// init messaging
  /// https://firebase.flutter.dev/docs/messaging/usage
  Future<void> _initMessaging() async {
    log.info('App~Service: Messaging initialized TODO:');
  }

  /// request permission
  Future<void> _requestPermission() async {
    if (Platform.isAndroid) await _requestAndroidPermission();
    if (Platform.isIOS || Platform.isMacOS) await _requestApplePermission();
    log.info('App~Service: Messaging permission requested');
  }

  bool? get applePermissionGranted => iOSPermissionGranted == true || macOSPermissionGranted == true;
  bool? iOSPermissionGranted;
  bool? macOSPermissionGranted;

  /// request apple permission
  Future<void> _requestApplePermission() async {
    iOSPermissionGranted = await _plugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(alert: true, badge: true, sound: true) ?? false;
    macOSPermissionGranted = await _plugin.resolvePlatformSpecificImplementation<MacOSFlutterLocalNotificationsPlugin>()?.requestPermissions(alert: true, badge: true, sound: true) ?? false;
    notifyListeners();
    log.info('App~Service: Apple Notifications permission requested');
  }

  bool? androidPermissionGranted;
  bool? androidExactAlarmsPermissionGranted;

  /// request android permission
  Future<void> _requestAndroidPermission() async {
    androidPermissionGranted = await _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission() ?? false;
    androidExactAlarmsPermissionGranted = await _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestExactAlarmsPermission() ?? false;
    notifyListeners();
    log.info('App~Service: Android Notifications permission requested');
  }

  /// show notification
  Future<void> show({
    int? id,
    required String? title,
    String? body,
    NotificationDetails? details,
    String? payload,
  }) {
    return _plugin.show(
      id ?? UniqueKey().hashCode,
      title,
      body,
      details ??
          NotificationDetails(
              android: AndroidNotificationDetails(
            "DEFAULT",
            'DEFAULT_CHANNEL',
            color: Colors.purple,
            category: AndroidNotificationCategory.status,
            autoCancel: true,
            channelShowBadge: true,
            colorized: true,
            importance: Importance.low,
            icon: (configs).icon,
            actions: [
              AndroidNotificationAction(
                'DEFAULT_ACTION',
                'حسنا',
              ),
            ],
          )),
      payload: payload,
    );
  }
}

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}
