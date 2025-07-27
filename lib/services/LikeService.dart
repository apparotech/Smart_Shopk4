
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_shopk4/utils/firebase.dart';

class LikeService {

  Future<void> toggleLike(String postId, String userId) async {

    //postRef.doc(postId)
    DocumentSnapshot doc = await postRef.doc(postId).get();

    Map<String, dynamic> postData = doc.data() as Map<String, dynamic>;

    Map<String,dynamic> likes = Map<String, dynamic>.from(postData['likes'] ?? {});

    if( likes[userId] == true ) {

      likes[userId] = false;
      likes.remove(userId);

    } else {
      likes[userId] = true;
    }

    await  postRef.doc(postId).update({'likes': likes});
  }

  int getLikeCount(Map<String,bool> likes) {
    if(likes == null) return 0;
    int count =0;

    likes.forEach((key, value) {
      if(value == true ) count +=1;
    });

    return count;
  }
}