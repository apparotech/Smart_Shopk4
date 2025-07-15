import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({super.key});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);

          },
          child: Icon(CupertinoIcons.xmark_circle_fill),


        ),
        centerTitle: true,
        title: Text('Comments'),

      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Flexible(
                child: ListView(
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    )
                  ],
                )
            )
          ],
        ),
      ),
    );
  }

  buildFullPost() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment:  MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 350.0,
              width: MediaQuery.of(context).size.width - 20.0,
              child: Image.asset('assets/Homepage/profile.jpg')
            ),
           Padding(padding: const EdgeInsets.all(8.0),
             child: Row(
               children: [
                 Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(
                       'raj kumar....',
                       style: TextStyle(
                         fontWeight: FontWeight.w800,
                       ),
                     ),
                     SizedBox(height: 4,),
                     Row(
                       
                     )
                   ],
                 )
               ],
             ),
           )

          ],
    );
  }
}
