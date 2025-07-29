
import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_shopk4/Model/postModel.dart';
import 'package:smart_shopk4/Pages/CommentPage/CommentPage.dart';
import 'package:smart_shopk4/Pages/Components/CustomCard.dart';
import 'package:smart_shopk4/Pages/feeds/view_image.dart';
import 'package:smart_shopk4/services/Comment%20Service.dart';
import 'package:smart_shopk4/services/LikeService.dart';
import 'package:smart_shopk4/services/post_service.dart';
import 'package:smart_shopk4/utils/firebase.dart';

import '../const/Colors/AppColor.dart';
import 'package:timeago/timeago.dart' as timeago;


class UserPost extends StatelessWidget {

  final PostModel? posts;

   UserPost({super.key, this.posts});

  final DateTime timestamp = DateTime.now();



  currentUserId() {
    return firebaseAuth.currentUser!.uid;
  }


  final PostService service = PostService();
  final LikeService likeService = LikeService();
  final CommentService commentService = CommentService();

  @override
  Widget build(BuildContext context) {

    return CustomCard(
        child: OpenContainer(
          transitionType: ContainerTransitionType.fadeThrough,
            openBuilder: (BuildContext context, VoidCallback _) {
                return ViewImage(post: posts,);
            },
            closedElevation: 0.0,
          closedShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10)
            )
          ),
          onClosed: (v) {},
          closedColor: Theme.of(context).cardColor,
          closedBuilder: ( context, VoidCallback opencontainer) {

            return Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                      child: Image.network(posts?.mediaUrl ?? '',)

                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(timeago.format(posts!.timestamp!.toDate()),
                        style: TextStyle(
                          fontSize: 10
                        ),

                      ),

                    ),
                       Padding(
                           padding: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Padding(padding: const EdgeInsets.only(left: 0.0)),
                             Row(
                               children: [
                                 buildLikeButton(),
                                 SizedBox(width: 5,),
                                 InkWell(
                                   borderRadius: BorderRadius.circular(10.0),
                                   onTap: () {
                                     Navigator.of(context).push(
                                       CupertinoPageRoute(
                                           builder: (_) => CommentPage(post: posts,)
                                       )
                                     );
                                   },
                                   child: Icon(
                                     CupertinoIcons.chat_bubble,
                                     size: 25.0,
                                   ),
                                 )
                               ],
                             )
                           ],
                         ),

                       ),
                    SizedBox(height: 5.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                            child: Padding(
                                padding: const EdgeInsets.only(left: 0.0),
                              child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                  .collection('posts')
                                      .doc(posts!.postId)
                                      .snapshots(),


                                  builder: (context, snapshot) {
                                    if(!snapshot.hasData || snapshot.data?.data() == null) {
                                      return SizedBox();
                                    }

                                    final data = snapshot.data!.data() as Map<String, dynamic>;

                                    final likes = Map<String, dynamic>.from(data['likes'] ??{});
                                    final int likeCount = likeService.getLikeCount(Map<String, bool>.from(likes));
                                    return Text('$likeCount Likes' ?? " 0 ");
                                  }
                              ),
                            ),


                        ),
                        SizedBox(width: 12,),
                        buildCommentCount()
                      ],
                    )

                  ],
                )
              ],
            );
        }
        ),
        onTap: () {},
        borderRadius: BorderRadius.circular(10.0),
        elevated: false
    );
  }

  buildLikeButton() {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
        .collection('posts')
        .doc(posts!.postId)
        .snapshots(),
        builder: (context, snapshot) {
          if(!snapshot.hasData || snapshot.data?.data() == null) {
            return SizedBox();
          }
          final data = snapshot.data!.data() as Map<String, dynamic>;
          final likes  = Map<String, dynamic>.from(data['likes'] ?? {});
          final isLiked = likes.containsKey(currentUserId());
          return GestureDetector(
            onTap: () async {
               await likeService.toggleLike(posts!.id!, currentUserId());
            },
            child: Row(
              children: [
                Icon(
                  isLiked?  Icons.favorite : Icons.favorite_border,
                  color: isLiked ? AppColors.primaryBlue500 : Colors.grey,
                  size: 40,
                )
              ],
            ),
          );

        }


    );
  }

  buildCommentCount() {
    return StreamBuilder(
        stream :FirebaseFirestore.instance
        .collection('comments')
        .doc(posts!.postId)
        .collection('comments')
        .snapshots(),
        builder: (context, snapshot) {
          int commentCount = snapshot.hasData ? snapshot.data!.docs.length : 0;
          print('Post ID: ${posts!.postId}');
          return Text('$commentCount Comments',
          );
        }
    );
  }
}
