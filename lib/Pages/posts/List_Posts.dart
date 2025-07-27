import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:smart_shopk4/Model/postModel.dart';
import 'package:smart_shopk4/Pages/CommentPage/CommentPage.dart';
import 'package:smart_shopk4/Pages/HelperFunction/Navigation_Helper.dart';
import 'package:smart_shopk4/Pages/const/Colors/AppColor.dart';
import 'package:smart_shopk4/services/LikeService.dart';
import 'package:smart_shopk4/services/UserService.dart';
import 'package:smart_shopk4/view_model/List_Posts_View_Model/List_Post_View_Model.dart';
import 'package:intl/intl.dart';
class ListPosts extends StatefulWidget {
  final List<PostModel> post;
  final int initialIndex;

  const ListPosts({super.key, required this.post, required this.initialIndex});

  @override
  State<ListPosts> createState() => _ListPostsState();
}

class _ListPostsState extends State<ListPosts> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final viewModel = Provider.of<ListPostViewModel>(context, listen: false);
      viewModel.fetchPostsAndUsers(widget.post);
    });
  }
  LikeService likeService = LikeService();
  currentUser() {
    FirebaseAuth.instance.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ListPostViewModel>(context);
    final isLoading = viewModel.isLoading;
    final posts = viewModel.posts;

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(Ionicons.chevron_back),
        ),
        centerTitle: true,
        title: Text('Posts', style: TextStyle(fontSize: 20, color: Colors.black)),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        controller: ScrollController(
          initialScrollOffset: widget.initialIndex * 300.0,
        ),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          final user = viewModel.getUserById(post.ownerId);
          final formattedDate = post.timestamp != null
              ? DateFormat('d MMMM').format(post.timestamp!.toDate())
              : '';

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: user?.photoUri != null &&
                      user!.photoUri!.isNotEmpty
                      ? NetworkImage(user.photoUri!)
                      : AssetImage('assets/default_avatar.png') as ImageProvider,
                ),
                title: Text(user?.userName ?? ''),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(post.description ?? ''),
              ),
              const SizedBox(height: 5),
              Image.network(
                post.mediaUrl ?? '',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(formattedDate),
              ),


              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Like logic here
                      },
                      child: Row(
                        children:  [
                        StreamBuilder<DocumentSnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('posts')
                                .doc(post.postId)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if(!snapshot.hasData || snapshot.data?.data() == null){
                                return SizedBox();
                              }

                              final data= snapshot.data!.data() as Map<String, dynamic>;
                              final likes = Map<String, dynamic>.from(data['likes'] ?? {});
                              final isLiked = likes.containsKey(FirebaseAuth.instance.currentUser!.uid);

                              return GestureDetector(
                                onTap: () async {
                                  await likeService.toggleLike(post.postId!, FirebaseAuth.instance.currentUser!.uid );
                                
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      isLiked ? Icons.favorite : Icons.favorite_border,
                                      color: isLiked ? AppColors.primaryBlue500 : Colors.grey,
                                      size: 40,

                                    )
                                  ],
                                ),
                              );

                            }
                        )
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        NavigationHelper.nextPage(context, CommentPage(post: post,));
                      },
                      child: Row(
                        children: const [
                          Icon(CupertinoIcons.chat_bubble, color: Colors.grey, size: 40),
                          SizedBox(width: 5),


                        ],
                      ),
                      
                    ),

                  ],
                ),


              ),
             //SizedBox(width: 12,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [

                    Expanded(
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                          .collection('posts')
                          .doc(post.postId)
                          .snapshots(),

                          builder: (context, snapshot){

                            if (!snapshot.hasData || snapshot.data?.data() == null) {
                              return SizedBox();
                            }
                            final data = snapshot.data!.data() as Map<String, dynamic>;
                            final likes = Map<String, dynamic>.from(data['likes'] ?? {});
                            final int likeCount = likeService.getLikeCount(Map<String, bool>.from(likes));

                            return Text('$likeCount Likes ' ??  '0');

                          }),
                    ),

                    SizedBox(width: 20,),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                        .collection('comments')
                        .doc(post.postId)
                        .collection('comments')
                        .snapshots(),
                        builder: (context, snapshot) {
                          int commentCount = snapshot.hasData ? snapshot.data!.docs.length : 0;
                          print('Post ID: ${post.postId}');
                          return Text('$commentCount Comment');



                        }
                    )

                  ],
                ),
              ),
              Divider(),
            ],
          );
        },
      ),
    );
  }
}

