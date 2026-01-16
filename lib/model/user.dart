class User {
  final String firstname;
  final String lastname;
  final String username;
  final DateTime dob;
  final String mail;
  final String? bio;
  final String? dp;
  final List<String>? friends;

  const User({
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.dob,
    required this.mail,
    this.friends,
    this.bio,
    this.dp,
  });
}
