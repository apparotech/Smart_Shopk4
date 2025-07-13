
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_shopk4/Model/message.dart';
import 'package:smart_shopk4/services/chatService.dart';

class ChatViewModel extends ChangeNotifier {

  ChatService chatService = ChatService();

  sendMessage(String chaiId, Message message) {
    chatService.sendMessage(message, chaiId);
  }


  Future<String> sendFirstMessage(String recipient, Message message) async {
    String newChatId = await chatService.sendFirstMessage(message, recipient);

    return newChatId;
  }

  setReadCount(String chatId, var user, int count) {
    chatService.setUserRead(chatId, user, count);
  }

  setUserTyping(String chatId, var user, bool typing) {
    chatService.setUserTyping(chatId, user, typing);
  }

  User?  user;
  FirebaseAuth auth = FirebaseAuth.instance;

  setUser()   {
    user = auth.currentUser;
    notifyListeners();
  }

}