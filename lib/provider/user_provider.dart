import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
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
        dp: userData['imageurl'],
        bio: userData['bio'],
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

  void updateDpBio({required String bio, required String image}) async {
    final currentuser = auth.FirebaseAuth.instance.currentUser;
    final cloudinary = CloudinaryPublic(
      'dq9jk1wtx',
      'chat-app-flutter-faisal',
      cache: false,
    );

    String cid =
        "${currentuser!.uid}halarputekoyki${DateTime.now().millisecondsSinceEpoch}";

    try {
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          image,
          resourceType: CloudinaryResourceType.Image,
          folder: "user_profiles",
          publicId: cid,
        ),
      );
      FirebaseFirestore.instance
          .collection('users')
          .doc(currentuser.uid)
          .update({'imageurl': response.secureUrl});
      state = User(
        firstname: state!.firstname,
        lastname: state!.lastname,
        username: state!.username,
        dob: state!.dob,
        mail: state!.mail,
        dp: response.secureUrl,
        bio: bio,
      );
    } catch (e) {
      return;
    }
  }
}

final userNotifierProvider = StateNotifierProvider<UserNotifier, User?>(
  (ref) => UserNotifier(),
);
