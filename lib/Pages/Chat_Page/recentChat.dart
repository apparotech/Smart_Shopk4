import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_shopk4/utils/firebase.dart';
import 'package:smart_shopk4/view_model/ChatViewModel/ChatViewModel.dart';

class RecentChat extends StatelessWidget {
  const RecentChat({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ChatViewModel>(context, listen: false);
    viewModel.setUser();
    return Scaffold(
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
          builder: (context, snapshot) {

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
