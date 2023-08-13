import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:share_plus/share_plus.dart';

class MyRemoteNotification {
  /// This will make only one instance of this class :) and ALSO known as singleton class.
  static final MyRemoteNotification _instance =
      MyRemoteNotification._internal();
  factory MyRemoteNotification() {
    return _instance;
  }
  MyRemoteNotification._internal();

  // final _noti = AwesomeNotificationsFcm();

  /// this method will request the FCm token from firebase
  Future<String> requestFCMToken() async {
    String fcmToken = '';
    // if (await _noti.isFirebaseAvailable) {
    //   try {
    //     fcmToken = await _noti.requestFirebaseAppToken();
    //     debugPrint(fcmToken);
    //   } catch (e, t) {
    //     debugPrintStack(
    //       label: e.toString(),
    //       stackTrace: t,
    //     );
    //   }
    // }
    try {
      fcmToken = await FirebaseMessaging.instance.getToken() ?? '';
      await Share.share(fcmToken);
      debugPrint(fcmToken);
    } catch (e, t) {
      debugPrintStack(
        label: e.toString(),
        stackTrace: t,
      );
    }
    return fcmToken; //todo add FCM token code from firebase
  }

  /// this method will subscribe to topic <br>
  /// the user who has sub to particular topic will <br>
  /// get only the notification of that topic
  Future<void> subScribeToTopic(String topic) async {
    // await _noti.subscribeToTopic(topic);
    debugPrint('Sub to topic $topic');
  }

  /// this method will unsubscribe to topic
  Future<void> unSubscribeToTopic(String topic) async {
    // await _noti.unsubscribeToTopic(topic); // todo unsub from firebase messanging code
    debugPrint('unsub to topic $topic');
  }

  ///
}
