
import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String? id;
  String? postId;
  String? ownerId;
  String? username;
  String? location;
  String? description;
  String? mediaUrl;
  Timestamp? timestamp;
   Map<String, bool> ? likes ;


  PostModel ({
     this.id,
    this.postId,
    this.ownerId,
    this.username,
    this.location,
    this.description,
    this.mediaUrl,
    this.timestamp,
     this.likes
   
});
// firebase se data lena ---
  PostModel.fromJson(Map<String, dynamic> json) {

    id = json['id'];
    postId = json['postId'];
    ownerId = json['ownerId'];
    location = json['location'];
    username =  json['username'];
    description = json['description'];
    mediaUrl = json['mediaUrl'];
    timestamp = json['timestamp'];
    likes: (json['likes'] as Map<String, dynamic>?)?.map(
          (key, value) => MapEntry(key, value == true),



    );

  }

// firebase ko data bhejna---
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['postId'] = this.postId;
    data['ownerId'] = this.ownerId;
    data['location'] = this.location;
    data['username'] = this.username;
    data['description'] = this.description;
    data['mediaUrl'] = this.mediaUrl;
    data['timestamp'] = this.timestamp;
    data['likes'] = this.likes;

    return data;

  }

}