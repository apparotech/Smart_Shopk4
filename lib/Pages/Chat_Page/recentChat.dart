import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_shopk4/Model/message.dart';
import 'package:smart_shopk4/Pages/Components/ChatItem.dart';
import 'package:smart_shopk4/utils/firebase.dart';
import 'package:smart_shopk4/view_model/ChatViewModel/ChatViewModel.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RecentChat extends StatefulWidget {
  const RecentChat({super.key});

  @override
  State<RecentChat> createState() => _RecentChatState();
}

class _RecentChatState extends State<RecentChat> {

  void initState (){
    super.initState();


    // Ensure user is set before build
    Future.microtask(() {
      Provider.of<ChatViewModel>(context, listen: false).setUser();
    });
}

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ChatViewModel>(context);

     if(viewModel.user == null) {
       return Scaffold(
         appBar: AppBar(
           title: Text("Chats"),
         ),
         body: Center(
           child: CircularProgressIndicator(),
         ),
       );
     }
    return


      Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
              Navigator.pop(context);
          },
          child: Icon(Icons.keyboard_backspace),
        ),
        title: Text('chats'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: userChatsStream('${viewModel.user!.uid ?? ""}'),
          builder: (context, snapshot){
            if(snapshot.hasData) {
              List chatList = snapshot.data!.docs;
              if(chatList.isNotEmpty) {
                return ListView.separated(

                    itemCount: chatList.length,
                  itemBuilder: (context, index) {
                      DocumentSnapshot chatListSnapshot = chatList[index];
                      return StreamBuilder<QuerySnapshot>
                        (
                          stream: messageListStream(chatListSnapshot.id),

                          builder: (context, snapshot) {
                            if(snapshot.hasData) {
                              List messages = snapshot.data!.docs;
                              Message message = Message.fromJson(
                                messages.first.data(),
                              );

                              List users = chatListSnapshot.get('users');
                              users.remove('${viewModel.user!.uid ?? ""}');
                              String recipient = users[0];
                              return ChatItem(
                                userId: recipient,
                                messageCount: messages.length,
                                msg: message.content,
                                time: message.time!,
                                chatId: chatListSnapshot.id,
                                type: message.type,
                                  currentUserId: viewModel.user!.uid ?? " ",

                              );
                            } else {
                              return SizedBox();
                            }
                          }
                      );
                  },
                  separatorBuilder: (context, index) {
                      return Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          height: 0.5,
                          width: MediaQuery.of(context).size.width /1.3,
                          child: Divider(),
                        ),
                      );
                  }
                );
              } else {
                return Center(child: Text('No Chats'));
              }
            }  else {
              return   Center(
                child: SpinKitFadingCircle(
                  size: 40.0,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              );
            }
          }
      ) ,
    );
  }
  Stream<QuerySnapshot> userChatsStream(String  uid) {
    return chatRef
        .where('users', arrayContains: '$uid')
        .orderBy('lastTextTime', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot> messageListStream(String documentId) {
    return chatRef
        .doc(documentId)
        .collection('messages')
        .orderBy('time', descending: true)
        .snapshots();
  }
}
