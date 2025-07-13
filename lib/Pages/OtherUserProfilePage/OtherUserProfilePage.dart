import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:smart_shopk4/Pages/HelperFunction/Navigation_Helper.dart';
import 'package:smart_shopk4/Pages/const/Colors/AppColor.dart';
import 'package:smart_shopk4/Pages/posts/List_Posts.dart';
import 'package:smart_shopk4/view_model/FollowViewModel/FollowViewModel.dart';
import 'package:smart_shopk4/view_model/OtherUserProfileViewModel/OtherUserProfileViewModel.dart';
class OtherUserProfilePage extends StatefulWidget {
  final String userId;

  const OtherUserProfilePage({super.key, required this.userId});

  @override
  State<OtherUserProfilePage> createState() => _OtherUserProfilePageState();
}

class _OtherUserProfilePageState extends State<OtherUserProfilePage> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final viewModel = Provider.of<OtherUserProfileViewModel>(context, listen: false);
      await viewModel.loadUserProfile(widget.userId);
      Provider.of<FollowViewModel>(context, listen: false).checkFollowStatus(widget.userId);
      Provider.of<FollowViewModel>(context, listen: false).loadCounts(widget.userId);
    });
  }
  @override
  Widget build(BuildContext context) {
    final profileVM = Provider.of<OtherUserProfileViewModel>(context);
    final  followVM = Provider.of<FollowViewModel>(context);
    if(profileVM.isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final user = profileVM.user;
    if (user == null) return Scaffold(body: Center(child: Text("User not found")));
    return Scaffold(
        appBar: AppBar(
        title: Text(user.userName ?? "Profile"),
    centerTitle: true,
        ),
      body: SingleChildScrollView(
           child: Column(
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundImage:
                      user.photoUri != null && user.photoUri!.isNotEmpty
                  ? NetworkImage(user.photoUri!)
                      : AssetImage('assets/Homepage/srk.jpg')

                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 10
                  ),
                  child: Text(
                     user.bio ?? "",

                    style: TextStyle(color: Colors.black,
                        fontSize: 15, fontWeight: FontWeight.w500),

                  ),

                ),

                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AnimatedSwitcher(
                        duration: Duration(milliseconds: 300),
                      child: followVM.isFollowing
                        ? OutlinedButton.icon(
                          onPressed: () {
                            followVM.toggleFollow(widget.userId);
                          },
                          icon: Icon(Icons.check, color: Colors.purple, size: 18),
                          label: Text(
                            "Following",
                            style: TextStyle(color: Colors.purple),
                      ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: Colors.purple
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          )

                        ),
                    )
                          : ElevatedButton(
                          onPressed: () {
                            followVM.toggleFollow(widget.userId);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryBlue500,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                            )
                          ),
                          child: Text(
                            'Follow',
                            style: TextStyle(
                              color: Colors.white
                            ),
                          )
                      ),
                    )
                  ]
                ),

                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisSize:  MainAxisSize.min,
                      children: [
                        Text(
                          '2',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),

                        SizedBox(height: 4),
                        Text(
                          'POSTS',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),

                    Container(
                      height: 30,
                      width: 1,
                      color: Colors.grey.shade400,
                    ),

                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${followVM.followerCount}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 4,),
                        Text('Followers',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black
                          ),
                        )

                      ],
                    ),

                    Container(
                      height: 30,
                      width: 1,
                      color: Colors.grey.shade400,
                    ),


                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('${followVM.followingCount}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 4,),
                        Text('following',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black
                          ),
                        )

                      ],
                    ),

                  ],
                ),
                SizedBox(height: 10,),
                Divider(color: Colors.black,
                    thickness: 1,),

                SizedBox(height: 10,),
                Text('All Posts',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,


                  ),
                ),

                Padding(padding: const EdgeInsets.all(8.0),
                  child: Consumer <OtherUserProfileViewModel>
                    (builder: (context, viewModel, child) {
                      return MasonryGridView.count(
                          crossAxisCount: 3,
                          crossAxisSpacing: 6,
                          mainAxisSpacing: 6,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: viewModel.userPosts.length,
                          itemBuilder: (context, index) {
                            final post =viewModel.userPosts[index];
                            return  GestureDetector(
                             onTap:    () {
                               NavigationHelper.nextPage(context, ListPosts(post: viewModel.userPosts, initialIndex: index));
                             },

                            child:
                              ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                post.mediaUrl ?? '',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                  Icon(Icons.broken_image, size: 50,),

                              )
                            ),
                            );
                          }
                      );
                  }),
                )

              ],

           ),
      )
    );
  }
}

/*
 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(

                        onPressed: () {
                          followVM.toggleFollow(widget.userId);
                        },
                        style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)
                            ),
                            side: BorderSide(color: Colors.black54)
                        ),
                        child:Text(
                           followVM.isFollowing ? "unfollow" : 'Follow',
                          style: TextStyle(color: Colors.black),
                        )
                    ),
                  ],
                ),
 */