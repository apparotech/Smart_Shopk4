import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 23,
              backgroundImage: AssetImage('assets/Homepage/pic_pass.jpg'),
            ),
            SizedBox(width: 20,),
            Text("Smart shop",
              style: TextStyle(color: Colors.black,
              fontSize:  22,
              fontWeight: FontWeight.bold),
            )
          ],
        ),
        actions: [
          IconButton(onPressed: () {},
              icon: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Icon(Icons.search, size: 35,
                ),
              )
          )
        ],

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                
              ),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey[300],
                backgroundImage:  AssetImage('assets/Homepage/pic_pass.jpg'),
              ),
              
            ),
            SizedBox(height: 5,),
            
            Text('raj',  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),

            
          ],
        ),
      )
    );
  }
}
