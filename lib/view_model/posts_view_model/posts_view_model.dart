
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_shopk4/Model/postModel.dart';
import 'package:smart_shopk4/services/post_service.dart';

import '../../Pages/HelperFunction/Navigation_Helper.dart';
import '../../Pages/const/Colors/AppColor.dart';

class PostsViewModel extends ChangeNotifier {

 GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

 GlobalKey<FormState> formkey = GlobalKey<FormState>();

 PostService postService = PostService();


 bool loading = false;
 String? username;
 File? mediaUrl;
 final picker = ImagePicker();
 String? location;
 Positioned? positioned;
 Placemark? placemark;
 String? bio;
 String? description;
 String? ownerId;
 String? userId;
 String? imgLink;
 bool edit = false;


 setDescription(String val) {
  print('SetDescription $val');
  description = val;
  notifyListeners();
 }
setPost(PostModel post) {
  if(post != null) {
   description = post.description;
   imgLink = post.mediaUrl;
   location = post.location;
   edit = true;
   edit = false;
   notifyListeners();


  } else {
   edit = false;
   notifyListeners();
  }
}
 setLocation(String val) {
  print('SetLocation $val');
  location = val;
  notifyListeners();
 }


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
     mediaUrl = File(croppedFile.path);
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

 uploadPosts(BuildContext context) async {
  try {
   loading = true;
   notifyListeners();
   await postService.uploadPost(mediaUrl!, location, description);
    loading = false;
    resetPost();
    notifyListeners();
  } catch(e) {
   print(e);
   loading = false;
   resetPost();
   notifyListeners();
   NavigationHelper.showInSnackBar('Upload failed', context);


  }
 }

 resetPost() {
  mediaUrl = null;
  description = null;
  location = null;
  edit = false;
  notifyListeners();
 }



}