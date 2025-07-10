
import 'package:flutter/material.dart';
import 'package:smart_shopk4/Model/UserModel.dart';
import 'package:smart_shopk4/Model/postModel.dart';
import 'package:smart_shopk4/services/UserService.dart';

class ListPostViewModel extends ChangeNotifier {

  bool isLoading = true;
  List<PostModel> posts = [];
  Map<String,UserModel> users ={};
  UserModel? user;
 //---------------Problem--
  Future<void> fetchPostsAndUsers(List<PostModel> allPosts) async {
    isLoading = true;
    posts = allPosts;

    final uniqueIds = posts.map((e) => e.ownerId).toSet();

    for (String? id in uniqueIds) {
      if (id != null && !users.containsKey(id)) {
        final user = await UserService().getUserById(id);
        users[id] = user;
      }
    }

    isLoading = false;
    notifyListeners();
  }
  //-----------

  UserModel? getUserById(String? ownerId) {
    return users[ownerId];
  }

  Future<void> fetchUser(String ownerId) async {
    try {
      user = await UserService().getUserById(ownerId);
      notifyListeners();
    } catch(e) {
      print('Failed to fetch user: $e');
    }
  }
}