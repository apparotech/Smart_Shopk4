
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:smart_shopk4/utils/FileUtils.dart';
import 'package:smart_shopk4/utils/firebase.dart';

abstract class Service {

  Future<String> uploadImage(Reference ref, File file) async {

    String ext = FileUtils.getFileExtension(file);
    Reference storageRefrence = ref.child("${uuid.v4()}.$ext");
    UploadTask uploadTask = storageRefrence.putFile(file);
    await uploadTask.whenComplete(() => null);
    String fileUrl = await storageRefrence.getDownloadURL();
    return fileUrl;
  }
}