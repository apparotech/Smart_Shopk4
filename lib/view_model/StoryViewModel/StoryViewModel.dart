
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_shopk4/Model/storyModel.dart';
import 'package:smart_shopk4/Pages/StoryPage/ConfirmStory.dart';
import 'package:smart_shopk4/services/StoryService.dart';
import 'package:smart_shopk4/services/UserService.dart';
import 'package:smart_shopk4/services/post_service.dart';

import '../../Pages/HelperFunction/Navigation_Helper.dart';
import '../../Pages/const/Colors/AppColor.dart';

class StoryViewModel extends ChangeNotifier {

  //Service

  UserService userService = UserService();
  PostService postService = PostService();
  StoryService storyService = StoryService();

  //variables

bool loading  = false;

String? username;
File? mediaUrl;
final picker = ImagePicker();

String? description;
  String? userDp;
  String? userId;
  String? imgLink;
  bool edit = false;
  String? id;

  int pageIndex =0;

  setDescription(String val) {
    print('SetDescription $val');
    description = val;
    notifyListeners();
  }


  sendStatus(String chatId, StoryModel message) {
    storyService.sendStatus(
        message,
        chatId
    );
  }

  // send the first message

Future<String>  sendFirstStatus(StoryModel message) async {
    String newChatId = await storyService.sendFirstStatus(message);

    return newChatId;
}

  pickImage({bool camera = false, required BuildContext context}) async {
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
      Navigator.of(context!).push(
        CupertinoPageRoute(builder: (_) => ConfirmStory())
      );
      notifyListeners();

    } catch (e) {
      loading = false;
      notifyListeners();
      NavigationHelper.showInSnackBar('Cancelled', context);
    }
  }

  resetPost() {
    mediaUrl = null;
    description = null;
    edit = false;
    notifyListeners();
  }

}