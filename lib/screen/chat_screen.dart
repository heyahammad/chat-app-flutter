import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:say/components/message_write.dart';

import 'package:say/service/chat_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    required this.username,
    required this.name,
    required this.imgurl,
    required this.receiverId,
  });

  final String username;
  final String name;
  final String imgurl;
  final String receiverId;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final chatService = ChatService();
  final auth = FirebaseAuth.instance;

  final messagecontroller = TextEditingController();

  void sendMessage() async {
    if (messagecontroller.text.isNotEmpty) {
      await chatService.sendmessage(
        receiverId: widget.receiverId,
        message: messagecontroller.text,
      );
      messagecontroller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget buidldMessageItem(DocumentSnapshot doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      return Align(
        alignment: data['senderid'] == auth.currentUser!.uid
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              color: data['senderid'] == auth.currentUser!.uid
                  ? Colors.blue
                  : Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              data['message'],
              style: data['senderid'] == auth.currentUser!.uid
                  ? Theme.of(
                      context,
                    ).textTheme.bodyLarge!.copyWith(color: Colors.white)
                  : Theme.of(
                      context,
                    ).textTheme.bodyLarge!.copyWith(color: Colors.black),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: Color.fromARGB(0, 255, 255, 255),
        leading: GestureDetector(
          onTap: () {
            context.pop();
          },
          child: Icon(CupertinoIcons.back),
        ),

        middle: Row(
          children: [
            CachedNetworkImage(
              imageUrl: widget.imgurl,
              key: ValueKey(widget.imgurl),
              imageBuilder: (context, imageProvider) =>
                  CircleAvatar(radius: 20, backgroundImage: imageProvider),

              placeholder: (context, url) => CircleAvatar(
                backgroundColor: Colors.grey[200],
                radius: 20,
                child: const CircularProgressIndicator(),
              ),

              errorWidget: (context, url, error) => CircleAvatar(
                backgroundColor: Colors.grey[200],
                radius: 20,
                child: const Icon(Icons.error, color: Colors.red),
              ),
            ),
            SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.black.withAlpha(200),
                    fontSize: 15,
                  ),
                ),
                Text(
                  '@${widget.username}',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.black.withAlpha(150),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(height: 20),
          Expanded(
            child: StreamBuilder(
              stream: chatService.getMessage(
                auth.currentUser!.uid,
                widget.receiverId,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  );
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Something went wrong.'));
                }
                if (snapshot.hasData) {
                  return ListView(
                    children: snapshot.data!.docs
                        .map((doc) => buidldMessageItem(doc))
                        .toList(),
                  );
                }
                return Center(child: Text('No messages yet.'));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 15),
            child: MessageWrite(
              obscure: false,
              hintText: 'write your message.',
              controller: messagecontroller,
              submit: sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}
