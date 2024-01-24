import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutterfcm/firebase_options.dart';

import 'api/firebase_api.dart';
import 'homepage.dart';
import 'page/notificationscreen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future _firebaseBackground(RemoteMessage message) async {
  if (message.notification != null) {
    print("Some Notification");
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //on background notification tap
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.notification != null) {
      print(message.notification!.body);
      navigatorKey.currentState!
          .pushNamed("/message", arguments: message.notification!.body);
    }
  });
  PushNotifications.init();
  PushNotifications.localNotiInit();
  //listten background Notification
  FirebaseMessaging.onBackgroundMessage(_firebaseBackground);

  //menhandle foreground nofication
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String payloadData = jsonDecode(message.data as String);
    print("got message");
    if (message.notification != null) {
      PushNotifications.showSimpleNotification(
        title: message.notification!.title!,
        body: message.notification!.body!,
        payload: payloadData,
      );
    }
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      home: HomePage(),
      routes: {
        '/home': (context) => const HomePage(),
        '/message': (context) => const NotificationScreen(),
      },
    );
  }
}
