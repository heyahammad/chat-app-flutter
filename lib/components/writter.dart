import 'package:flutter/material.dart';

class Writter extends StatefulWidget {
  const Writter({
    super.key,
    required this.obscure,
    required this.hintText,
    required this.controller,
    required this.submit,
  });
  final TextEditingController controller;
  final String hintText;
  final bool obscure;
  final Function submit;
  @override
  State<Writter> createState() => _WritterState();
}

class _WritterState extends State<Writter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          prefixIconColor: Colors.black.withAlpha(200),

          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(255)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black.withAlpha(200),
              width: 2,
            ),

            borderRadius: BorderRadius.circular(255),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black.withAlpha(200),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(255),
          ),

          hint: Text(
            widget.hintText,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(color: Colors.grey.withAlpha(200)),
          ),
        ),
        textCapitalization: TextCapitalization.none,
        autocorrect: null,

        obscureText: widget.obscure,
        onSubmitted: (value) {
          widget.submit(value);
        },
      ),
    );
  }
}
