import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whats_app/common/widgets/user_list.dart';

import '../common/constants/color.dart';
import '../services/auth/auth_model.dart';
import '../services/chat/chat_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuthService _authService = FirebaseAuthService();

  Constants constants = Constants();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: constants.primaryColor.withOpacity(.5),
      appBar: AppBar(
        title: const Text('home page'),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return CupertinoAlertDialog(
                          title: const Text('logout?'),
                          actions: [
                            CupertinoDialogAction(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.of(context);
                                },
                                child: const Text('cancel')),
                            CupertinoDialogAction(
                                onPressed: () {
                                  _authService.logout();
                                },
                                child: const Text('ok')),
                          ]);
                    });
              },
              icon: const Icon(Icons.logout_sharp))
        ],
      ),
      body: const UserList(),
    );
  }
}
