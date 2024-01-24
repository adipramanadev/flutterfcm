import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  static const route = '/notification-screen';
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
      )
    );
  }
}
