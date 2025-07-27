
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:smart_shopk4/Model/storyModel.dart';
import 'package:smart_shopk4/utils/firebase.dart';

class StoryService {


  sendStatus(StoryModel story, String chatId) async{
    await statusRef
        .doc('$chatId')
        .collection("statuses")
        .doc(story.statusId)
        .set(story.toJson());

    await statusRef.doc('$chatId').update({
      'userId' : firebaseAuth.currentUser!.uid
    });

  }

  Future<String> sendFirstStatus(StoryModel story) async {
    
    List<String> ids = [];
    
    await userRef.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((DocumentSnapshot documentSnapshot)  {
        ids.add(documentSnapshot.get('id'));
      });
    });

    User? user = firebaseAuth.currentUser;
    DocumentReference ref = await statusRef.add({
      'whoCanSee': ids,
    });
    await sendStatus(story, ref.id);
    return ref.id;
  }

  Future<String> uploadImage(File image) async {
    Reference storageReference =
    storage.ref().child("chats").child(uuid.v1()).child(uuid.v4());
    UploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.whenComplete(() => null);
    String imageUrl = await storageReference.getDownloadURL();
    return imageUrl;
  }

}