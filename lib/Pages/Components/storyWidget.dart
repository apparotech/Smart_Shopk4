
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_shopk4/Model/UserModel.dart';
import 'package:smart_shopk4/Model/storyModel.dart';
import 'package:smart_shopk4/Pages/const/Colors/AppColor.dart';
import 'package:smart_shopk4/utils/firebase.dart';

class StoryWidget extends StatelessWidget {
  const StoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      child: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: StreamBuilder<QuerySnapshot>(
              stream: userChatsStream('${firebaseAuth.currentUser!.uid}'),
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  List chatList = snapshot.data!.docs;
                  if(chatList.isNotEmpty) {
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                        itemCount: chatList.length,
                        scrollDirection: Axis.horizontal,
                        physics: AlwaysScrollableScrollPhysics(),

                        itemBuilder: (BuildContext context, int index) {
                        DocumentSnapshot statusListSnapshot = chatList[index];
                        return StreamBuilder<QuerySnapshot>(
                            stream: messageListStream(statusListSnapshot.id),

                             builder: (context, snapshot) {
                              if(snapshot.hasData) {
                                List statuses = snapshot.data!.docs;
                                StoryModel storyModel = StoryModel.fromJson(
                                  statuses.first.data(),
                                );
                                List users = statusListSnapshot.get('whoCanSee');

                                users.remove('${firebaseAuth.currentUser!.uid}');

                                return _buildStatusAvatar(
                                    statusListSnapshot.get('userId'),
                                    statusListSnapshot.id,
                                    storyModel.statusId!,

                                     index);
                                
                              } else {
                                return const SizedBox();
                              }
                             }
                        );
                        }

                    );
                  } else {
                    return Center(
                      child: Text(
                        'No Status',
                      ),
                    );
                  }
                } else {
                  return CircularProgressIndicator();
                }
              }
          ),

      ),
    );
  }

  _buildStatusAvatar(
      String? userId,
      String? chatId,
      String? messageId,
      int?  index,

      ) {
    return StreamBuilder(
        stream: userRef.doc('$userId').snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            DocumentSnapshot documentSnapshot = snapshot.data as DocumentSnapshot<Object?>;
            UserModel  user = UserModel.fromJson(
              documentSnapshot.data() as Map<String, dynamic>,

            );

            return Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {

                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.transparent,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            offset: new Offset(0.0, 0.0),
                            blurRadius: 2.0,
                            spreadRadius: 0.0,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: CircleAvatar(
                          radius: 35.0,
                          backgroundColor: Colors.grey,
                          backgroundImage: CachedNetworkImageProvider(
                            user.photoUri!,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    user.userName!,
                    style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            );
          } else {
            return const SizedBox();

          }
        }
    );


  }

  Stream<QuerySnapshot> userChatsStream(String uid) {
    return
      statusRef
          .where('whoCanSee', arrayContains: '$uid')
          .snapshots();

  }

  Stream<QuerySnapshot>  messageListStream(String documentId) {
    return 
      statusRef
          .doc(documentId)
          .collection('statuses')
          .snapshots();
  }
}
