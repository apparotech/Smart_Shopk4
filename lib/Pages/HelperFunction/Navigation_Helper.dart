import 'package:flutter/material.dart';

class NavigationHelper {

  static void nextPage(BuildContext context, Widget page) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => page),
    );

  }
}