import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:my_notification/pages/second_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final FlutterLocalNotificationsPlugin flnp;
  @override
  void initState() {
    super.initState();
    flnp = FlutterLocalNotificationsPlugin();
    flnp.initialize(
        InitializationSettings(
          android: AndroidInitializationSettings("icon2"),
        ),
        onSelectNotification: onNotificationSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: pushNotifi,
              child: Text("Push Notification"),
            ),
            ElevatedButton(
                onPressed: scheduleNotifi, child: Text("schedule notification"))
          ],
        ),
      ),
    );
  }

  Future<void> pushNotifi() {
    return flnp.show(
        0,
        "notification Title",
        "notification body",
        NotificationDetails(
            android: AndroidNotificationDetails("channel_id", "channel_name",
                importance: Importance.high, priority: Priority.high)));
  }

  Future<void> scheduleNotifi() {
    return flnp.zonedSchedule(
        0,
        "scheduled",
        "scheduled notification",
        tz.TZDateTime.now(tz.UTC).add(Duration(seconds: 3)),
        NotificationDetails(
            android: AndroidNotificationDetails("channel_id", "channel_name",
                importance: Importance.high, priority: Priority.high)),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }

  void onNotificationSelected(String? payload) async {
    // if (payload != null) {
    //   print("payload: ${payload}");
    // } else {
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => SecondPage()));
    // }

    // with out animation
    // Navigator.push(
    //     context,
    //     PageRouteBuilder(
    //         pageBuilder: (context, animation, secondaryAnimation) =>
    //             SecondPage(),
    //         transitionDuration: Duration(seconds: 0)));

    // with animation
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SecondPage()));
    // 直後に元の画面に戻したらアニメーションもせずに終わる
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => MainPage()));
  }
}
