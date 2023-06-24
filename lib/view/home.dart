import 'dart:async';

import 'package:flutter/material.dart';

import '../services/local_notification.dart';
import '../services/notification_service.dart';
import '../utils/key_consts.dart';

final localNoti = LocalNotiService();

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final noti = NotificationService();

  @override
  void initState() {
    noti.requestNotiPermission();
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
              ElevatedButton(
                onPressed: localNoti.createProgressBarNotification,
                child: const Text('Download noti'),
              ),
              ElevatedButton(
                onPressed: localNoti.createNotiWhichWakeScreen,
                child: const Text('Wake screen noti'),
              ),
              ElevatedButton(
                onPressed: localNoti.createProgressNotificationWithPercent,
                child: const Text('Download noti with percent '),
              ),
              ElevatedButton(
                onPressed: () {
                  localNoti.createChatNotification(
                    image:
                        'https://newprofilepic2.photo-cdn.net//assets/images/article/profile.jpg',
                    channelKey: KeyConstants.chatChannelKey,
                    chatName: 'Jane grp',
                    groupKey: 'john1',
                    userName: 'Jane',
                    message: 'Hey how are you?',
                    // image: 'asset://asset/path to image'
                  );
                },
                child: const Text('Chat noti'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
