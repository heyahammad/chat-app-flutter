import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String message;
  final String senderId;
  final String senderEmail;
  final String receiverId;
  final Timestamp timestamp;

  const Message({
    required this.message,
    required this.senderEmail,
    required this.receiverId,
    required this.senderId,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'senderid': senderId,
      'senderemail': senderEmail,
      'receiverid': receiverId,
      'timestamp': timestamp,
    };
  }
}
