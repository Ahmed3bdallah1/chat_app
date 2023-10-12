import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String recevierId;
  final String senderEmail;
  final String message;
  final Timestamp timestamp;

  Message({required this.senderId,
    required this.recevierId,
    required this.senderEmail,
    required this.message,
    required this.timestamp});

  Map<String,dynamic> messages(){
    return {
      "senderId": senderId,
      "recevierId":recevierId,
      "senderEmail":senderEmail,
      "message":message,
      "timestamp":timestamp
    };

  }

}