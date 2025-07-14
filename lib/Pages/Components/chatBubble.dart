import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_chat_bubble/chat_bubble.dart' as flutter_chat_bubble;
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_3.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Model/enum/message_type.dart';
import 'TextTime.dart';

class ChatBubbleWidget extends StatefulWidget {
  final String? message;
  final MessageType? type;
  final Timestamp? time;
  final bool? isMe;

  const ChatBubbleWidget({
    super.key,
    this.message,
    this.time,
    this.isMe,
    this.type,
  });

  @override
  State<ChatBubbleWidget> createState() => _ChatBubbleWidgetState();
}

class _ChatBubbleWidgetState extends State<ChatBubbleWidget> {
  Color? chatBubbleColor() {
    if (widget.isMe!) {
      return Theme.of(context).colorScheme.secondary;
    } else {
      return Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[800]
          : Colors.grey[200];
    }
  }

  @override
  Widget build(BuildContext context) {
    final isText = widget.type == MessageType.TEXT;

    return Column(
      crossAxisAlignment:
      widget.isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: <Widget>[
        flutter_chat_bubble.ChatBubble(
          clipper: ChatBubbleClipper3(
            type: widget.isMe!
                ? BubbleType.sendBubble
                : BubbleType.receiverBubble,
          ),
          alignment:
          widget.isMe! ? Alignment.topRight : Alignment.topLeft,
          margin: const EdgeInsets.only(top: 5),
          backGroundColor: chatBubbleColor(),
          child: Container(
            padding: EdgeInsets.all(isText ? 10 : 0),
            child: isText
                ? Text(
              widget.message ?? "",
              style: TextStyle(
                color:
                     Colors.white

              ),
            )
                : CachedNetworkImage(
              imageUrl: widget.message ?? '',
              height: 200,
              width: MediaQuery.of(context).size.width / 1.3,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: widget.isMe!
              ? const EdgeInsets.only(right: 10.0, bottom: 10.0)
              : const EdgeInsets.only(left: 10.0, bottom: 10.0),
          child: TextTime(
            child: Text(
              timeago.format(widget.time!.toDate()),
              style: TextStyle(
                color: Colors.black,
                fontSize: 10.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

