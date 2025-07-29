import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:smart_shopk4/Model/UserModel.dart';
import 'package:smart_shopk4/Model/postModel.dart';
import 'package:smart_shopk4/Pages/Chat_Page/recentChat.dart';
import 'package:smart_shopk4/Pages/Components/Buttons/customButton.dart';
import 'package:smart_shopk4/Pages/Components/Buttons/menuButton.dart';
import 'package:smart_shopk4/Pages/Components/Naviagation_Page/Navigation_page.dart';
import 'package:smart_shopk4/Pages/EditProfile/EditProfile.dart';
import 'package:smart_shopk4/Pages/Follow/Follow.dart';
import 'package:smart_shopk4/Pages/HelperFunction/Navigation_Helper.dart';
import 'package:smart_shopk4/Pages/Settings/Settings.dart';
import 'package:smart_shopk4/Pages/const/Colors/AppColor.dart';
import 'package:smart_shopk4/Pages/posts/List_Posts.dart';
import 'package:smart_shopk4/view_model/FollowViewModel/FollowViewModel.dart';

import 'package:smart_shopk4/view_model/ProfileViewModel/ProfileViewModel.dart';

class ProfilePage extends StatefulWidget {
   ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  void initState() {
    super.initState();
        Future.microtask(() async {
          final uid  = FirebaseAuth.instance.currentUser?.uid;
          if(uid != null) {
            final profileViewModel = Provider.of<ProfileViewModel>(context, listen: false);
            final followViewModel  = Provider.of<FollowViewModel>(context, listen:  false);

            await profileViewModel.fetchUser();
            await profileViewModel.fetchUserPosts(uid);
            await followViewModel.loadCounts(uid);
          }
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    final profileViewModel = Provider.of<ProfileViewModel>(context);
    final followViewModel = Provider.of<FollowViewModel>(context);
    final user = profileViewModel.user;
    if(user == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(profileViewModel.user?.userName ??" loading", style: TextStyle(color: AppColors.primaryBlue500,

        fontWeight: FontWeight.bold),),
                  actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                  child: IconButton(
                      onPressed: () {
                        NavigationHelper.nextPage(context, RecentChat());
                      },
                      icon: Icon(Ionicons.chatbubble_ellipses, color: AppColors.primaryBlue500,)
                  )
    )
    ],

    ),
                body: SingleChildScrollView(
                           child: Column(
                             children: [
                 CircleAvatar(
                   radius: 80,
                   backgroundImage:profileViewModel.user?.photoUri !=null && profileViewModel.user!.photoUri!.isNotEmpty
                     ? NetworkImage(profileViewModel.user!.photoUri!)
                       :AssetImage('assets/Homepage/profile.jpg') as ImageProvider,
                 ),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10
                              ),
                                   child: Text(
                        profileViewModel.user?.bio ?? " ",

          style: TextStyle(color: Colors.black,
          fontSize: 15, fontWeight: FontWeight.w500),

    ),
    ),
                              Padding(
                          padding: const EdgeInsets.only(top: 20, ),

                                  child: Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                        customButton(
                                         icon: Icons.settings,
                                         text: "Settings   ",
                                                onTap: () {
                                           NavigationHelper.nextPage(context, Settings());
                                                }
    ),
    //SizedBox(width: 80),
                                         customButton(
                                    icon: Icons.edit,
                                      text:  'Edit Profile',
                                       onTap: () async {

                                    final result = await Navigator.push(
                                           context,
                                          MaterialPageRoute(builder: (_) =>EditProfile())
   );

                                    if(result == true) {
                                       Provider.of<ProfileViewModel>(context, listen:  false).fetchUser();
   }
    }
    ),
                                       menuButton(icon: Icons.more_vert, onTap: () {})

    ],

    ),
    ),

                             Padding(padding: const EdgeInsets.only(top: 20),
                             child: Divider(
                              color: Colors.black,
                       thickness: 1,
    ),
    ),
                              Padding(padding: const EdgeInsets.only(top: 1, ),
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                         children: [
    // Posts
                                         Column(
                                               mainAxisSize: MainAxisSize.min,
                                              children: const [
                                              Text(
                                                   '4',
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

    // Vertical Divider
                                         Container(
                                         height: 30,
                                             width: 1,
                                            color: Colors.grey.shade400,
                                       ),

    // Followers
                                       InkWell(
                                      onTap: () {
                                        NavigationHelper.nextPage(context, Follow());
                                      },

                                             child: Column(
                                                   mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text('${followViewModel.followerCount}',
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

    ),

    // Vertical Divider
                                            Container(
                                          height: 30,
                                           width: 1,
                                     color: Colors.grey.shade400,
    ),

    // Following
                                         InkWell(
                                             onTap: () {},

                                             child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                         children: [
                                                      Text('${followViewModel.followingCount}',
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

    )
    ],
    )


    ),
                               Padding(padding: const EdgeInsets.only(top: 1),
                                child: Divider(
                                                 color: Colors.black,
                                                   thickness: 1,
    ),

    ),
                               SizedBox(height: 10,),

                               Text('All Posts',
                                 style: TextStyle(
                                   color: Colors.black,
                                   fontWeight: FontWeight.bold,


                                 ),
                               ),
                               Padding(padding: const EdgeInsets.all(8.0),
                                 child: Consumer <ProfileViewModel>(
                                     builder: (context, viewModel, child) {
                                       final posts = viewModel.userPosts;
                                       if(posts.isEmpty) {
                                         return Center(child: Text('No posts yet'),);
                                       }

                                       return MasonryGridView.count(
                                           crossAxisCount: 2,
                                           mainAxisSpacing: 8,
                                           crossAxisSpacing: 8,
                                           shrinkWrap: true,
                                           physics: NeverScrollableScrollPhysics(),
                                           itemCount: posts.length,
                                           itemBuilder: (context, index) {
                                             final post = posts[index];

                                             return GestureDetector(
                                               onTap: () {
                                                 NavigationHelper.nextPage(context, ListPosts(post: posts, initialIndex: index,));
                                               },

                                               child: ClipRRect(
                                                 borderRadius: BorderRadius.circular(12),
                                                 child: Image.network(
                                                   post.mediaUrl ?? '',
                                                   fit: BoxFit.cover,
                                                   errorBuilder:  (context, error, stackTrace) {
                                                     return Center(child: Icon(Icons.broken_image));
                                                   }
                                                 ),
                                               ),
                                             );

                                           }
                                       );
                                     }
                                 )
                               )

    ],
    ),




    ),
    );


  }
}

/*


 */