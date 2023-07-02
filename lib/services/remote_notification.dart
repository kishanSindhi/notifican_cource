import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
import 'package:flutter/foundation.dart';

class RemoteNotification {
  /// This will make only one instance of this class :) and ALSO known as singleton class.
  static final RemoteNotification _instance = RemoteNotification._internal();
  factory RemoteNotification() {
    return _instance;
  }
  RemoteNotification._internal();

  final _noti = AwesomeNotificationsFcm();

  /// this method will request the FCm token from firebase
  Future<String> requestFCMToken() async {
    String fcmToken = '';
    if (await _noti.isFirebaseAvailable) {
      try {
        fcmToken = await _noti.requestFirebaseAppToken();
        debugPrint(fcmToken);
      } catch (e, t) {
        debugPrintStack(
          label: e.toString(),
          stackTrace: t,
        );
      }
    }
    return fcmToken;
  }

  /// this method will subscribe to topic
  /// the user who has sub to particular topic will
  /// get only the notification of that topic
  Future<void> subScribeToTopic(String topic) async {
    await _noti.subscribeToTopic(topic);
    debugPrint('Sub to topic $topic');
  }

  /// this method will unsubscribe to topic
  Future<void> unSubscribeToTopic(String topic) async {
    await _noti.unsubscribeToTopic(topic);
    debugPrint('unsub to topic $topic');
  }

  ///
}
