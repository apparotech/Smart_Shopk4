import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_shopk4/Model/postModel.dart';
import 'package:smart_shopk4/Pages/Components/indicators.dart';
import 'package:smart_shopk4/Pages/Components/storyWidget.dart';
import 'package:smart_shopk4/Pages/const/Colors/AppColor.dart';
import 'package:smart_shopk4/Pages/feeds/UserPost.dart';
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
                StoryWidget(),
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: FutureBuilder(
                      future: postRef
                      .orderBy('timestamp', descending: true)
                      .limit(page)
                      .get(),
                      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if(snapshot.hasData) {
                          var snap = snapshot.data;
                          List docs = snap!.docs;
                          return ListView.builder(
                            itemCount: docs.length,
                              shrinkWrap: true,

                              itemBuilder: (context, index) {
                              PostModel posts = PostModel.fromJson(docs[index].data());

                              return Padding(
                                  padding: const EdgeInsets.all(10),
                                child: UserPost(posts: posts,)
                              );

                              }
                          );
                        } else if(snapshot.connectionState == ConnectionState.waiting) {
                          return circularProgress(context);
                        } else {
                          return Center(
                            child: Text(
                              'No Feeds',
                              style: TextStyle(
                                fontSize: 26.0,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          );
                        }
                      }
                  )
                  ,
                )
              ],
            ),
          ),

      )
    );
  }
}
