import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:notifican_cource/main.dart';
import 'package:notifican_cource/view/temp_screen.dart';

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
          channelKey: 'key',
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
          icon:
              'resource://drawable/res_leaf', // here resource:// says that it is in res folder and add res_ infront of name so that icon do not get shrink.
          soundSource: 'resource://raw/cat', // only m4a file allowed
        ),
      ],
      debug: kDebugMode,
    );
  }

  void requiestNotiPermission() async {
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
  if (action.payload != null && action.payload!['screen_name'] != null) {
    MyApp.navigatorKey.currentState!.push(
      CupertinoPageRoute(
        builder: (context) => TempScreen(),
      ),
    );
  }
}
