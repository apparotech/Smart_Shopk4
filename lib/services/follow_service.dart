
import 'package:flutter/material.dart';
import 'package:smart_shopk4/utils/firebase.dart';
class FollowService{

  final currentUserId = firebaseAuth.currentUser!.uid;

  // Follow a user
   Future<void> followUser(String targetUserId) async {
     
     try {
       await followersRef.doc(targetUserId).collection('userFollowers').doc(currentUserId).set({});
       await followingRef.doc(currentUserId).collection('userFollowing').doc(targetUserId).set({});
     } catch (e) {
       print('Error following user: $e');
       rethrow;
     }
   }
  // Unfollow a user

  Future<void> unfollowUser(String targetUserId) async {

     try {
       await followersRef.doc(targetUserId).collection('usersFollowers').doc(currentUserId).delete();
       await followingRef.doc(currentUserId).collection('userFollowing').doc(targetUserId).delete();
     } catch(e) {
       print('Error unfollowing user $e');
       rethrow;
     }

   }

   // check if current user is following the target user
  Future<bool> isFollowing(String targetUserId) async {
    final doc = await firestore
        .collection('following')
        .doc(currentUserId)
        .collection('userFollowing')
        .doc(targetUserId)
        .get();
    return doc.exists;
  }


   // get followers count
  Future<int> getFollowersCount(String userId) async {
     final snapshot = await firestore
         .collection('followers')
         .doc(userId)
         .collection('userFollowers')
         .get();
     return snapshot.docs.length;
   }


   // Get following count
   Future<int> getFollowingCount(String userId) async {
     final snapshot = await firestore
         .collection('following')
         .doc(userId)
         .collection('userFollowing')
         .get();
         return snapshot.docs.length;
   }

  Future<Map<String, int>> getFollowerAndFollowingCount(String userId) async {
    final followersSnapshot = await firestore
        .collection('followers')
        .doc(userId)
        .collection('userFollowers')
        .get();

    final followingSnapshot = await firestore
        .collection('following')
        .doc(userId)
        .collection('userFollowing')
        .get();

    return {
      'followers': followersSnapshot.docs.length,
      'following': followingSnapshot.docs.length,
    };
  }





}