
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_shopk4/Model/UserModel.dart';
import 'package:smart_shopk4/utils/firebase.dart';

class CommentService {

  // upload a comment
  UserModel? user;
  uploadComment(String currentUserId, String comment, String postId, String mediaUrl) async {

    DocumentSnapshot doc = await userRef.doc(currentUserId).get();
    user = UserModel.fromJson(doc.data() as Map<String, dynamic>);
    print(user?.userName);
    await commentRef.doc(postId).collection('comments').add({
      'username' : user?.userName,
      'comment' : comment,
      'timestamp' : Timestamp.now(),
      'userDp' : user?.photoUri,
      'userId' : user?.id
    });

  }

  // add the comment to notification collection

  addCommentToNotification(
      String type,
      String commentData,
      String username,
      String userId,
      String postId,
      String mediaUrl,
      String ownerId,
      String userDp

      ) async {
    await notificationRef.doc(ownerId).collection('notifications').add({
      "type": type,
      "commentData": commentData,
      "username": username,
      "userId": userId,
      "userDp": userDp,
      "postId": postId,
      "mediaUrl": mediaUrl,
      "timestamp": Timestamp.now(),
    });
  }
}