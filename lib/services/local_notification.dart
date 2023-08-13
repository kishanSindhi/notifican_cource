import 'dart:math' show Random;

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:notifican_cource/utils/key_consts.dart';

class LocalNotiService extends ChangeNotifier {
  Random random = Random();
  int scheduledId = 0;

  final AwesomeNotifications _noti = AwesomeNotifications();

  /// This method will send simple notification to the device and no one will notice.
  void sendNoti({
    String title = 'This is title',
    String body = 'this is body',
    int? id,
  }) async {
    _noti.createNotification(
      content: NotificationContent(
        id: id ?? random.nextInt(10000),
        channelKey: KeyConstants
            .key, // The key should be the same as initalization notification
        title: title,
        body: body,
      ),
    );
  }

  void sendBigPictureNoti() async {
    _noti.createNotification(
      content: NotificationContent(
        id: random.nextInt(10000),
        channelKey: KeyConstants.key,
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
        channelKey: KeyConstants.key,
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
        channelKey: KeyConstants.key,
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
        channelKey: KeyConstants.key,
        title: 'Notification With',
        body: 'Action Button',
      ),
      actionButtons: [
        NotificationActionButton(
          key: KeyConstants.reply,
          label: 'Reply',
          actionType: ActionType.Default,
          color: Colors.red,
          requireInputText: true, // this will ask for user input
          // autoDismissible:
          // true, if true it will dismiss the noti when tap of button
        ),
        NotificationActionButton(
          key: KeyConstants.increment,
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
        channelKey: KeyConstants.key,
        actionType: ActionType.Default,
        title: 'This is a basic Notification',
        body: 'Click on this noti to go to temp screen',
        payload: {
          KeyConstants.screenName: KeyConstants.tempScreen,
        },
      ),
    );
  }

  Future<void> createProgressBarNotification() async {
    int id = random.nextInt(100000);
    await _noti.createNotification(
      content: NotificationContent(
        id: id,
        channelKey: KeyConstants.key,
        wakeUpScreen: true,
        title: 'Downloading file',
        locked: true,
        category: NotificationCategory.Progress,
        notificationLayout: NotificationLayout.ProgressBar,
      ),
      actionButtons: [
        NotificationActionButton(
          key: KeyConstants.cancel,
          label: 'Cancel',
          isDangerousOption: true,
          autoDismissible: true,
        )
      ],
    );
    await Future.delayed(const Duration(seconds: 2));
    await _noti.createNotification(
      content: NotificationContent(
        id: id,
        channelKey: KeyConstants.key,
        wakeUpScreen: true,
        title: 'Downloaded file',
      ),
    );
  }

  Future<void> createNotiWhichWakeScreen() async {
    await Future.delayed(const Duration(seconds: 4));
    await _noti.createNotification(
      content: NotificationContent(
        id: random.nextInt(1000),
        channelKey: KeyConstants.key,
        wakeUpScreen: true,
        title: 'This will wake screen',
        body: 'This is body ',
      ),
    );
  }

  Future<void> createProgressNotificationWithPercent() async {
    int id = random.nextInt(100000);
    for (int i = 1; i <= 10; i++) {
      await Future.delayed(const Duration(seconds: 1));
      await _noti.createNotification(
        content: NotificationContent(
          id: id,
          channelKey: KeyConstants.key,
          title: 'Downloading file ${i * 10} %',
          locked: false,
          category: NotificationCategory.Progress,
          notificationLayout: NotificationLayout.ProgressBar,
          progress: 10 * i,
        ),
      );
    }
    // await _noti.createNotification(
    //   content: NotificationContent(
    //     id: id,
    //     channelKey: KeyConstants.key,
    //     wakeUpScreen: true,
    //     title: 'Downloaded file',
    //   ),
    // );
  }

  Future<void> createChatNotification({
    String channelKey = '',
    String groupKey = '',
    String chatName = '',
    String userName = '',
    String message = '',
    String? image, // also known as large icon
  }) async {
    await _noti.createNotification(
      content: NotificationContent(
        id: random.nextInt(100000),
        channelKey: channelKey,
        groupKey: groupKey,
        actionType: ActionType.SilentBackgroundAction,
        summary: chatName,
        title: userName,
        body: message,
        largeIcon: image,
        notificationLayout: NotificationLayout.MessagingGroup,
        category: NotificationCategory.Message,
      ),
      actionButtons: [
        NotificationActionButton(
          key: KeyConstants.reply,
          label: 'Reply',
          autoDismissible: false,
          requireInputText: true,
          enabled: true,
        ),
        NotificationActionButton(
          key: KeyConstants.read,
          label: 'Mark as Read',
          autoDismissible: true,
        )
      ],
    );
  }
}
