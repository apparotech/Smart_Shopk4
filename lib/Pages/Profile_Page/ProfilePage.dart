import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_shopk4/Model/UserModel.dart';
import 'package:smart_shopk4/Pages/Components/Buttons/customButton.dart';
import 'package:smart_shopk4/Pages/Components/Buttons/menuButton.dart';
import 'package:smart_shopk4/Pages/Components/Naviagation_Page/Navigation_page.dart';
import 'package:smart_shopk4/Pages/EditProfile/EditProfile.dart';
import 'package:smart_shopk4/Pages/Home_Page/Home_Page.dart';
import 'package:smart_shopk4/Pages/Notifiaction_Page/Notification_page.dart';
import 'package:smart_shopk4/Pages/Parterns/Parterns.dart';
import 'package:smart_shopk4/Pages/const/Colors/AppColor.dart';
import 'package:smart_shopk4/utils/firebase.dart';
import 'package:smart_shopk4/view_model/ProfileViewModel/ProfileViewModel.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<ProfileViewModel>(context, listen:  false).fetchUser()
    );
  }
  @override
  Widget build(BuildContext context) {
    final profileViewModel = Provider.of<ProfileViewModel>(context);
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(profileViewModel.user?.userName ??" loading", style: TextStyle(color: Colors.purple,

        fontWeight: FontWeight.bold),),
                  actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                  child: Icon(Icons.search, size: 40,color: Colors.black45,),
    )
    ],

    ),
                body: SingleChildScrollView(
                           child: Column(
                             children: [
                              Container(
                             height: 250,
                               width: 410,

                        decoration: BoxDecoration(
    // color: Colors.purple,
                           image: DecorationImage(
                       image: AssetImage("assets/Homepage/profile.jpg"),
                           fit: BoxFit.cover
      ),
                      boxShadow: [
                      BoxShadow(
                        color: Colors.black45,
                        blurRadius: 10,
                         spreadRadius: 2
    )
    ]
    ),
    ),

                            Padding(padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
                                   child: Text(
    "Providing quality medicines and healthcare\nproducts with and care for your well-beings",

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
    onTap: () {}
    ),
    //SizedBox(width: 80),
              customButton(
    icon: Icons.edit,
    text:  'Edit Profile',
    onTap: () {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => EditProfile())

    );
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

    // Vertical Divider
    Container(
    height: 30,
    width: 1,
    color: Colors.grey.shade400,
    ),

    // Followers
    InkWell(
    onTap: () {},

    child: Column(
         mainAxisSize: MainAxisSize.min,
    children: [
            Text('1',
          style: TextStyle(
         fontWeight: FontWeight.bold,
          fontSize: 16,
    ),
    ),
           SizedBox(height: 4,),
              Text('FOLLOWING',
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
             Text('1',
            style: TextStyle(
           fontWeight: FontWeight.bold,
            fontSize: 16,
    ),
    ),
                SizedBox(height: 4,),
                    Text('FOLLOWERS',
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
    Padding(padding: const EdgeInsets.only(top: 20) ,
    child: Row(

    children: [

    Column(
    children: [
    Container(
    width: 200,
    height: 200,
    decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage("assets/Homepage/shoes.jpg"),
    fit: BoxFit.cover
    )

    ),
    ),
    Text("REDTAPE", style:
    TextStyle(color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 15
    ),),
    Text("Casual Sneaker Shoes",
    style: TextStyle(color: Colors.black,


    ),
    ),
    Row(
    children: [
    Icon(Icons.currency_rupee),

    Text("399 "),
    Icon(Icons.local_offer),
    Text("8%"),

    ],
    ),
    Row(
    children: [
    Icon(Icons.star, color: Colors.yellow,),
    Icon(Icons.star,color: Colors.yellow,),
    Icon(Icons.star, color: Colors.yellow,),
    Icon(Icons.star, color: Colors.yellow,),

    ],
    )
    ],
    ),
    SizedBox( width: 10,),

    Column(
    children: [
    Container(
    width: 200,
    height: 200,
    decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage("assets/Homepage/shoes.jpg"),
    fit: BoxFit.cover
    )

    ),
    ),
    Text("REDTAPE", style:
    TextStyle(color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 15
    ),),
    Text("Casual Sneaker Shoes",
    style: TextStyle(color: Colors.black,


    ),
    ),
    Row(
    children: [
    Icon(Icons.currency_rupee),

    Text("399 "),
    Icon(Icons.local_offer),
    Text("8%"),

    ],
    ),
    Row(
    children: [
    Icon(Icons.star, color: Colors.yellow,),
    Icon(Icons.star,color: Colors.yellow,),
    Icon(Icons.star, color: Colors.yellow,),
    Icon(Icons.star, color: Colors.yellow,),

    ],
    )
    ],
    ),


    ],

    ),
    )

    ],
    ),
    )
    );
  }
}

