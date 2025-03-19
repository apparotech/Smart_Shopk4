import 'package:flutter/material.dart';
import 'package:smart_shopk4/Pages/Components/Buttons/customButton.dart';
import 'package:smart_shopk4/Pages/Components/Naviagation_Page/Navigation_page.dart';
import 'package:smart_shopk4/Pages/EditProfile/EditProfile.dart';
import 'package:smart_shopk4/Pages/Home_Page/Home_Page.dart';
import 'package:smart_shopk4/Pages/Notifiaction_Page/Notification_page.dart';
import 'package:smart_shopk4/Pages/Parterns/Parterns.dart';

class Profilepage extends StatelessWidget {
  const Profilepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Raj shop", style: TextStyle(color: Colors.purple,
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
                    padding: const EdgeInsets.only(top: 20, left: 15),

                  child: Row(
                    children: [
                      customButton(
                          icon: Icons.add_circle_outline,
                          text: "Add Product",
                          onTap: () {}
                      ),
                      SizedBox(width: 80),
                       customButton(
                           icon: Icons.edit,
                           text:  'Edit Profile',
                           onTap: () {
                             Navigator.push(
                                 context,
                                 MaterialPageRoute(builder: (context) => Editprofile())

                             );
                           }
                       )
                    ],

                  ),
                ),
                Padding(padding: const EdgeInsets.only(top: 20, left: 10, right: 10),

                  child: customButton(
                      icon: Icons.location_on,
                      text: "Silchar, Assam, India,80024",
                      onTap: () {}
                  ),
                ),
                Padding(padding: const EdgeInsets.only(top: 20),
                  child: Divider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                ),
                Padding(padding: const EdgeInsets.only(top: 1, left: 40),
                  child: Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 10,
                            shadowColor: Colors.black54,
                          backgroundColor: Colors.purple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          )
                        ),
                          onPressed:(){
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => HomePage())

                            );
                          } ,
                          child: Text
                            ("Product", style:
                            TextStyle(color: Colors.white,),
                          )),

                      SizedBox(width: 130,),
                      ElevatedButton(
                          onPressed: () {
                            GotoPage(anotherPage: NotificationPage(), context: context);

                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 10,
                            shadowColor: Colors.black54,
                            backgroundColor: Colors.purple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),

                            )
                          ),
                          child: Text("Partners" , style: TextStyle(
                            color: Colors.white,
                          ),)
                      )
                    ],
                  ),

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
      ),
    );
  }
}
