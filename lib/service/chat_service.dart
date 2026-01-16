import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:say/model/message.dart';

class ChatService {
  final firebaseAuth = FirebaseAuth.instance;

  final firebaseFirestore = FirebaseFirestore.instance;

  //
  //user list stream
  //

  Stream<List<Map<String, dynamic>>> getUserStream() {
    return firebaseFirestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs
          .where((doc) => doc.id != firebaseAuth.currentUser!.uid)
          .map((doc) => doc.data())
          .toList();
    });
  }

  /*

message sending

*/
  Future<void> sendmessage({
    required String receiverId,
    required String message,
  }) async {
    final String currentUserId = firebaseAuth.currentUser!.uid;
    final String currentUserEmail = firebaseAuth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    final sendmessage = Message(
      message: message,
      senderEmail: currentUserEmail,
      receiverId: receiverId,
      senderId: currentUserId,
      timestamp: timestamp,
    );

    List<String> ids = [currentUserId, receiverId];

    ids.sort();

    String chatroomId = ids.join('_');

    await firebaseFirestore
        .collection('chatrooms')
        .doc(chatroomId)
        .collection('messages')
        .add(sendmessage.toMap());
  }

  /*

get messages

*/

  Stream<QuerySnapshot> getMessage(String senderId, String recieveerId) {
    List<String> ids = [senderId, recieveerId];

    ids.sort();

    String chatroomId = ids.join('_');

    return firebaseFirestore
        .collection('chatrooms')
        .doc(chatroomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
