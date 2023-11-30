import 'package:flutter/material.dart';
import 'package:whats_app/common/constants/color.dart';

class MessageShape extends StatelessWidget {
  final String message;

  const MessageShape({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    Constants constants = Constants();
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: constants.primaryColor,
        borderRadius: BorderRadius.circular(10),
        gradient: constants.linearGradientWhiteBlue,
      ),
      child: Text(message, style: const TextStyle(fontSize: 15)),
    );
  }
}
