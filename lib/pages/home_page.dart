import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      body: userList(),
    );
  }

  Widget userList() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
                child: Text("error in loading chats",
                    style: TextStyle(color: Colors.white, fontSize: 20)));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: Text(
              "loading...",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ));
          }
          return ListView(
            children: snapshot.data!.docs
                .map<Widget>((e) => userTileItem(e))
                .toList(),
          );
        });
  }

  Widget userTileItem(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;

    if (_authService.currentUser.email != snapshot['email']) {
      return Padding(
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
                            username: snapshot['username'],
                            receiverId: snapshot['uid'],
                          )));
            },
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
