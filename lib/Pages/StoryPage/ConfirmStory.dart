

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:smart_shopk4/Model/enum/message_type.dart';
import 'package:smart_shopk4/Model/storyModel.dart';
import 'package:smart_shopk4/Pages/const/Colors/AppColor.dart';
import 'package:smart_shopk4/view_model/StoryViewModel/StoryViewModel.dart';

import '../../utils/firebase.dart';

class ConfirmStory extends StatefulWidget {
  const ConfirmStory({super.key});

  @override
  State<ConfirmStory> createState() => _ConfirmStoryState();
}

class _ConfirmStoryState extends State<ConfirmStory> {

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    StoryViewModel viewModel = Provider.of<StoryViewModel>(context);

    return Scaffold(
      body: LoadingOverlay(
          isLoading: loading,
          child: Center(
            child: AspectRatio(
                aspectRatio: 9 /16,
              child: Image.file(viewModel.mediaUrl!),
            ),
          )
      ),

      bottomNavigationBar: BottomAppBar(
        elevation: 10,
          child: Container(
            constraints:  BoxConstraints(
              maxHeight: 100.0
            ),
            child: Flexible(
                child: TextFormField(
                style: TextStyle(
                  fontSize: 15.0,
                  color: AppColors.primaryBlue500
                ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none,
                    hintText: "Type your caption",
                    hintStyle: TextStyle(
                      color: Colors.black
                    ),
                  ),
                  onSaved: (val) {
                    viewModel.setDescription(val!);
                  },
                  onChanged: (val) {
                    viewModel.setDescription(val);
                  },
                  maxLines: null,
                )
            ),
          ),

      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryBlue500,
        child: const Icon(
          Icons.done,
          color: Colors.white,
        ),
          onPressed: () async{
          setState(() {
            loading  = true;
          });

          QuerySnapshot snapshot = await statusRef
          .where('userId', isEqualTo: firebaseAuth.currentUser!.uid)
          .get();

          if(snapshot.docs.isNotEmpty) {
            List chatList = snapshot.docs;
            DocumentSnapshot chatListSnapshot = chatList[0];
            String url = await uploadMedia(viewModel.mediaUrl!);
            StoryModel message = StoryModel(
              url: url,
              caption: viewModel.description,
              type: MessageType.IMAGE,
              time: Timestamp.now(),
              statusId: uuid.v1(),
              viewers: [],
            );
            await viewModel.sendStatus(chatListSnapshot.id, message);
            setState(() {
              loading = false;
            });
            Navigator.pop(context);
          } else {
            String url = await uploadMedia(viewModel.mediaUrl!);

            StoryModel message = StoryModel(
              url: url,
              caption: viewModel.description,
              type: MessageType.IMAGE,
              time: Timestamp.now(),
              statusId: uuid.v1(),
              viewers: [],
            );
            String id  = await viewModel.sendFirstStatus(message);
            await viewModel.sendStatus(id, message);

            setState(() {
              loading = false;
            });
            Navigator.pop(context);

          }

          }
      ),
    );
  }

  Future<String> uploadMedia(File image) async {
    Reference storageReference =
    storage.ref().child("status").child(uuid.v1()).child(uuid.v4());
    UploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.whenComplete(() => null);
    String imageUrl = await storageReference.getDownloadURL();
    return imageUrl;
  }
}
