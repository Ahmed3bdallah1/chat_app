import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'message_shape.dart';

class MessageItem extends StatefulWidget {
  final DocumentSnapshot snapshot;
  const MessageItem({super.key, required this.snapshot});

  @override
  State<MessageItem> createState() => _MessageItemState();
}

class _MessageItemState extends State<MessageItem> {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = widget.snapshot.data() as Map<String, dynamic>;

    var alignment = (data["senderId"] == _auth.currentUser!.uid)
        ? Alignment.centerLeft
        : Alignment.centerRight;


    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: (data["senderId"] == _auth.currentUser!.uid)
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.end,
          mainAxisAlignment: (data["senderId"] == _auth.currentUser!.uid)
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Text(data["senderEmail"],style: const TextStyle(fontSize: 10)),
            MessageShape(message: data['message'])
            // Container(
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(10),
            //         color: constants.primaryColor,
            //         gradient: constants.linearGradientWhiteBlue,
            //          boxShadow: [
            //            BoxShadow(
            //                color: constants.primaryColor,
            //                spreadRadius: 5,
            //                blurRadius: 8,
            //                offset: const Offset(0, 5))
            //          ]
            //     ),
            //     child: Text(data["message"]))
          ],
        ),
      ),
    );
  }
}
