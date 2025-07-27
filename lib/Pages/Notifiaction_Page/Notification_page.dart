import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(
        title: Text('Notification'),
        centerTitle: true,
        actions: [
          Padding(padding: const EdgeInsets.all(20.0),
          )
        ],
      ),
    );
  }
}

