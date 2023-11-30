import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whats_app/common/widgets/message_shape.dart';
import 'package:whats_app/common/widgets/messages_list.dart';
import 'package:whats_app/services/chat/chating_services.dart';

import '../../common/constants/color.dart';

class ChatScreen extends StatefulWidget {
  String username;
  String receiverId;

  ChatScreen({super.key, required this.username, required this.receiverId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Constants constants = Constants();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ChatServices chatServices = ChatServices();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final TextEditingController messageController = TextEditingController();

  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await chatServices.sendMessage(widget.receiverId, messageController.text);
      messageController.clear();
    }
  }

  // Widget buildMessageItem(DocumentSnapshot snapshot) {
  //   Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
  //
  //   var alignment = (data["senderId"] == _auth.currentUser!.uid)
  //       ? Alignment.centerLeft
  //       : Alignment.centerRight;
  //
  //   return Container(
  //     alignment: alignment,
  //     child: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Column(
  //         crossAxisAlignment: (data["senderId"] == _auth.currentUser!.uid)
  //             ? CrossAxisAlignment.start
  //             : CrossAxisAlignment.end,
  //         mainAxisAlignment: (data["senderId"] == _auth.currentUser!.uid)
  //             ? MainAxisAlignment.end
  //             : MainAxisAlignment.start,
  //         children: [
  //           Text(data["senderEmail"],style: const TextStyle(fontSize: 10)),
  //           MessageShape(message: data['message'])
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget buildMessageList() {
  //   return StreamBuilder<QuerySnapshot>(
  //       stream:
  //           chatServices.getMessages(widget.receiverId, _auth.currentUser!.uid),
  //       builder: (context, snapshot) {
  //         if (snapshot.hasError) {
  //           return Text("error ${snapshot.error}");
  //         }
  //         if (snapshot.connectionState == ConnectionState.waiting) {
  //           return const Center(child: Text("loading.."));
  //         }
  //         return ListView(
  //             children: snapshot.data!.docs
  //                 .map((documents) => buildMessageItem(documents))
  //                 .toList());
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: constants.primaryColor.withOpacity(.5),
      appBar: AppBar(
        title: Text(
          widget.username,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Container(
            width: size.width * .95,
            height: size.height * .775,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: constants.linearGradientWhiteBlue,
                boxShadow: [
                  BoxShadow(
                      color: constants.primaryColor.withOpacity(.5),
                      spreadRadius: 5,
                      blurRadius: 8,
                      offset: const Offset(0, 5))
                ]),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  MessagesList(receiverId: widget.receiverId),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
          child: TextField(
            controller: messageController,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                suffixIcon: GestureDetector(
                    onTap: () {
                      sendMessage();
                    },
                    child: const Icon(Icons.send))),
          ),
        )
      ]),
      // bottomNavigationBar:,
    );
  }
}
