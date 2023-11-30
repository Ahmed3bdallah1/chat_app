import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../services/auth/auth_model.dart';
import '../../services/chat/chat_screen.dart';
import '../constants/color.dart';

class UserTileItem extends StatefulWidget {
  final DocumentSnapshot snapshot;

  const UserTileItem({super.key, required this.snapshot});

  @override
  State<UserTileItem> createState() => _UserTileItemState();
}

class _UserTileItemState extends State<UserTileItem> {
  final FirebaseAuthService _authService = FirebaseAuthService();

  Constants constants = Constants();

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = widget.snapshot.data()! as Map<String, dynamic>;
    return _authService.currentUser.email != widget.snapshot['email']
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
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
              child: ListTile(
                title: Text(data["username"]),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ChatScreen(
                                username: widget.snapshot['username'],
                                receiverId: widget.snapshot['uid'],
                              )));
                },
              ),
            ),
          )
        : Container();
  }
}
