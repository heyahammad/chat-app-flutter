import 'package:flutter/material.dart';

class MessageWrite extends StatefulWidget {
  const MessageWrite({
    super.key,
    required this.obscure,
    required this.hintText,
    required this.controller,
    required this.submit,
  });
  final TextEditingController controller;
  final String hintText;
  final bool obscure;
  final Function() submit;
  @override
  State<MessageWrite> createState() => _MessageWriteState();
}

class _MessageWriteState extends State<MessageWrite> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ), // Added vertical margin
      child: Row(
        children: [
          // FIX 1: Wrap TextField in Expanded
          Expanded(
            child: TextField(
              controller: widget.controller,
              decoration: InputDecoration(
                // Removed prefixIcon: Search icon looks weird in a chat input
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(
                    30,
                  ), // Smooth round border
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(30),
                ),
                hintText: widget.hintText, // Used hintText property directly
                hintStyle: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(color: Colors.grey),
              ),
              textCapitalization:
                  TextCapitalization.sentences, // Better for chat
              autocorrect: true,
              obscureText: widget.obscure,
            ),
          ),

          const SizedBox(width: 8),

          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: widget.submit,
              icon: const Icon(
                Icons.send_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
