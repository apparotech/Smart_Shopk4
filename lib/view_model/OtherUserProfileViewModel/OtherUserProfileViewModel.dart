
import 'package:flutter/material.dart';
import 'package:smart_shopk4/Model/UserModel.dart';
import 'package:smart_shopk4/Model/postModel.dart';
import 'package:smart_shopk4/services/UserService.dart';
import 'package:smart_shopk4/services/post_service.dart';

class OtherUserProfileViewModel extends ChangeNotifier {

  UserModel? user;

  List<PostModel> userPosts = [];

  bool isLoading = true;

  Future<void> loadUserProfile(String userId) async {

    isLoading = true;

    user =await UserService().getUserById(userId);
    userPosts = await PostService().getUserPosts(userId);
    isLoading =false;
    notifyListeners();
  }

}