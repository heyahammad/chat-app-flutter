import 'package:flutter_riverpod/legacy.dart';
import 'package:say/model/user.dart';

import 'package:say/screen/home_screen.dart';

class UserNotifier extends StateNotifier<User> {
  UserNotifier()
    : super(
        User(
          firstname: firstname,
          lastname: lastname,
          username: username,
          dob: dob!,
          mail: mail,
        ),
      );

  void updateUserProfile(String fname, String lname, DateTime birth) {
    final updateUser = User(
      firstname: fname,
      lastname: lname,
      dob: birth,
      mail: mail,
      username: username,
    );
    state = updateUser;
  }
}

final userNotifierProvider = StateNotifierProvider<UserNotifier, User>(
  (ref) => UserNotifier(),
);
