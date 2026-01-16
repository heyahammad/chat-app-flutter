import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({super.key, required this.title, required this.subTitle});
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(subTitle),
      subtitle: Text(title),
      titleTextStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
        color: Colors.grey.withAlpha(200),
        fontSize: 15,
      ),
      subtitleTextStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
        color: Colors.black.withAlpha(200),
        fontSize: 20,
      ),
      trailing: Icon(Icons.edit, size: 20),
    );
  }
}
