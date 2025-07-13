import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class Follow extends StatefulWidget {
  const Follow({super.key});

  @override
  State<Follow> createState() => _FollowState();
}

class _FollowState extends State<Follow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        elevation: 3,

        leading: IconButton(
            onPressed: () {} ,
            icon: Icon(Ionicons.chevron_back),
        ),
        title:
          Center(
            child: Row(
             // crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                CircleAvatar(

                backgroundImage: NetworkImage('https://your-image-url.com'),
              ),

                const SizedBox(width: 10,),
                const Text(
                  'username',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),
                )

              ],
            ),
          ),
        ),
      body: ListView.builder(
          padding: const EdgeInsets.all(10),
             itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(''),
                  ),

                  SizedBox(width: 12,),
                  Expanded(
                      child: Text(
                        'raj',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      )
                  ),
                  OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)
                        ),
                        side: BorderSide(color: Colors.black54)
                      ),
                      child:Text(
                        'Following',
                        style: TextStyle(color: Colors.black),
                      )
                  ),
                  IconButton(onPressed: () {}, 
                      icon: Icon(Icons.more_vert)
                  )
                ],
              ),
            );
          }
      )





    );
  }
}
