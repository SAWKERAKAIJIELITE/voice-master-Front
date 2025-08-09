import 'dart:developer';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';

import 'dart:io' show Platform;

@lazySingleton
class NotificationManager {
  FirebaseMessaging? _firebaseMessaging;
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Map<String, dynamic> notificationData = {};

  Future showNotification(RemoteMessage msg) async {
    if (kDebugMode) {
      print("showNotification: $msg");

      print(
          "title: ${msg.notification?.title} body:, ${msg.notification?.body} ${msg.messageId}");
    }
    int notificationId = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      notificationId.toString(),
      'high_importance_channel',
      channelDescription: 'your channel description',
      playSound: true,
      groupKey: null,
      sound: const RawResourceAndroidNotificationSound('notification'),
      importance: Importance.max,
      priority: Priority.max,
    );
    DarwinNotificationDetails iOSPlatformChannelSpecifics =
        const DarwinNotificationDetails(
            presentAlert: true, presentBadge: true, presentSound: true);
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    if (Platform.isIOS) {
      await _flutterLocalNotificationsPlugin.show(
        notificationId,
        msg.notification?.title,
        msg.notification?.body,
        platformChannelSpecifics,
        payload: 'Default_Sound',
      );
    }

    if (Platform.isAndroid) {
      await _flutterLocalNotificationsPlugin.show(0, (msg.notification?.title),
          (msg.notification?.body), platformChannelSpecifics,
          payload: 'Default_Sound');
    }
  }

  cancel() {
    _flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> initFirebaseCloudMessaging(
      BuildContext context, Function(String token) callBack) async {
    // if (Firebase.apps.isEmpty) {
    //   await Firebase.initializeApp(
    //       options: DefaultFirebaseOptions.currentPlatform);
    // }

    _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging?.requestPermission(
        alert: true, badge: true, provisional: true, sound: true);
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    AndroidInitializationSettings android =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    DarwinInitializationSettings ios = const DarwinInitializationSettings();
    InitializationSettings platform =
        InitializationSettings(android: android, iOS: ios);
    _flutterLocalNotificationsPlugin.initialize(
      platform,
      onDidReceiveNotificationResponse: (response) async {
        handleNotification(context, notificationData);
        debugPrint('notification diaa: ${response.payload}');
      },
    );

    FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);

    _firebaseMessaging?.getToken().then((token) {
      callBack(token ?? '');
    });

    _firebaseMessaging?.onTokenRefresh.listen((token) {
      callBack(token);
    });

    FirebaseMessaging.onMessage.listen((event) async {
      if (kDebugMode) {
        print(
            '_firebaseMessaging onMessage:${event.notification?.title ?? ''}');
      }
      if (kDebugMode) {
        print('data:${event.data}');
      }

      if (kDebugMode) {
        print('messageId:${event.messageId ?? ''}');
      }
      notificationData = event.data;
    });

    FirebaseMessaging.instance.getInitialMessage().then((value) {
      if (value != null) {
        handleNotification(context, value.data);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleNotification(context, event.data);
    });
  }

  @pragma('vm:entry-point')
  static Future<void> myBackgroundMessageHandler(RemoteMessage message) async {
    //Here you can add
    // await Firebase.initializeApp(
    //     options: DefaultFirebaseOptions.currentPlatform);
    if (kDebugMode) {
      print('myBackgroundMessageHandler:--:');
    }
  }

  /// When receive notification
  handleNotification(
      BuildContext context, Map<String, dynamic> notificationData) async {
    log('Handling Notification $notificationData');
  }

  Future<bool> areNotificationsEnabled() async {
    if (Platform.isAndroid) {
      // Check for Android
      final bool isNotificationEnabled = await _flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.areNotificationsEnabled() ??
          false;

      return isNotificationEnabled;
    } else if (Platform.isIOS) {
      // Check for iOS
      final IOSFlutterLocalNotificationsPlugin? iosImplementation =
          _flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  IOSFlutterLocalNotificationsPlugin>();

      if (iosImplementation != null) {
        final NotificationAppLaunchDetails? details =
            await _flutterLocalNotificationsPlugin
                .getNotificationAppLaunchDetails();

        // On iOS, you need to request permission first before checking.
        final bool? isGranted = await iosImplementation.requestPermissions(
            alert: true, badge: true, sound: true);

        return isGranted ?? false;
      }
    }

    // For platforms other than Android and iOS, return false (or you can add more checks).
    return false;
  }
}
