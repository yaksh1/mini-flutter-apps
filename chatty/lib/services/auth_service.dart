import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService extends ChangeNotifier {
  //! instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //! instance of firestore
   final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  //! sign user in
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      //! after logging user in ,add a new doc in user collections if doesnt already exists
      _fireStore.collection('users').doc(user.user!.uid).set({
        'uid': user.user!.uid,
        'email': email,
      },SetOptions(merge: true));
      return user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }


  //! create a user
  Future<UserCredential> createUser(String email, String password) async {
    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      //! after creating user,add a new doc in user collections
      _fireStore.collection('users').doc(user.user!.uid).set({
        'uid':user.user!.uid,
        'email':email,
      });
      return user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }


  //! sign user out
  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}
