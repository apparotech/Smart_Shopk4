
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_shopk4/Model/enum/message_type.dart';
import 'package:smart_shopk4/Pages/const/Colors/AppColor.dart';
import 'package:smart_shopk4/utils/firebase.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../Model/UserModel.dart';
class ChatItem extends StatelessWidget {
  final String? userId;
  final Timestamp? time;
  final String? msg;
  final int? messageCount;
  final String? chatId;
  final MessageType? type;
  final String? currentUserId;


  const ChatItem({
    super.key,
     this.userId,
     this.time,
     this.msg,
     this.messageCount,
     this.chatId,
     this.type,
     this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: userRef.doc('$userId').snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            DocumentSnapshot documentSnapshot =
            snapshot.data as DocumentSnapshot<Object?>;
            UserModel user = UserModel.fromJson(
              documentSnapshot.data() as Map<String, dynamic>,
            );

            return ListTile(
              contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
              leading: Stack(
                children: [
                  user.photoUri == null || user.photoUri!.isEmpty
                  ? CircleAvatar(
                    radius: 25.0,
                    backgroundColor: AppColors.primaryBlue500,
                    child: Center(
                      child: Text(
                        '${user.userName![0].toUpperCase()}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  )
                      :CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(
                      '${user.photoUri}'
                    ),
                  ),

                  Positioned(
                    bottom: 0.0,
                    right: 0.0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      height: 15,
                      width: 15,
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: user.isOnline ?? false
                                ? Color(0xff00d72f)
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          height: 11,
                          width: 11,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              title: Text(
          '${user.userName}',
          maxLines: 1,
          style: TextStyle(
          fontWeight: FontWeight.bold,
              ),
            ),
          subtitle: Text(
          type == MessageType.IMAGE ? "IMAGE" : "$msg",
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          ),

          trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
          SizedBox(height: 10),
          Text(
          "${timeago.format(time!.toDate())}",
          style: TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 11,
          ),
          ),
          SizedBox(height: 5),
          buildCounter(context),
          ],
          ),
          onTap: () {

          },
            );
          } else {
            return SizedBox();
          }
        }
    );
  }

  buildCounter(BuildContext context) {
    return StreamBuilder(
      stream: messageBodyStream(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          DocumentSnapshot snap = snapshot.data;
          final bool hasScore = snapshot.data!.data()!.containsKey('reads');
          Map usersReads = hasScore ? snap.get('reads') ?? {} : {};
          int readCount = usersReads[currentUserId] ?? 0;
          int counter = messageCount! - readCount;
          if (counter == 0) {
            return SizedBox();
          } else {
            return Container(
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(6),
              ),
              constraints: BoxConstraints(
                minWidth: 11,
                minHeight: 11,
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 1, left: 5, right: 5),
                child: Text(
                  "$counter",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
        } else {
          return SizedBox();
        }
      },
    );
  }


  Stream<DocumentSnapshot> messageBodyStream() {
    return chatRef.doc(chatId).snapshots();
  }
}
