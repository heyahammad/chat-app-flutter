import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:say/components/list_builder.dart';
import 'package:say/provider/user_provider.dart';

import 'package:say/service/chat_service.dart';

final user = FirebaseAuth.instance.currentUser;
final store = FirebaseFirestore.instance;

class HomneScreen extends ConsumerStatefulWidget {
  const HomneScreen({super.key});

  @override
  ConsumerState<HomneScreen> createState() => _HomneScreenState();
}

class _HomneScreenState extends ConsumerState<HomneScreen> {
  final chatService = ChatService();
  @override
  void initState() {
    super.initState();
    ref.read(userNotifierProvider.notifier).loadUser();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Padding(
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder(
        stream: chatService.getUserStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            );
          }

          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.hasData) {
            final userList = snapshot.data!;

            return ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context, index) {
                final user = userList[index];

                return GestureDetector(
                  onTap: () {
                    final userData = {
                      'username': user['username'],
                      'imageurl': user['imageurl'],
                      'firstname': user['firstname'],
                    };
                    context.push('/chat', extra: userData);
                  },
                  child: ListBuilder(
                    image: user['imageurl'],
                    title: user['firstname'],
                    username: user['username'],
                  ),
                );
              },
            );
          }
          return Center(child: Text('No user found'));
        },
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Image.asset('assets/logo.png', width: 100),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: IconButton(
              onPressed: () {
                GoRouter.of(context).push('/settings');
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
