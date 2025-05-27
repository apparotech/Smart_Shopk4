import 'package:flutter/material.dart';
import 'package:smart_shopk4/Pages/Home_Page/Home_Page.dart';
import 'package:smart_shopk4/Pages/Login_Page/Login_Page.dart';
import 'package:smart_shopk4/Pages/SignIn_Page/Sign_inPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SignInpage(),
    );
  }
}


