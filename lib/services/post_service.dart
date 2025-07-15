

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_shopk4/Model/UserModel.dart';
import 'package:smart_shopk4/Model/postModel.dart';
import 'package:smart_shopk4/services/Service.dart';
import 'package:smart_shopk4/utils/firebase.dart';

class PostService extends Service {

  UserModel? user;

  //uploads post to the post collection
  uploadPost(File image, String? location, String? description) async {
    
    String link = await uploadImage(posts, image);
    DocumentSnapshot doc =
             await userRef.doc(firebaseAuth.currentUser!.uid).get();

     user = UserModel.fromJson(
       doc.data() as Map<String, dynamic>,
     );

     var ref = postRef.doc();
     ref.set({
       'id': ref.id,
       'postId':ref.id,
       'username':user!.userName,
       'ownerId': firebaseAuth.currentUser!.uid,
       'mediaUrl' : link,
       'description': description ?? "",
       'location' : location ?? 'raj',
       'timestamp' : Timestamp.now(),
     }).catchError((e) {
       print(e);
     });
  }

  Future<List<PostModel>> getUserPosts(String userId) async {

    print("📥 Fetching posts for UID: $userId");

    final snapshot = await FirebaseFirestore.instance
        .collection('posts')
        .where('ownerId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .get();

    print('Found ${snapshot.docs.length} posts');

    for (var doc in snapshot.docs) {
      print("Post ID: ${doc['postId']} | ownerId: ${doc['ownerId']}");
    }

    return snapshot.docs.map((doc) => PostModel.fromJson(doc.data())).toList();
  }




}