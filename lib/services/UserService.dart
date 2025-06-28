

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_shopk4/Model/UserModel.dart';
import 'package:smart_shopk4/utils/firebase.dart';

class UserService {

  Future<UserModel> getUserById(String uid) async {



    try {
      DocumentSnapshot doc = await userRef.doc(uid).get();

      if(doc.exists && doc.data() !=null) {
        Map<String, dynamic> userMap = doc.data() as Map<String, dynamic>;
        return UserModel.fromJson(userMap);
      } else {
        throw Exception("User not found for uid: $uid");
      }
    } catch(e) {
      print("Error is  getUserById: $e ");
      rethrow;
    }

  }

//get the authenticated uid
 String currentUid() {
    return firebaseAuth.currentUser!.uid;
 }
  // updates user profile in the Edit Profile Screen

   updateProfile (
  { String?username, String?bio, }
       ) async {

    DocumentSnapshot doc = await userRef.doc(currentUid()).get();
    var users = UserModel.fromJson(doc.data() as Map<String, dynamic>);

    users.userName = username;
    users.bio = bio;

    await userRef.doc(currentUid()).update({
      'username' : username,
      'bio' : bio,

    });
    return true;

   }
}