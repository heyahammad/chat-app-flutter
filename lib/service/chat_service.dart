import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final firebaseAuth = FirebaseAuth.instance;

  final firebaseFirestore = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> getUserStream() {
    return firebaseFirestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs
          .where((doc) => doc.id != firebaseAuth.currentUser!.uid)
          .map((doc) => doc.data())
          .toList();
    });
  }
}
