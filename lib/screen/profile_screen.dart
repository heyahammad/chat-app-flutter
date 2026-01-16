import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:say/components/profile_tile.dart';
import 'package:say/provider/user_provider.dart';
import 'package:string_extension/string_extension.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    // final key = GlobalKey<FormFieldState>();
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    final dp = ref.watch(userNotifierProvider)!.dp;

    String name =
        '${ref.watch(userNotifierProvider)!.firstname.capitalize()} ${ref.watch(userNotifierProvider)!.lastname.capitalize()}';
    String email = ref.watch(userNotifierProvider)!.mail;
    String username = ref.watch(userNotifierProvider)!.username;
    String dob = DateFormat.yMMMd().format(
      ref.watch(userNotifierProvider)!.dob,
    );
    String bio = ref.watch(userNotifierProvider)!.bio ?? 'write your bio';

    void updateDp() async {
      final tookImage = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );

      if (tookImage == null) {
        return;
      }

      String image = tookImage.path;

      ref
          .read(userNotifierProvider.notifier)
          .updateDpBio(bio: '', image: image);
    }

    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: Color.fromARGB(0, 255, 255, 255),
        middle: const Text('Profile'),
      ),

      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: width * 0.05,
          vertical: height * 0.005,
        ),
        height: double.maxFinite,
        width: double.maxFinite,
        child: ListView(
          children: [
            GestureDetector(
              onTap: () {
                updateDp();
              },
              child: CachedNetworkImage(
                key: ValueKey(dp),
                imageUrl: dp!,
                fit: BoxFit.cover,

                imageBuilder: (context, imageProvider) => Container(
                  margin: EdgeInsets.symmetric(horizontal: width * 0.25),
                  width: width * 0.5,
                  height: width * 0.5,
                  child: CircleAvatar(
                    radius: width * 0.20,
                    backgroundImage: imageProvider,
                  ),
                ),

                placeholder: (context, url) => CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  radius: width * 0.25,
                  child: const CircularProgressIndicator(),
                ),

                errorWidget: (context, url, error) => CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  radius: width * 0.25,
                  child: const Icon(Icons.error, color: Colors.red),
                ),
              ),
            ),
            SizedBox(height: height * 0.02),
            Text(
              name,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 25,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              '@$username',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Colors.black.withAlpha(180),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: height * 0.05),

            ProfileTile(title: name, subTitle: 'Display'),

            ProfileTile(title: email, subTitle: "Email"),

            ProfileTile(title: dob, subTitle: 'Date of Birth'),
          ],
        ),
      ),
    );
  }
}
