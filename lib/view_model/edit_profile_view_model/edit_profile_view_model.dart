import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_shopk4/Model/UserModel.dart';
import 'package:smart_shopk4/Pages/HelperFunction/Navigation_Helper.dart';
import 'package:smart_shopk4/Pages/const/Colors/AppColor.dart';
import 'package:smart_shopk4/services/UserService.dart';
import 'package:smart_shopk4/utils/firebase.dart';


class EditProfileViewModel extends ChangeNotifier {
GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
GlobalKey<FormState> formKey = GlobalKey<FormState>();
bool validate = false;
bool loading = false;

final picker = ImagePicker();
UserService userService = UserService();
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
    NavigationHelper.showInSnackBar('Please fix the error in red before submitting', context);
  } else {
     try {
       loading = true;
       notifyListeners();
       bool success =await userService.updateProfile(
           image: image,
           username: username,
           bio: bio,

       );
      // Fluttertoast.showToast(msg: "Update SuccessFull");
       print(success);

       if(success) {
         Fluttertoast.showToast(msg: "Update SuccessFull");
        // Navigator.pop(context);
       }
     } catch (e){
       loading = false;
       notifyListeners();
      // print(e);
       Fluttertoast.showToast(msg: '$e');
     }
  }
 }
 
 // pick image form gallery and crop image

 pickImage({bool camera = false, BuildContext? context}) async {
  loading = true;
  notifyListeners();
  try {
    XFile? pickedFile = await picker.pickImage(
        source: camera ? ImageSource.camera : ImageSource.gallery,
    );

    if(pickedFile != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: pickedFile.path,

        uiSettings:  [
          AndroidUiSettings(
            toolbarColor: AppColors.primaryBlue500,
            toolbarTitle: 'Crop Image',
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            minimumAspectRatio: 1.0,
          )
        ]

      );
      if(croppedFile != null) {
        image = File(croppedFile.path);
      }
    }

    loading = false;
    notifyListeners();

  } catch (e) {
    loading = false;
    notifyListeners();
    NavigationHelper.showInSnackBar('Cancelled', context);
  }
 }

}