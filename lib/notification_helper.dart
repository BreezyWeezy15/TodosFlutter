

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {

  static late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  static void initializePlatformSpecifics() async {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = const DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: false,
    );
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }
  static void showNotification(String param1, String param2) async {
    var androidChannelSpecifics = const AndroidNotificationDetails(
      'id',
      'Todos',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      timeoutAfter: 5000,
      styleInformation: DefaultStyleInformation(true, true),
    );
    var iosChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidChannelSpecifics,
      iOS: iosChannelSpecifics,
    );
    await _flutterLocalNotificationsPlugin.show(
      100,
      param1,
      param2,
      platformChannelSpecifics,
      payload: 'New Payload',
    );
  }

}