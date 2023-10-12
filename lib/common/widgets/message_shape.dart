import 'package:flutter/material.dart';
import 'package:whats_app/common/constants/color.dart';

class MessageShape extends StatelessWidget {
   String message;
   MessageShape({super.key,required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Constants().primaryColor,
        borderRadius: BorderRadius.circular(10),
        gradient: Constants().linearGradientWhiteBlue,
      ),
      child: Text(message,style: const TextStyle(fontSize: 15),),
    );
  }
}
