

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_shopk4/Model/enum/message_type.dart';

class StoryModel {

  String? caption;
  String? url;
  String? statusId;
  MessageType? type;
  List<dynamic>? viewers;
  Timestamp? time;


  StoryModel({
    this.caption,
    this.url,
    this.statusId,
    this.type, this.viewers, this.time
});


  StoryModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    caption = json['caption'];
    statusId = json['statusId'];
    viewers = json['viewers'];
    if (json['type'] == 'text') {
      type = MessageType.TEXT;
    } else {
      type = MessageType.IMAGE;
    }
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['caption'] = this.caption;
    data['statusId'] = this.statusId;
    data['viewers'] = this.viewers;
    data['url'] = this.url;
    if (this.type == MessageType.TEXT) {
      data['type'] = 'text';
    } else {
      data['type'] = 'image';
    }
    data['time'] = this.time;
    return data;
  }

}