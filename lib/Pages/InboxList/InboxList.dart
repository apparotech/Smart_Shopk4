import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class Inboxlist extends StatelessWidget {
  const Inboxlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 5,
        centerTitle: true,
        title: Text(
          "chats",
          style: TextStyle(
            color: Colors.purple,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: SearchBar(
                constraints: BoxConstraints(
                  maxWidth: 350, // Maximum width
                  minHeight: 50, // Minimum height
                ),
                hintText: "Search...",
                leading: Icon(Icons.search),
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20,),
                  SizedBox(
                    height: 100,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        buildStoryItem(name: "Sally", imageUrl: "assets/Homepage/pic_pass.jpg", borderColor: Colors.purple),
                        buildStoryItem(name: "Jason", imageUrl: "assets/Homepage/pic_pass.jpg", borderColor: Colors.teal),
                        buildStoryItem(name: "Jena", imageUrl: "assets/Homepage/pic_pass.jpg", borderColor: Colors.pink),
                        buildStoryItem(name: "Michael", imageUrl: "assets/Homepage/pic_pass.jpg", borderColor: Colors.brown),
                        buildStoryItem(name: "Liam", imageUrl: "assets/Homepage/pic_pass.jpg", borderColor: Colors.grey),
                      ],
                    ),
                  ),

                  MessageList(name: "raj", image: "assets/Homepage/pic_pass.jpg",mesaage: "Hello raj how are u !", time: "11.00"),
                  MessageList(name: "raj", image: "assets/Homepage/pic_pass.jpg",mesaage: "Hello raj how are u !", time: "11.00"),
                  MessageList(name: "raj", image: "assets/Homepage/pic_pass.jpg",mesaage: "Hello raj how are u !", time: "11.00"),
                  MessageList(name: "raj", image: "assets/Homepage/pic_pass.jpg",mesaage: "Hello raj how are u !", time: "11.00"),
                  MessageList(name: "raj", image: "assets/Homepage/pic_pass.jpg",mesaage: "Hello raj how are u !", time: "11.00"),
                  MessageList(name: "raj", image: "assets/Homepage/pic_pass.jpg",mesaage: "Hello raj how are u !", time: "11.00"),
                  MessageList(name: "raj", image: "assets/Homepage/pic_pass.jpg",mesaage: "Hello raj how are u !", time: "11.00"),
                  MessageList(name: "raj", image: "assets/Homepage/pic_pass.jpg",mesaage: "Hello raj how are u !", time: "11.00"),



                ],
              ),

            ),
          ],
        ),
      ),
    );
  }
}


/*
 child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey,
                  child: Row(
                    children: List.generate(
                      6,
                          (index) => Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.purple,
                            ),
                          ],
                        ),
                      ),
                    ), // **✅ Properly closed**
                  ),
                ),
 */

Widget buildStoryItem( {String? name, String? imageUrl, Color borderColor = Colors.grey, })  {
  return Padding(
  padding:   const EdgeInsets.symmetric(horizontal: 8.0),
       child: Column(
         children: [
           Stack(
             alignment: Alignment.center,
             children: [
               Container(
                 decoration: BoxDecoration(
                   shape: BoxShape.circle,
                   border: Border.all(color: Colors.purple , width: 3)
                 ),
                 child: CircleAvatar(
                   radius: 30,
                   backgroundColor: Colors.white,
                   child: ClipOval(
                     child: Image.asset(
                       imageUrl!,
                       width: 60,
                       height: 60,
                       fit: BoxFit.cover,
                     ),
                   ),
                 ),
               ),


             ],
           ),
           const SizedBox(
             height: 5,
             
           ),
           Text(name! , style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),


         ],
       ),
  );
}

Widget MessageList( {String? name, String? image, String? mesaage, String? time}) {

   return Padding(
       padding:  const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
     child:Row(
       crossAxisAlignment: CrossAxisAlignment.center,
       children: [
         Stack(
           children: [
             CircleAvatar(
               radius: 25,
               backgroundImage: AssetImage(image!),
             ),
             Positioned(
               bottom: 3,
                 right: 3,
                 child: CircleAvatar(
                   radius: 6,
                   backgroundColor: Colors.white,
                   child: CircleAvatar(
                     radius: 5,
                     backgroundColor: Colors.green,
                   ),
                 )

             )

           ],
         ),
         const SizedBox(width: 10,),

         Expanded(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,

               children: [
                 Text(name!,
                   style: const TextStyle(
                     color: Colors.black,
                     fontWeight: FontWeight.bold,
                     fontSize: 16,
                   ),
                 ),

                  const SizedBox(height: 3),

                 Text(
                   mesaage!,
                   style: TextStyle(
                     color: Colors.grey.shade600,
                     fontSize: 14,
                   ),
                   overflow: TextOverflow.ellipsis,
                 )
               ],
             )

         ),

         Column(
           children: [
             Text(
               time!,
               style: const TextStyle(
                 color: Colors.grey,
                 fontSize: 12,
               ),
             )
           ],
         )

       ],

     )
     );


}



