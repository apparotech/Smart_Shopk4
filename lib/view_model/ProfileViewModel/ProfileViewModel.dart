import 'package:flutter/material.dart';
import 'package:smart_shopk4/Model/UserModel.dart';
import 'package:smart_shopk4/services/UserService.dart';
import 'package:smart_shopk4/services/post_service.dart';
import 'package:smart_shopk4/utils/firebase.dart';

import '../../Model/postModel.dart';

class ProfileViewModel extends ChangeNotifier {
  UserModel? user;
  PostService postService = PostService();

  Future<void> fetchUser() async {
    final uid = firebaseAuth.currentUser?.uid;
    if (uid == null) return;

    try {
      final userData = await UserService().getUserById(uid);
      user = userData;
      notifyListeners();
    } catch (e) {
      print("Error fetching user in ProfileViewModel: $e");
    }
  }

  List<PostModel> userPosts =[];

  Future<void> fetchUserPosts (String userId) async {

    userPosts = await postService.getUserPosts(userId);
    notifyListeners();
  }
}
