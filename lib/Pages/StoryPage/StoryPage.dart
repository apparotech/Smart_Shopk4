
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_shopk4/Model/UserModel.dart';
import 'package:smart_shopk4/Model/storyModel.dart';
import 'package:smart_shopk4/Pages/Components/indicators.dart';
import 'package:smart_shopk4/Pages/const/Colors/AppColor.dart';
import 'package:smart_shopk4/utils/firebase.dart';
import 'package:story/story.dart';
import 'package:timeago/timeago.dart' as timeago;

class StoryPage extends StatefulWidget {

  final initPage;
  final statusId;
  final storyId;
  final userId;

  const StoryPage({super.key, required this.initPage, required this.statusId, required this.storyId, required this.userId});

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body:  GestureDetector(
         onVerticalDragUpdate: (value) {
           Navigator.pop(context);
         },

         child: FutureBuilder<QuerySnapshot>(
             future: statusRef.doc(widget.statusId).collection('statuses').get(),

             builder: (context, snapshot) {
              // List status = snapshot.data!.docs;
               //return snapshot.connectionState == ConnectionState.waiting
                //   ? circularProgress(context)
               if(snapshot.connectionState == ConnectionState.waiting) {
                 return circularProgress(context);
               }
               if(!snapshot.hasData|| snapshot.data == null) {
                 return Center(child: Text('No Stroy '),);
               }
               List status = snapshot.data!.docs;
                    return StoryPageView(
                 indicatorPadding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
                   indicatorHeight: 15,
                   initialPage: 0,
                   onPageLimitReached: () {
                   Navigator.pop(context);
                   },
                   indicatorUnvisitedColor: AppColors.primaryBlue500,
                   indicatorDuration: Duration(seconds: 30),

                   itemBuilder: (context, pageIndex, storyIndex) {
                      StoryModel storyModel = StoryModel.fromJson(
                        status.toList()[storyIndex].data()
                      );
                     //we will get the list of all viewers for each status
                     //then add our id to the list if it does not exist
                     List<dynamic>? allViewers = storyModel.viewers;
                     if(allViewers!.contains(firebaseAuth.currentUser!.uid)) {
                       print('ID ALREADY EXIST');
                     } else {
                       allViewers.add(firebaseAuth.currentUser!.uid);
                       statusRef
                       .doc(widget.statusId)
                       .collection('statuses')
                       .doc(storyModel.statusId)
                       .update({'viewers' : allViewers});
                     }
                     return Container(
                       height: MediaQuery.of(context).size.height,
                       width: MediaQuery.of(context).size.width,
                       child: Stack(
                         children: [
                           Padding(padding: EdgeInsets.symmetric(vertical: 50),
                             child: getImage(storyModel.url!)
                           ),
                           Positioned(
                             top: 65,
                               left: 10,

                               child: FutureBuilder(
                                   future: userRef.doc(widget.userId).get(),
                                   builder: (context, snapshot) {
                                     if(snapshot.hasData) {
                                       DocumentSnapshot documentSnapshot = snapshot
                                           .data as DocumentSnapshot<Object?>;

                                       UserModel user = UserModel.fromJson(
                                           documentSnapshot.data()
                                           as Map<String, dynamic>
                                       );

                                       return Padding(
                                         padding: const EdgeInsets.only(
                                             right: 10),
                                         child: Row(
                                           children: [
                                             Container(
                                               decoration: BoxDecoration(
                                                   color: Theme
                                                       .of(context)
                                                       .colorScheme
                                                       .secondary,
                                                   shape: BoxShape.circle,
                                                   border: Border.all(
                                                     color: Colors.transparent,
                                                   ),
                                                   boxShadow: [
                                                     BoxShadow(
                                                         color: Colors.grey
                                                             .withOpacity(0.3),
                                                         offset: new Offset(
                                                             0, 0),
                                                         blurRadius: 2,
                                                         spreadRadius: 0.0
                                                     )
                                                   ]
                                               ),
                                               child: Padding(
                                                 padding: const EdgeInsets.all(
                                                     1),
                                                 child: CircleAvatar(
                                                   radius: 15.0,
                                                   backgroundColor: Colors.grey,
                                                   backgroundImage: CachedNetworkImageProvider(
                                                     user.photoUri ?? "",

                                                   ),
                                                 ),
                                               ),
                                             ),
                                             const SizedBox(width: 10,),
                                             Column(
                                               children: [
                                                 Text(
                                                   user.userName ?? " ",
                                                   style: TextStyle(
                                                     fontSize: 14.0,
                                                     fontWeight: FontWeight
                                                         .bold,

                                                   ),
                                                 ),
                                                 Text(
                                                   "${timeago.format(
                                                       storyModel.time!
                                                           .toDate())}",
                                                   style: TextStyle(
                                                       fontSize: 12,
                                                       fontWeight: FontWeight
                                                           .bold,
                                                       color: Colors.grey
                                                   ),
                                                 )
                                               ],
                                             )
                                           ],
                                         ),
                                       );
                                     } else {
                                       return const SizedBox();
                                     }
                                   }
                               )
                           ),
                           Positioned(
                             bottom: widget.userId == firebaseAuth.currentUser!.uid
                               ? 10.0
                               : 30.0,

                               child:  Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 crossAxisAlignment: CrossAxisAlignment.center,
                                 children: [
                                   Container(
                                     color: Colors.grey.withOpacity(0.2),
                                     width: MediaQuery.of(context).size.width,
                                     constraints:
                                     BoxConstraints(
                                       maxHeight: 50.0
                                     ),
                                     child: Center(
                                       child: Column(
                                         mainAxisAlignment: MainAxisAlignment.center,
                                         crossAxisAlignment: CrossAxisAlignment.center,
                                         children: [
                                           Padding(
                                               padding:  const EdgeInsets.symmetric(horizontal: 20),
                                             child: Text(
                                               storyModel.caption ?? "",
                                               textAlign: TextAlign.center
                                             ),
                                           )
                                         ],
                                       ),
                                     ),
                                   ),
                                   if(widget.userId == firebaseAuth.currentUser!.uid)
                                     TextButton.icon(
                                         onPressed: () {},
                                         label: Text(
                                           storyModel.viewers!.length.toString(),
                                           style: TextStyle(
                                             fontSize: 12,
                                             color: Colors.grey
                                           ),
                                         )
                                     )
                                 ],
                               )
                           )
                         ],
                       ),
                     );

                   },
                   storyLength: (int pageIndex) {
                   return status.length;
                   },
                   pageLength: 1
               );
             }),
       ),
    );
  }
  
  getImage(String url) {
    return AspectRatio(
        aspectRatio: 9 /16,
      child: Image.network(url),
    );
  }
}
