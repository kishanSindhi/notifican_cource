import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:notifican_cource/main.dart';
import 'package:notifican_cource/view/home.dart';
import 'package:notifican_cource/view/temp_screen.dart';
import 'package:notifican_cource/utils/key_consts.dart';

class NotificationService extends ChangeNotifier {
  /// This will make only one instance of this class :) and ALSO known as singleton class.
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() {
    return _instance;
  }
  NotificationService._internal();

  AwesomeNotifications _noti = AwesomeNotifications();
  Random random = Random();
  int scheduledId = 0;

  void onChanged() {
    notifyListeners();
  }

  static Future<void> init() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: KeyConstants.key,
          channelName: 'Channel 1',
          channelDescription: 'For basic test',
          importance: NotificationImportance.Max,
          defaultPrivacy: NotificationPrivacy.Public,
          defaultRingtoneType: DefaultRingtoneType.Alarm,
          enableVibration: true,
          enableLights: true,
          defaultColor: Colors.red,
          channelShowBadge: true,
          playSound: true,
          icon: KeyConstants
              .iconPath, // here resource:// says that it is in res folder and add res_ infront of name so that icon do not get shrink.
          soundSource:
              KeyConstants.notificationSoundPath, // only m4a file allowed
        ),
        NotificationChannel(
          channelKey: KeyConstants.chatChannelKey,
          channelGroupKey: KeyConstants.chatGroupKey,
          channelName: KeyConstants.chatChannelName,
          channelDescription: 'Your chat notification will be displayed here',
          channelShowBadge: true,
          importance: NotificationImportance.Max,
          icon: KeyConstants
              .iconPath, // here resource:// says that it is in res folder and add res_ infront of name so that icon do not get shrink.
          soundSource:
              KeyConstants.notificationSoundPath, // only m4a file allowed
        ),
      ],
      debug: kDebugMode,
    );
  }

  void requestNotiPermission() async {
    _noti.isNotificationAllowed().then((value) {
      if (!value) {
        _noti.requestPermissionToSendNotifications();
      }
    });
  }

  /// this function will handel when app is in foreground or in bg
  Future<void> initNotiFicationEventListeners() async {
    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: _onActionReceivedMethod,
      onDismissActionReceivedMethod: _onDismissActionReceivedMethod,
      onNotificationCreatedMethod: _onNotificationCreatedMethod,
      onNotificationDisplayedMethod: _onNotificationDisplayedMethod,
    );
  }

  /// This function will called when the app is in terminated state
  Future<void> getInitialNotificationAction() async {
    final ReceivedAction? action =
        await _noti.getInitialNotificationAction(removeFromActionEvents: true);
    if (action != null) {
      navigatorHelper(action);
    }
  }

  Future<void> _onActionReceivedMethod(ReceivedAction receivedAction) async {
    debugPrint(receivedAction.toString());
    navigatorHelper(receivedAction); //  this will navigate to temp screen
    debugPrint('recived action -> ${receivedAction.buttonKeyInput}');
    sendReplyNotification(receivedAction);
  }

  Future<void> _onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint('notification dismissed');
  }

  Future<void> _onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('notification created');
  }

  Future<void> _onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('notification displayed');
  }
}

void navigatorHelper(ReceivedAction action) {
  if (action.payload != null &&
      action.payload![KeyConstants.screenName] != null) {
    MyApp.navigatorKey.currentState!.push(
      CupertinoPageRoute(
        builder: (context) => TempScreen(),
      ),
    );
  }
}

void sendReplyNotification(ReceivedAction receivedAction) {
  if (receivedAction.channelKey == KeyConstants.chatChannelKey) {
    if (receivedAction.buttonKeyPressed == KeyConstants.reply) {
      localNoti.createChatNotification(
        channelKey: receivedAction.channelKey!,
        chatName: receivedAction.summary!,
        groupKey: receivedAction.groupKey!,
        image:
            'https://pbs.twimg.com/profile_images/1485050791488483328/UNJ05AV8_400x400.jpg',
        message: receivedAction.buttonKeyInput,
        userName: 'You',
      );
    }
  }
}
