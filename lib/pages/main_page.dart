import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_notification/helpers/notification_helper.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:my_notification/pages/second_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final FlutterLocalNotificationsPlugin flnp;
  late final NotifyHelper notifyHelper;
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initNotification();
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
              onPressed: () =>
                  notifyHelper.pushNotifi("This is title", "This is body"),
              child: Text("Push Notification"),
            ),
            ElevatedButton(
                onPressed: () => notifyHelper.scheduleNotifi(
                    "This is title", "This is body", 10),
                child: Text("schedule notification"))
          ],
        ),
      ),
    );
  }
}
