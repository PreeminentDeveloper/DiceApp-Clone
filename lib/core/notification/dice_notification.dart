import 'package:dice_app/core/util/helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final DiceNotification diceNotification = DiceNotification();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  logger.d('A bg message just showed up :  ${message.messageId}');
}

class DiceNotification {
  final AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      importance: Importance.high,
      playSound: true);

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initializeNotification() async {
    await Firebase.initializeApp();

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    final _messaging = FirebaseMessaging.instance;

    NotificationSettings _settings = await _messaging.requestPermission(
        alert: true, badge: true, provisional: true, sound: true);

    if (_settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen((RemoteMessage event) {
        flutterLocalNotificationsPlugin.show(0, event.notification?.title,
            event.notification?.body, _notificationDetails());
      });
    }
  }

  NotificationDetails _notificationDetails() {
    return NotificationDetails(
        android: AndroidNotificationDetails(channel.id, channel.name,
            color: Colors.blue,
            playSound: true,
            icon: '@drawable/d',
            enableLights: true,
            enableVibration: true,
            showWhen: true,
            channelShowBadge: true),
        iOS: const IOSNotificationDetails(
            presentAlert: true, presentBadge: true, presentSound: true));
  }
}
