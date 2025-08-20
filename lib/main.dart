import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:get/get.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:japbusi/app/data/app_provider.dart';
import 'package:japbusi/app/data/auth_provider.dart';
import 'package:japbusi/app/data/griveance_provider.dart';
import 'package:japbusi/app/data/home_provicer.dart';
import 'package:japbusi/app/data/services/app_service.dart';
import 'package:japbusi/app/data/services/auth_service.dart';
import 'package:japbusi/app/data/services/griveance_service.dart';
import 'package:japbusi/app/data/services/home_service.dart';
import 'package:japbusi/app/utils/api_client.dart';
import 'package:japbusi/app/utils/app_theme.dart';

import 'app/routes/app_pages.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  _showLocalNotification(message);
}

Future<void> _onMessageOpenedApp(RemoteMessage message) async {
  final type = message.data['type'];
  final id = message.data['id'];

  if (type != null && id != null) {
    switch (type) {
      case 'article':
        Get.toNamed(Routes.ARTICLE, arguments: {"id": id});
        break;
    }
  }
}

void _showLocalNotification(RemoteMessage message) async {
  String? title = message.data['title'];
  String? body = message.data['body'];
  if (title != null) {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'grievance_channel',
          'Grievance Channel',
          importance: Importance.max,
          priority: Priority.high,
        );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0, // unique ID
      title,
      body,
      platformChannelSpecifics,
      payload: jsonEncode(message.data),
    );
  }
}

void _handleMessageTap(RemoteMessage message) {
  final type = message.data['type'];
  final id = message.data['id'];
  print("type: $type, id: $id");

  if (type != null && id != null) {
    switch (type) {
      case 'article':
        Get.toNamed(Routes.ARTICLE, arguments: {"id": id});
        break;
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('icon');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      if (response.payload != null) {
        Get.toNamed(Routes.ARTICLE, arguments: {"id": response.payload});
      }
    },
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    _showLocalNotification(message);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    _handleMessageTap(message);
  });

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  String? token = await messaging.getToken();
  await initServices(token ?? '');

  runApp(
    GetMaterialApp(
      title: "JAPBUSI",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
    ),
  );
}

Future<void> initServices(String token) async {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {});
  await Get.putAsync(() => ApiClient().init());
  Get.put(AppProvider());
  Get.lazyPut(() => AuthProvider());
  Get.lazyPut(() => GriveanceProvider());
  Get.lazyPut(() => HomeProvider());

  await Get.putAsync(() => AppService().init());
  await Get.putAsync(() => AuthService().init(token));
  await Get.putAsync(() => GriveanceService().init());
  await Get.putAsync(() => HomeService().init());
}
