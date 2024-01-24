import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutterfcm/firebase_options.dart';

import 'api/firebase_api.dart';
import 'homepage.dart';

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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HomePage(),
    );
  }
}
