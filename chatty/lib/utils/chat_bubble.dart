import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.message, required this.color});
  final String message;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.r), color: color),
      child: Text(
        message,
        style:  TextStyle(fontSize: 16,color: Colors.white.withOpacity(0.9)),
      ),
    );
  }
}
