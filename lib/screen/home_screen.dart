import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icons.dart';

import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:say/provider/user_provider.dart';
import 'package:say/screen/profile_screen.dart';

import 'package:say/screen/settings_screen.dart';

final user = FirebaseAuth.instance.currentUser;
final store = FirebaseFirestore.instance;

class HomneScreen extends ConsumerStatefulWidget {
  const HomneScreen({super.key});

  @override
  ConsumerState<HomneScreen> createState() => _HomneScreenState();
}

class _HomneScreenState extends ConsumerState<HomneScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(userNotifierProvider.notifier).loadUser();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userNotifierProvider);
    Widget content;
    if (user == null) {
      content = Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.primary,
        ),
      );
    } else {
      content = Container(
        decoration: BoxDecoration(color: Colors.white60),
        child: Center(
          child: InkWell(
            onTap: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (ctx) => ProfileScreen())),
            child: Text(ref.watch(userNotifierProvider)!.mail),
          ),
        ),
      );
    }

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
                GoRouter.of(context).go('/settings');
              },

              icon: Icon(
                CupertinoIcons.settings,
                size: 30,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
      body: content,
    );
  }
}
