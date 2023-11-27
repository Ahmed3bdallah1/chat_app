import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whats_app/common/widgets/message_item.dart';
import '../../services/chat/chating_services.dart';

class MessagesList extends StatefulWidget {
  final String receiverId;

  const MessagesList({super.key, required this.receiverId});

  @override
  State<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  final ChatServices chatServices = ChatServices();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream:
            chatServices.getMessages(widget.receiverId, _auth.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("error ${snapshot.error}");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text("loading.."));
          }
          return ListView(
              children: snapshot.data!.docs
                  .map((documents) => MessageItem(snapshot: documents))
                  .toList());
        });
  }
}
