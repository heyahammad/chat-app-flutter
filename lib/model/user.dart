class User {
  const User({
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.dob,
    required this.mail,
  });

  final String firstname;
  final String lastname;
  final String username;
  final DateTime dob;
  final String mail;
}
