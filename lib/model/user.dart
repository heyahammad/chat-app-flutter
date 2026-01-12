import 'dart:io';

class User {
  const User({
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.dob,
    required this.mail,
    this.bio,
    this.dp,
  });

  final String firstname;
  final String lastname;
  final String username;
  final DateTime dob;
  final String mail;
  final String? bio;
  final File? dp;
}
