import 'package:flutter/material.dart';
import 'package:smart_shopk4/Pages/Components/storyWidget.dart';
import 'package:smart_shopk4/Pages/const/Colors/AppColor.dart';
import 'package:smart_shopk4/utils/firebase.dart';

class Feeds extends StatefulWidget {
  const Feeds({super.key});

  @override
  State<Feeds> createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {

  int page =5;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'wow',
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
      ),
      body:  RefreshIndicator(
        color: AppColors.primaryBlue500,
          onRefresh: () => postRef.orderBy('timestamp', descending: true).limit(page).get(),
          child:  SingleChildScrollView(
           physics: NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StoryWidget()
              ],
            ),
          ),

      )
    );
  }
}
