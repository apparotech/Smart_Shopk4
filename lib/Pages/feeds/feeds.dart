import 'package:flutter/material.dart';

class Feeds extends StatefulWidget {
  const Feeds({super.key});

  @override
  State<Feeds> createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Text("Feeds",
        style: TextStyle(
          fontSize: 20
        ),),
      ),
    );
  }
}
