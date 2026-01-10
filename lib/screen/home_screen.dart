import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:say/screen/auth_screen.dart';

final user = FirebaseAuth.instance.currentUser;
final store = FirebaseFirestore.instance;

class HomneScreen extends StatefulWidget {
  const HomneScreen({super.key});

  @override
  State<HomneScreen> createState() => _HomneScreenState();
}

class _HomneScreenState extends State<HomneScreen> {
  String firstname = '';
  String lastname = '';
  String username = '';
  DateTime? dob;
  String mail = '';

  @override
  Widget build(BuildContext context) {
    Widget content = Container(
      decoration: BoxDecoration(
        color: 
      ),
      child: Center(child: Text(mail)));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Image.asset('assets/logo.png', width: 100),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: Icon(
                Icons.logout_outlined,
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: store.collection('users').doc(user!.uid).snapshots(),
        builder: (ctx, snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            );
          }
          if (snapshots.hasData) {
            final userData = snapshots.data!.data() as Map<String, dynamic>;
            firstname = userData['firstname'];
            lastname = userData['lastname'];
            username = userData['username'];
            dob = DateTime.parse(userData['dob']);
            mail = user!.email!;

            return content;
          }
          if (snapshots.hasError) {
            return Center(child: Text('Something went wrong!'));
          }
          return Center(child: Text('Something went wrong!'));
        },
      ),
    );
  }
}
