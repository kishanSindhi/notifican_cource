import 'dart:math' show Random;

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class LocalNotiService extends ChangeNotifier {
  Random random = Random();
  int scheduledId = 0;

  AwesomeNotifications _noti = AwesomeNotifications();

  /// This method will send simple notification to the device and no one will notice.
  void sendNoti() async {
    _noti.createNotification(
      content: NotificationContent(
        id: random.nextInt(10000),
        channelKey:
            'key', // The key should be the same as initalization notification
        title: 'This is title',
        body: 'this is body',
      ),
    );
  }

  void sendBigPictureNoti() async {
    _noti.createNotification(
      content: NotificationContent(
        id: random.nextInt(10000),
        channelKey: 'key',
        title: 'Big Picture Noti',
        body: 'Body',
        bigPicture:
            'https://imgv3.fotor.com/images/blog-cover-image/part-blurry-image.jpg',
        notificationLayout: NotificationLayout.BigPicture,
      ),
    );
  }

  void scheduledRepeatedNoti() async {
    scheduledId = random.nextInt(10000);
    _noti.createNotification(
      content: NotificationContent(
        id: scheduledId,
        channelKey: 'key',
        title: 'Scheduled Repeated Noti',
        body: 'BOdy',
      ),
      schedule: NotificationCalendar(
        second: 0,
        weekday:
            1, // 1 == monday,2 tuesday... time in 24 hrs you can also give date and year...
        repeats: true,
        hour: 10,
      ),
    );
  }

  void scheduleNoti() async {
    scheduledId = random.nextInt(10000);
    _noti.createNotification(
      content: NotificationContent(
        id: scheduledId,
        channelKey: 'key',
        title: 'Scheduled Noti',
        body: 'Body',
      ),
      schedule: NotificationCalendar.fromDate(
        date: DateTime.now().add(
          const Duration(
            seconds: 5,
          ),
        ),
        allowWhileIdle: true,
        preciseAlarm: true,
        repeats: false,
      ),
    );
  }

  void cancelRepeatedNoti() async {
    await _noti.cancelSchedule(scheduledId);
  }

  void notiWithActionButton() async {
    await _noti.createNotification(
      content: NotificationContent(
        id: random.nextInt(1000),
        channelKey: 'key',
        title: 'Notification With',
        body: 'Action Button',
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'reply',
          label: 'Reply',
          actionType: ActionType.Default,
          color: Colors.red,
          requireInputText: true, // this will ask for user input
          // autoDismissible:
          // true, if true it will dismiss the noti when tap of button
        ),
        NotificationActionButton(
          key: 'increment',
          label: 'Increment',
          actionType: ActionType.SilentAction,
          isDangerousOption: true,
        )
      ],
    );
  }

  void createNotificationWithPayLoad() async {
    await _noti.createNotification(
      content: NotificationContent(
        id: random.nextInt(1000),
        channelKey: 'key',
        actionType: ActionType.Default,
        title: 'This is a basic Notification',
        body: 'Click on this noti to go to temp screen',
        payload: {'screen_name': 'temp_screen'},
      ),
    );
  }
}
