import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_shopk4/Model/UserModel.dart';
import 'package:smart_shopk4/Pages/HelperFunction/Navigation_Helper.dart';
import 'package:smart_shopk4/services/UserService.dart';
import 'package:smart_shopk4/utils/firebase.dart';

class EditProfileViewModel extends ChangeNotifier {
GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
GlobalKey<FormState> formKey = GlobalKey<FormState>();
bool validate = false;
bool loading = false;

final picker = ImagePicker();
UserModel? user;
String? username;
String? bio;
File? image;
String? imageLink;




setUser(UserModel val) {
  user = val;
  notifyListeners();
}

setImage(UserModel user) {
  imageLink = user.photoUri;
}


setBio(String? val) {
  print('SetBio$val');
  bio = val;
  notifyListeners();
}

setUsername(String? val) {
  print('SetUsername$val');
  username = val;
  notifyListeners();
}

 Future<void> fetchUserData() async {
  final uid  = firebaseAuth.currentUser?.uid;
  if(uid!= null) {
    user = await UserService().getUserById(uid);
    notifyListeners();
  }
 }
 
 editProfile(BuildContext context) async {
  
  FormState form = formKey.currentState!;
  form.save();
  if(!form.validate()) {
    validate = true;
    notifyListeners();
   return NavigationHelper.showInSnackBar('Please fix the errors in red before submitting.', context);
  }
 }
 
 

}