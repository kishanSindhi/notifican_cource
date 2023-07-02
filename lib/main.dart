import 'package:flutter/material.dart';
import 'package:notifican_cource/services/notification_service.dart';
import 'package:notifican_cource/view/home.dart';

void main() async {
  final noti = NotificationService();

  WidgetsFlutterBinding.ensureInitialized();
  await noti.initLocalNotification();
  await noti.initRemoteNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Notification Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(
        title: 'Flutter Notification Demo',
      ),
    );
  }
}
