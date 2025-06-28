import 'package:flutter/material.dart';
import 'package:smart_shopk4/Model/UserModel.dart';
import 'package:smart_shopk4/services/UserService.dart';
import 'package:smart_shopk4/utils/firebase.dart';

class ProfileViewModel extends ChangeNotifier {
  UserModel? user;

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
}
