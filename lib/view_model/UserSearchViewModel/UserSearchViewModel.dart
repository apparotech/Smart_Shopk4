
import 'package:flutter/material.dart';
import 'package:smart_shopk4/Model/UserModel.dart';
import 'package:smart_shopk4/services/UserService.dart';

class UserSearchViewModel extends ChangeNotifier {

  final UserService userService = UserService();

  List<UserModel> users = [];
  bool isLoading = false;
  bool isSearchTriggered = false;




  Future<void> search (String query) async {
    isLoading = true;
    notifyListeners();

    users = await userService.searchUsers(query);
    isLoading = false;
    isSearchTriggered = true;
    notifyListeners();
  }

  void clear() {
    users= [];
     isSearchTriggered = false;
    notifyListeners();
  }

  bool isSearchFocused = false;

  void setSearchFocused(bool focused) {
    isSearchFocused = focused;
    notifyListeners();
  }
}