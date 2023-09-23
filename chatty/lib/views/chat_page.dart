import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatPage extends StatefulWidget {
  const ChatPage(
      {super.key, required this.reciverUserEmail, required this.reciverUserID});

  @override
  State<ChatPage> createState() => _ChatPageState();

  final String reciverUserEmail;
  final String reciverUserID;
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.reciverUserEmail),),
    );
  }
}
