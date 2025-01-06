import 'dart:convert';
import 'package:client/core/services/auth_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:googleapis/servicecontrol/v2.dart';
import 'package:http/http.dart' as http;
import 'package:client/firebase_options.dart';

import '../../env/env.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  static late AndroidNotificationChannel channel;

  static Future<void> setupFirebase() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

    await setupFlutterNotifications();

    await messaging.requestPermission();

    String? token = await messaging.getToken();
    if (token != null) {
      await sendTokenToServer(token);
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showFlutterNotification(message);
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    showFlutterNotification(message);
  }

  static Future<void> setupFlutterNotifications() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    channel = const AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  static void showFlutterNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null && !kIsWeb) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: 'launch_background',
          ),
        ),
      );
    }
  }

  static Future<void> sendTokenToServer(String token) async {
    try {
      final userToken = await AuthServices().getToken();
      final response = await http.post(
        Uri.parse('${Env.BACKEND_URL}/store-fcm-token/$token'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $userToken',
        },
      );

      if (response.statusCode == 200) {
      } else {
      }
    } catch (e) {
    }
  }

  static Future<void> initialize() async {
    await setupFirebase();
  }
}