import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_riverpod/legacy.dart';
import 'package:say/model/user.dart';

class UserNotifier extends StateNotifier<User?> {
  UserNotifier() : super(null);

  Future<void> loadUser() async {
    final currentuser = auth.FirebaseAuth.instance.currentUser;

    final userDataInstance = FirebaseFirestore.instance;

    final snapshot = await userDataInstance
        .collection('users')
        .doc(currentuser!.uid)
        .get();

    if (snapshot.exists) {
      final userData = snapshot.data() as Map<String, dynamic>;
      state = User(
        firstname: userData['firstname'],
        lastname: userData['lastname'],
        username: userData['username'],
        dob: DateTime.parse(userData['dob']),
        mail: currentuser.email!,
      );
    }
  }

  void updateUserDetails(String fname, String lname, DateTime dob) {
    state = User(
      firstname: fname,
      lastname: lname,
      username: state!.username,
      dob: dob,
      mail: state!.mail,
    );
  }
}

final userNotifierProvider = StateNotifierProvider<UserNotifier, User?>(
  (ref) => UserNotifier(),
);
