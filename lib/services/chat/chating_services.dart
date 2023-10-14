import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whats_app/services/models/massege_model.dart';

class ChatServices extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(String receiverId, String message) async {
    final String currentUserId = auth.currentUser!.uid;
    final String currentUserEmail = auth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    Message messages = Message(
        senderId: currentUserId,
        recevierId: receiverId,
        senderEmail: currentUserEmail,
        message: message,
        timestamp: timestamp);

    List<String> chatId = [currentUserId, receiverId];
    chatId.sort();
    String chatRoomId = chatId.join("&");

    await firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .add(messages.messages());
  }

  Stream<QuerySnapshot> getMessages(String userId, String receiverId) {
    List<String> id = [userId, receiverId];
    id.sort();
    String chatRoomId = id.join("&");
    return firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();

  }
}
