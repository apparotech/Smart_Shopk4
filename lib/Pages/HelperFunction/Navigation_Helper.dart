import 'package:flutter/material.dart';

class NavigationHelper {

  static void nextPage(BuildContext context, Widget page) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => page),
    );

  }

  static void showInSnackBar(String value, context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
  }
}