import 'package:flutter/material.dart';
class Editprofile extends StatefulWidget {
  const Editprofile({super.key});

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(
        centerTitle: true,
        title: Text(
          'Edit Profile',
          style: TextStyle(color: Colors.purple,

          ),

        ),

      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 7),
                  child: Text(
                    "Profile Picture",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold

                    ),
                  ),
                ),

                SizedBox(width: 200,),
                TextButton(
                    onPressed: () {} ,
                    child: Text("Edit", style:
                      TextStyle(

                        color: Colors.purple,

                      ),)
                )
              ],

            ),

            SizedBox(height: 5,),
            Container(
              height: 200,
              width: 400,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/Homepage/profile.jpg'),
                  fit: BoxFit.cover
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 2
                      ,
                    spreadRadius: 5,
                    offset: Offset(2, 2)
                  ),
                ]
              ),
            ),

            SizedBox(height: 30,),
            Divider(
              color: Colors.black,
              thickness: 1,
            ),

            SizedBox(height: 5,),

            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Bio',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),
                  ),

                ),

                SizedBox(width: 320,),
                Text('Edit', style:
                  TextStyle(
                    color: Colors.purple
                  )
                  ),




              ],


            ),

            Center(
              child: Text(
                  'Deccribe Yourself...'
              ),
            ),

            SizedBox(
              height: 20,
            ),

            Divider(
              thickness: 1,
              color: Colors.black,
            ),

            SizedBox(height: 10,),

            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Details',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,

                    ),
                  ),
                ),

                SizedBox(width: 300,),
               Text(
                 'Edit',
                 style: TextStyle(
                   color: Colors.purple,

                 ),
               )



              ],


            ),

            SizedBox(height: 50,),
            Divider(
              thickness: 1,
              color: Colors.black,
            ),


            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Links',

                    style: TextStyle(color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),


                  ),
                ),

                SizedBox(width: 320,),
                Text(
                  'Edit',
                  style: TextStyle(
                    color: Colors.purple,

                  ),
                )

              ],

            )



          ],
        ),
      ),
    );
  }
}
