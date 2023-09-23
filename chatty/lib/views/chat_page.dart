import 'package:chatty/services/chat/chat_service.dart';
import 'package:chatty/utils/chat_bubble.dart';
import 'package:chatty/utils/my_textx_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatPage extends StatefulWidget {
  const ChatPage(
      {super.key,
      required this.receiverUserEmail,
      required this.receiverUserID});

  @override
  State<ChatPage> createState() => _ChatPageState();

  final String receiverUserEmail;
  final String receiverUserID;
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void sendMessage() async {
    // only send message if text is present
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverUserID, _messageController.text);
      // clear the controller after sending a message
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.receiverUserEmail),
        ),
        body: Column(
            children: [
              // messages
              Expanded(
                child: _buildMessageList(),
              ),

              // user input
              _buildMessageInput(),
            ],
          ),
        );
  }
Widget _buildMessageList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _chatService.getMessages(widget.receiverUserID, _auth.currentUser!.uid), 
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('loading..');
        }
        return ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
        children:snapshot.data!.docs.map((document) => _buildMessageItem(document) ).toList() ,
      );
      },
    );
  }


  // item
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    // align message according to user and receiver
    var alignment = (data['senderId'] == _auth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      alignment: alignment,
      child: Column(
        crossAxisAlignment: (data['senderId'] == _auth.currentUser!.uid)? CrossAxisAlignment.end:CrossAxisAlignment.start,
        mainAxisAlignment: (data['senderId'] == _auth.currentUser!.uid)
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,

        children: [
          ChatBubble(message: data['message'],color:(data['senderId'] == _auth.currentUser!.uid)?Colors.blue[400]:Colors.black54,),
          SizedBox(height: 5.h,)
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: EdgeInsets.only(
        bottom:10.0.h,
        left: 10.w),
      child: Row(
        children: [
          //text field
          Expanded(
            child: TextField(
              autocorrect: false,
              obscureText: false,
              enableSuggestions: true,
              controller: _messageController,
              decoration: InputDecoration(
                  hintText: "Message...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  )),
            ),
          ),
    
          IconButton(
            onPressed: sendMessage,
            icon: Icon(
              Icons.send_rounded,
              size: 40,
            ),
          )
        ],
      ),
    );
  }
}
