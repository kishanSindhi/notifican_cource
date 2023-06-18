import 'dart:async';

import 'package:flutter/material.dart';

import '../services/local_notification.dart';
import '../services/notification_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final noti = NotificationService();
  final localNoti = LocalNotiService();

  @override
  void initState() {
    noti.requiestNotiPermission();
    noti.initNotiFicationEventListeners();
    scheduleMicrotask(() {
      // schedule micro task means delay of i guess 0.5 sec
      noti.getInitialNotificationAction();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: localNoti.sendNoti,
                child: const Text('Send noti'),
              ),
              ElevatedButton(
                onPressed: localNoti.sendBigPictureNoti,
                child: const Text('Big picture'),
              ),
              ElevatedButton(
                onPressed: localNoti.scheduledRepeatedNoti,
                child: const Text('Schedule noti'),
              ),
              ElevatedButton(
                onPressed: localNoti.cancelRepeatedNoti,
                child: const Text('Cancel scheduled noti'),
              ),
              ElevatedButton(
                onPressed: localNoti.notiWithActionButton,
                child: const Text('Noti With button'),
              ),
              ElevatedButton(
                onPressed: localNoti.createNotificationWithPayLoad,
                child: const Text('Navigate Notification'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
