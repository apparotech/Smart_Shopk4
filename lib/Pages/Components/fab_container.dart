import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_shopk4/Pages/HelperFunction/Navigation_Helper.dart';
import 'package:smart_shopk4/Pages/const/Colors/AppColor.dart';
import 'package:smart_shopk4/Pages/posts/create_posts.dart';

class FabContainer extends StatelessWidget {
  final Widget? page;
  final IconData icon;
  final bool mini;

  const FabContainer({this.page, required this.icon, this.mini = false});

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionType: ContainerTransitionType.fade,

        openBuilder: (BuildContext context, VoidCallback _) {
        return page!;

        },
      closedElevation: 4.0,
      closedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(56 /2),
        )
      ),
      closedColor: Theme.of(context).scaffoldBackgroundColor,
      closedBuilder: (BuildContext context, VoidCallback openContainer) {

        return FloatingActionButton(
          backgroundColor: AppColors.primaryBlue500,
            child: Icon(
              icon,
              color: Colors.white,
            ),
            onPressed: () {
            chooseUpload(context);
            },
          mini: mini,
        );
      },

        );
  }

  chooseUpload(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        return  Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.5,
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: ListView(
              shrinkWrap: true,
              children:  [
                Center(
                  child: Text(
                    'Choose Upload',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Icon(CupertinoIcons.camera),
                  title: Text('Make a post'),
                 onTap: () {
                   Navigator.pop(context);
                   NavigationHelper.nextPage(context, CreatePosts());
                 },
                ),
                ListTile(
                  leading: Icon(CupertinoIcons.photo),
                  title: Text('Add to story'),
                  onTap: () {},
                ),
              ],
            ),
          ),


        );
      },
    );
  }


}
