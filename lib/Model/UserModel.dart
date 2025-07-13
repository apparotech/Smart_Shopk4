import 'package:cloud_firestore/cloud_firestore.dart';


class UserModel {
  String? userName;
  String? email;
  String? photoUri;
  String? country;
  String? bio;
  String? id;
  Timestamp? signedUpAt;
  Timestamp? lastSeen;
  bool? isOnline;
  int? followersCount;
  int? followingCount;

  UserModel({
    this.userName,
    this.email,
    this.photoUri,
    this.country,
    this.bio,
    this.id,
    this.signedUpAt,
    this.lastSeen,
    this.isOnline,
    this.followersCount,
    this.followingCount

});

  UserModel.fromJson(Map <String, dynamic> json) {
     userName = json['userName'];
    email = json['email'];
    photoUri = json['photoUri'];
    country = json['country'];
    bio = json['bio'];
    id = json['id'];
    signedUpAt = json['signedUpAt'];
    lastSeen = json['lastSeen'];
    isOnline= json['isOnline'];
    followersCount = json['followersCount'] ?? 0;
    followingCount = json['followingCount'] ?? 0;


  }

  Map<String, dynamic> toJson () {

   final Map<String, dynamic> data =  new  Map <String, dynamic>();
    data['userName' ] = userName;
    data['email'] = email;
    data['photoUri'] = photoUri;
    data['country'] = country;
    data['bio']= bio;
    data['id'] =id;
    data['signedUpAt'] = signedUpAt;
    data['lastSeen'] = lastSeen;
    data['isOnline'] = isOnline;

    data['followersCount'] = followersCount ?? 0;
    data['followingCount'] = followingCount ?? 0;
    return data;

  }
}