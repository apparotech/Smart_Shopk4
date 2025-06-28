import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:smart_shopk4/Pages/Components/fab_container.dart';
import 'package:smart_shopk4/Pages/Notifiaction_Page/Notification_page.dart';
import 'package:smart_shopk4/Pages/Profile_Page/ProfilePage.dart';
import 'package:smart_shopk4/Pages/const/Colors/AppColor.dart';
import 'package:smart_shopk4/Pages/feeds/feeds.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}



class _TabScreenState extends State<TabScreen> {

  int _page =0;
  List pages = [
    {
      'title' : 'Home',
      'icon' :   Ionicons.home,
       'page' : Feeds(),
      'index' : 0,


    },
    {
      'title' : 'Search',
      'icon': Ionicons.search,
      'page': ProfilePage(),
      'index': 1,

    },
    {
      'title': 'unsee',
      'icon': Ionicons.add_circle,
      'page': Text('nes'),
      'index': 2,
    },
    {
      'title': 'Notification',
      'icon': Ionicons.notifications,
     'page':   NotificationPage(),
      'index': 3,
    },

    {
      'title': 'Profile',
      'icon': Ionicons.person,
      'page': ProfilePage(),
      'index': 4,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageTransitionSwitcher(
            transitionBuilder: (
                Widget child,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
            ) {
              return FadeThroughTransition(
                  animation: animation,
                  secondaryAnimation: secondaryAnimation,
                  child: child,
              );
            },
          child: pages[_page]['page'],
        ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 5,),
            for(Map item in pages)
              item['index'] == 2?
                  buildFab()
                  :Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                child: IconButton(

                    onPressed: ()  => navigationTapped(item['index'])
                    , icon: Icon(
                  item['icon'],
                      color: item['index'] != _page?

                   Colors.black
                          : AppColors.primaryBlue500,
                      //Theme.of(context).colorScheme.secondary,
                  size: 25.0,
                )
                ),
              ),
            SizedBox(width: 5,)
          ],
        ),
      ),
    );
  }
  buildFab() {
    return Container(
      height: 45.0,
      width: 45.0,


      child: FabContainer(
          icon: Ionicons.add_outline,
        page: pages[2]['page'],
        mini: true,
      )
    );
  }
  void navigationTapped(int page) {
    setState(() {
      _page = page;
    });
  }
}
