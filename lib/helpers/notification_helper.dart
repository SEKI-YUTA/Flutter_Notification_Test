import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotifyHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void initNotification() async {
    flutterLocalNotificationsPlugin.initialize(
        InitializationSettings(
          android: AndroidInitializationSettings("icon2"),
        ),
        onSelectNotification: onNotificationSelected);
  }

  pushNotifi(String title, String body) {
    return flutterLocalNotificationsPlugin.show(
        0,
        title,
        body,
        NotificationDetails(
            android: AndroidNotificationDetails("channel_id", "channel_name",
                importance: Importance.high, priority: Priority.high)));
  }

  scheduleNotifi(String title, String body, int? duration) {
    return flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        title,
        body,
        tz.TZDateTime.now(tz.UTC).add(Duration(seconds: duration ?? 3)),
        NotificationDetails(
            android: AndroidNotificationDetails("channel_id", "channel_name",
                importance: Importance.high, priority: Priority.high)),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }

  void onNotificationSelected(String? payload) async {
    print("notification selected!");
  }
}
