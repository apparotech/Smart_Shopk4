
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:smart_shopk4/Model/postModel.dart';
import 'package:smart_shopk4/Pages/Components/CustomCard.dart';
import 'package:smart_shopk4/Pages/feeds/view_image.dart';
import 'package:smart_shopk4/services/post_service.dart';
import 'package:smart_shopk4/utils/firebase.dart';


class UserPost extends StatelessWidget {

  final PostModel? post;

   UserPost({super.key, this.post});

  final DateTime timestamp = DateTime.now();


  currentUserId() {
    return firebaseAuth.currentUser!.uid;
  }


  final PostService service = PostService();
  @override
  Widget build(BuildContext context) {
    return CustomCard(
        child: OpenContainer(
          transitionType: ContainerTransitionType.fadeThrough,
            openBuilder: (BuildContext context, VoidCallback _) {
                return ViewImage(post: post,);
            },
            closedElevation: 0.0,
          closedShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10)
            )
          ),
          onClosed: (v) {},
          closedColor: Theme.of(context).cardColor,
          closedBuilder: (BuildContext context, VoidCallback opencontainer) {

            return Stack(
              children: [
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                      child: Image.network(post?.mediaUrl ?? '',)
                    ),


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
}
