
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_shopk4/Model/message.dart';
import 'package:smart_shopk4/utils/firebase.dart';

class ChatService {

  sendMessage(Message message, String chatId) async  {
    //will send message to chats collection with the usersId
    await chatRef.doc("$chatId").collection('messages').add(message.toJson());

    //will update "lastTextTime" to the last time a text was sent
    await chatRef.doc("$chatId").update({'lastTextTime' : Timestamp.now()});

  }



  Future<String> sendFirstMessage(Message message, String recipient) async {
    User user =  firebaseAuth.currentUser!;
    DocumentReference ref = await chatRef.add({
      'users' : [recipient, user.uid],
    });

    await sendMessage(message, ref.id);
    return ref.id;

  }

//determine if a user has read a chat and updates how many messages are unread
  /*
  setUserRead(String chatId, User user, int count) async {
    DocumentSnapshot snap = await chatRef.doc(chatId).get();

    if(!snap.exists) {
      await chatRef.doc(chatId).set({
        'reads' : {user.uid: count},

      }, SetOptions(merge: true)
      );
      return;
    }
    Map reads = snap.get('reads') ?? {};
    reads[user.uid] = count;
    await chatRef.doc(chatId).update({'reads' : reads});
  }

   */

  setUserRead(String chatId, User user, int count) async {
    DocumentSnapshot snap = await chatRef.doc(chatId).get();

    if (!snap.exists || !(snap.data() as Map).containsKey('reads')) {
      await chatRef.doc(chatId).set({
        'reads': {user.uid: count},
      }, SetOptions(merge: true));
      return;
    }

    Map reads = snap.get('reads') ?? {};
    reads[user.uid] = count;

    await chatRef.doc(chatId).update({'reads': reads});
  }


//determine when a user has start typing a message
  setUserTyping(String chatId, User user, bool userTyping) async {
    DocumentSnapshot snap = await chatIdRef.doc(chatId).get();

    if(!snap.exists) {
      await chatIdRef.doc(chatId).set({
        'typing' : {user.uid: userTyping}
      }, SetOptions(merge: true)
      );
      return;
    }
    Map typing = snap.get('typing') ?? {};
    typing[user.uid] = userTyping;

    await chatRef.doc(chatId).update({'typing' : typing});
  }
}