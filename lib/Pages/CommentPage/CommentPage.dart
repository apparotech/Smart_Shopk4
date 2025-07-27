import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_shopk4/Model/Comment.dart';
import 'package:smart_shopk4/Model/postModel.dart';
import 'package:smart_shopk4/Pages/Components/CommentsStreamWrapper.dart';
import 'package:smart_shopk4/Pages/const/Colors/AppColor.dart';
import 'package:smart_shopk4/services/Comment%20Service.dart';
import 'package:smart_shopk4/utils/firebase.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentPage extends StatefulWidget {
  final PostModel? post;
  const CommentPage({super.key, this.post});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {

  CommentService commentService = CommentService();
  final DateTime timestamp = DateTime.now();
  TextEditingController commentsTEC = TextEditingController();
  CurrentUserId() {
    return firebaseAuth.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);

          },
          child: Icon(CupertinoIcons.xmark_circle_fill),


        ),
        centerTitle: true,
        title: Text('Comments'),

      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Flexible(
                child: ListView(
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: buildFullPost(),
                    ),
                    Divider(thickness: 1.5,),
                    buildComments()
                  ],
                )
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white
                  ),
                  constraints: BoxConstraints(
                    maxHeight: 190
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                          child: ListTile(
                            contentPadding: EdgeInsets.all(0),
                            title: TextField(
                              textCapitalization: TextCapitalization.sentences,
                              controller: commentsTEC,
                              style: TextStyle(
                                fontSize: 15.0,
                                color:
                                AppColors.primaryBlue500
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10.0),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide(
                                    color:
                                    Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide(
                                    color:
                                    Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide(
                                    color:
                                    Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                    Theme.of(context).colorScheme.secondary,
                                  ),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                hintText: "Write your comment...",
                                hintStyle: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black
                                ),
                              ),
                              maxLines: null,
                            ),
                            trailing: GestureDetector(
                              onTap: () async{
                                await commentService.uploadComment(
                                    CurrentUserId(),
                                    commentsTEC.text,
                                    widget.post!.id ?? " " ,
                                     widget.post!.mediaUrl ?? "",
                                );
                                commentsTEC.clear();
                            },

                              child: Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                child: Icon(
                                  Icons.send,
                                  color: AppColors.primaryBlue500,
                                ),
                              ),
                            ),
                          )
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  buildFullPost() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment:  MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 350.0,
              width: MediaQuery.of(context).size.width - 20.0,
              child: Image.network(widget.post!.mediaUrl!,)
            ),
           Padding(padding: const EdgeInsets.all(8.0),
             child: Row(
               children: [
                 Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(
                       widget.post!.description ?? " ",
                       style: TextStyle(
                         fontWeight: FontWeight.w800,
                       ),
                     ),
                     SizedBox(height: 4,),
                     Row(
                       children: [
                         Text(
                           timeago.format(widget.post!.timestamp!.toDate()),
                           style: TextStyle(

                           ),
                         ),
                         SizedBox(width: 3,)
                         
                       ],
                     )
                   ],
                 )
               ],
             ),
           )

          ],
    );
  }


  buildComments() {
    return CommentsStreamWrapper(
      shrinkWrap: true,
      stream: commentRef
          .doc(widget.post!.postId)
          .collection('comments')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (_, DocumentSnapshot snapshot) {
        Comment comment = Comment.fromJson(snapshot.data() as Map<String, dynamic>);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage(comment.userDp ?? ''),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(comment.username ?? "",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      Text(timeago.format(comment.timestamp!.toDate()),
                          style: TextStyle(fontSize: 10))
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50.0),
                child: Text(comment.comment!.trim()),
              )
            ],
          ),
        );
      },
    );
  }


}
