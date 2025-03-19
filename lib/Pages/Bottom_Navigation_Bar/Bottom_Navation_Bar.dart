import 'dart:convert';

import 'package:flutter/material.dart';
class Bottom_NavationBar extends StatefulWidget {
  const Bottom_NavationBar({super.key});

  @override
  State<Bottom_NavationBar> createState() => _Bottom_NavationBarState();
}

class _Bottom_NavationBarState extends State<Bottom_NavationBar> {

  int _selectedIndex =0;

  static List<Widget> _pages = <Widget> [
   // Center(child: Text('Home', style: TextStyle(fontSize: 24),),),
   // Center(child: Text('Search Page', style: TextStyle(fontSize: 24))),
   //// Center(child: Text('Profile Page', style: TextStyle(fontSize: 24))),
   // Center(child: Text('Search Page', style: TextStyle(fontSize: 24))),
   // Center(child: Text('Profile Page', style: TextStyle(fontSize: 24))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items:  const[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
            label: 'Home'
          ),

          BottomNavigationBarItem(
              icon:  Icon(Icons.search),
             label: 'Search',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
            label: 'Notification'
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.video_collection),
            label: "Rell",

          ),

        ],

        selectedItemColor: Colors.blue, // Color of selected item
        unselectedItemColor: Colors.grey, // Color of unselected items
        showUnselectedLabels: true,

      ),
    );
  }
}
