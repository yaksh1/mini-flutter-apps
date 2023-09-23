import 'package:chatty/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class ChatService extends ChangeNotifier {
  // get instance of auth and firestore
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // send message
  Future<void> sendMessage(String receiverId, String message) async {
    // get current user info
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    // creating a message
    Message newMessage = Message(
        senderEmail: currentUserEmail,
        receiverId: receiverId,
        message: message,
        timestamp: timestamp,
        senderId: currentUserId);

    // construct chat room id from current user id and receiver id (sort it)
    List<String> ids = [currentUserId, receiverId];
    ids.sort(); // sort the ids to ensure chat room id is same for a pair of same two people
    String chatRoomId = ids.join("_");

    // add new message to database
    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  // get messages
  Stream<QuerySnapshot> getMessages(String UserId,String otherUserId ){
    List<String> ids = [UserId, otherUserId];
    ids.sort(); // sort the ids to ensure chat room id is same for a pair of same two people
    String chatRoomId = ids.join("_");

    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp',descending: false).snapshots();
  }
}
