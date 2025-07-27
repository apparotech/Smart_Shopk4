

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

typedef ItemBuilder<T> = Widget Function(
    BuildContext context,
    DocumentSnapshot doc,
    );

class CommentsStreamWrapper extends StatelessWidget {
  final Stream<QuerySnapshot<Object?>>? stream; // stream → Firestore se live data laata hai.
  final ItemBuilder<DocumentSnapshot> itemBuilder; //  itemBuilder → Us data ko screen pe dikhane layak widget banata hai.
  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics physics;
  final EdgeInsets padding;

  const CommentsStreamWrapper({
    super.key,
    required this.stream,
    required this.itemBuilder,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics = const ClampingScrollPhysics(),
    this.padding = const EdgeInsets.only(bottom: 2.0, left: 2.0),

  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: stream,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            var  list = snapshot.data!.docs.toList();
            return list.length ==0
                ? Container(
              child: Center(
                child: Padding(padding: const EdgeInsets.only(top: 20.0),
                  child: Text('No comments'),

                ),

              ),
            )
                : ListView.separated(
                //itemBuilder: itemBuilder
                separatorBuilder: (BuildContext context, int index) {
                  return Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Container(
                        height: 0.5,
                        width: MediaQuery.of(context).size.width,
                        child: const Divider(),

                      ),
                    ),

                  );
                },
              reverse: true,
              padding: padding,
              scrollDirection: scrollDirection,
              itemCount: list.length,
              shrinkWrap: shrinkWrap,
              physics: physics,
              itemBuilder: (context, index) {
                  return itemBuilder(context, list[index]);
              },

            );


          } else {
            return Center(child:CircularProgressIndicator());
          }
        }
    );
  }
}
