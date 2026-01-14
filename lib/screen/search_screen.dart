import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:say/components/search.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final controller = TextEditingController();

  void search(String username) async {
    final users = FirebaseFirestore.instance.collection('users');

    QuerySnapshot querySnapshot = await users
        .where('username', isEqualTo: username)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      var userDoc = querySnapshot.docs.first;
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
    } else {
      return print('not found..........................');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search', textAlign: TextAlign.center)),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Search(
              hintText: 'Search user',
              obscure: false,
              controller: controller,
              submit: search,
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
