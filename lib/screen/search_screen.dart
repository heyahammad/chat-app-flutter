import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:say/components/search.dart';
import 'package:say/components/list_builder.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final controller = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser;
  String title = '';
  String image = '';
  String username = '';
  bool isSearched = false;
  bool userfound = false;
  void search(String query) async {
    final users = FirebaseFirestore.instance.collection('users');

    QuerySnapshot querySnapshot = await users
        .where('username', isEqualTo: query)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      var userDoc = querySnapshot.docs.first;
      if (userDoc.id == currentUser!.uid) {
        return setState(() {
          userfound = false;
        });
      }
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
      setState(() {
        userfound = true;
        isSearched = true;
        title = userData['firstname'];
        username = userData['username'];
        image = userData['imageurl'];
      });
    } else {
      setState(() {
        userfound = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: Color.from(alpha: 0, red: 255, green: 255, blue: 255),
        middle: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Column(
          children: [
            Search(
              hintText: 'Search user',
              obscure: false,
              controller: controller,
              submit: search,
            ),
            SizedBox(height: 10),
            if (!isSearched)
              SizedBox()
            else if (userfound)
              ListBuilder(image: image, title: title, username: username)
            else
              Center(child: Text('No user found.')),
          ],
        ),
      ),
    );
  }
}
