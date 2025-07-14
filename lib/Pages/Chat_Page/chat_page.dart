import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:smart_shopk4/Model/enum/message_type.dart';
import 'package:smart_shopk4/Pages/Components/chatBubble.dart';
import 'package:smart_shopk4/Pages/const/Colors/AppColor.dart';
import 'package:smart_shopk4/utils/firebase.dart';
import 'package:smart_shopk4/view_model/ChatViewModel/ChatViewModel.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../Model/UserModel.dart';
import '../../Model/message.dart';
import '../../view_model/ChatViewModel/UserViewModel.dart';
class ChatPage extends StatefulWidget {
 final String  userId;
 final String chatId;

  const ChatPage({
    super.key,
     required this.userId,
     required this.chatId

  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}



class _ChatPageState extends State<ChatPage> {
  FocusNode focusNode = FocusNode();
  ScrollController scrollController = ScrollController();
  TextEditingController messageController = TextEditingController();
  bool isFirst = false;
  String? chatId;
  setTyping(bool typing) {
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    final chatViewModel = Provider.of<ChatViewModel>(context, listen: false);

    final user = userViewModel.user;
    if (user != null) {
      chatViewModel.setUserTyping(widget.chatId, user, typing);
    }
  }

  @override
  void initState() {
    super.initState();
      Future.microtask(() {
        Provider.of<UserViewModel>(context, listen:  false).setUser();
      });
    scrollController.addListener(() {
      focusNode.unfocus();
    });
    if (widget.chatId == 'newChat') {
      isFirst = true;
    }
    chatId = widget.chatId;

    messageController.addListener(() {
      if (focusNode.hasFocus && messageController.text.isNotEmpty) {
        setTyping(true);
      } else if (!focusNode.hasFocus ||
          (focusNode.hasFocus && messageController.text.isEmpty)) {
        setTyping(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var user =Provider.of<UserViewModel>(context, listen: true).user;
    return Consumer<ChatViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
             leading: GestureDetector(
               onTap: () {
                 Navigator.pop(context);
               },
               child: Icon(
                 Icons.keyboard_backspace
               ),
             ),
              elevation: 0.0,
              titleSpacing: 0,
              title: buildUserName(),
            ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Flexible(
                      child: StreamBuilder(
                          stream: messageListStream(widget.chatId),
                          builder: (context, snapshot) {
                            if(snapshot.hasData) {
                              List messages = snapshot.data!.docs;
                              viewModel.setReadCount(
                                  widget.chatId,
                                  user,
                                messages.length,
                                  );
                              return ListView.builder(
                                controller: scrollController,
                                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                                  itemCount: messages.length,
                                  reverse: true,
                                  itemBuilder:(context, index) {
                                    Message message = Message.fromJson(
                                      messages.reversed.toList()[index].data(),
                                    );
                                   return ChatBubbleWidget(
                                     message: '${message.content}',
                                     time: message.time!,
                                     isMe: message.senderUid == user!.uid,
                                     type: message.type!,
                                   );

                                  }
                              );

                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          }
                      )
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: BottomAppBar(
                      elevation: 10.0,
                      child: Container(
                        constraints: BoxConstraints(maxHeight: 100.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  CupertinoIcons.photo_on_rectangle,
                                  color: AppColors.primaryBlue500
                                ),
                            ),
                            Flexible(
                                child: TextField(
                                  maxLines: null,
                                  controller: messageController,
                                  focusNode: focusNode,
                                  style: TextStyle(
                                    fontSize: 15.0,

                                  ),

                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10.0),
                                    enabledBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    hintText: "Type your message",
                                    hintStyle: TextStyle(
                                     // color: Theme.of(context)

                                    ),
                                  )
                                  ,
                                )
                            ),
                            IconButton(
                                onPressed: () {
                                  if (messageController.text.isNotEmpty) {
                                    sendMessage(viewModel, user);
                                  }
                                } ,
                                icon: Icon(
                                  Ionicons.send,
                                      color: AppColors.primaryBlue500,
                                )
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
    );
      

  }


  buildUserName() {
    return StreamBuilder(
        stream: userRef.doc('${widget.userId}').snapshots(),
        builder: (context, snapshot) {

          if(snapshot.hasData) {
            DocumentSnapshot documentSnapshot =
            snapshot.data as DocumentSnapshot<Object?>;
            UserModel user = UserModel.fromJson(
              documentSnapshot.data() as Map<String, dynamic>,
            );

            return InkWell(
             child: Row(
               children: [
                 Padding(
                     padding: EdgeInsets.only(left: 10, right: 10),
                   child: Hero(
                       tag: user.email!,
                       child: user.photoUri!.isEmpty
                       ? CircleAvatar(
                         radius: 25.0,
                         backgroundColor:
                         AppColors.primaryBlue500,
                         child: Center(
                           child: Text(
                               "${user.userName![0].toUpperCase()}",
                             style: TextStyle(
                               color: Colors.white,
                               fontSize: 15.0,
                               fontWeight: FontWeight.w900
                             ),
                           ),
                         ),
                       )
                           : CircleAvatar(
                         radius: 25,
                         backgroundImage: NetworkImage(
                           '${user.photoUri}'
                         ),
                       )
                   ),
                 ),
                 SizedBox(width: 10.0,),
                 Expanded(
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(
                           '${user.userName}',
                           style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 15.0
                           ),

                         ),
                         SizedBox(height: 5,),
                         StreamBuilder(
                             stream: chatRef.doc('${widget.chatId}').snapshots(),
                             builder: (context, snapshot) {

                               if(snapshot.hasData) {
                                 DocumentSnapshot? snap =
                                 snapshot.data as DocumentSnapshot<Object?>;
                                 Map? data = snap.data() as Map<dynamic, dynamic>?;
                                // Map? usersTyping = data?['typing'] ?? {};
                                 bool isTyping = (data?['typing'] ?? {})[widget.userId] == true;
                                 return Text(
                                   _buildOnlineText(
                                       user,
                                       isTyping
                                   ),
                                   style: TextStyle(
                                     fontWeight: FontWeight.w400,
                                     fontSize: 11,
                                   ),
                                 );
                               } else{
                                 return SizedBox();
                               }
                             }
                         )

                       ],
                     )
                 )
               ],
             ),
            );

          } else {
            return Center(child: CircularProgressIndicator());
          }
        }
    );
  }
  String _buildOnlineText(UserModel user, bool typing) {
    if (user.isOnline == true) {
      return typing ? "typing..." : "online";
    } else {
      if (user.lastSeen != null) {
        return 'last seen ${timeago.format(user.lastSeen!.toDate())}';
      } else {
        return 'offline';
      }
    }
  }

  Stream<QuerySnapshot> messageListStream(String documentId) {
    return chatRef
        .doc(documentId)
        .collection('messages')
        .orderBy('time')
        .snapshots();
  }

  sendMessage(ChatViewModel viewModel, var  user,

      )  async{
    String? msg = messageController.text;
    if(msg.trim().isNotEmpty) {
      Message message = Message(
        content: '$msg',
        senderUid: user.uid,
        type: MessageType.TEXT,
        time: Timestamp.now(),

      );
    }


      if(msg.isNotEmpty) {
        if(isFirst) {
          print('FIRST');
          String id = await viewModel.sendFirstMessage(widget.userId, message);
          setState(() {
            isFirst = false;
            chatId = id;

            chatIdRef.add({
              "users": getUser(firebaseAuth.currentUser!.uid, widget.userId),
              'chatId': id
            });

            viewModel.sendMessage(widget.chatId, message);
          });
          //update the reads to an empty map in other to avoid null value bug
          chatRef.doc(chatId).update({'reads': {}});
         //update the typing to an empty map in other to avoid null value bug
          chatRef.doc(chatId).update({'typing': {}});
        } else {
          viewModel.sendMessage(
            widget.chatId,
            message,
          );
        }

      }
  }

  String getUser(String user1, String user2) {
    user1 = user1.substring(0, 5);
    user2 = user2.substring(0, 5);
    List<String> list = [user1, user2];
    list.sort();
    var chatId = "${list[0]}-${list[1]}";
    return chatId;
  }

}


