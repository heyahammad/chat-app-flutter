import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    required this.username,
    required this.name,
    required this.imgurl,
  });

  final String username;
  final String name;
  final String imgurl;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        leading: GestureDetector(
          onTap: () {
            context.pop();
          },
          child: Icon(CupertinoIcons.back),
        ),

        middle: Text(widget.username),
      ),
    );
  }
}
