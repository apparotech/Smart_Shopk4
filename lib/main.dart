import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:smart_shopk4/Pages/SignIn_Page/Sign_inPage.dart';
import 'package:smart_shopk4/Pages/SignUp_page/Sign_up.dart';
import 'package:smart_shopk4/Pages/const/Colors/AppColor.dart';
import 'package:smart_shopk4/Pages/mainScreen/TabScreen.dart';
import 'package:smart_shopk4/view_model/ProfileViewModel/ProfileViewModel.dart';
import 'package:smart_shopk4/view_model/edit_profile_view_model/edit_profile_view_model.dart';
import 'package:smart_shopk4/view_model/signin_view_model/sign_in_view_model.dart';
import 'package:smart_shopk4/view_model/signup_view_model/signup_view_model.dart';

void main()  async

 {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();

  runApp(
      //const MyApp());
     MultiProvider(
         providers:[
           ChangeNotifierProvider(create: (_) =>SignupViewModel()),
           ChangeNotifierProvider(create: (_)=> SignInViewModel()),
           ChangeNotifierProvider(create: (_) => ProfileViewModel()),
           ChangeNotifierProvider(create: (_)=> EditProfileViewModel())

         ],
       child: MyApp(),
     )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryBlue500),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner:  false,

      home: user != null ? const TabScreen() :  SignUp(),
    );
  }
}


