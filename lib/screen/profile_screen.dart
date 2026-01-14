import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:say/provider/user_provider.dart';

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
        '${ref.watch(userNotifierProvider)!.firstname} ${ref.watch(userNotifierProvider)!.lastname}';
    String email = ref.watch(userNotifierProvider)!.mail;

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
      appBar: CupertinoNavigationBar(middle: const Text('Profile')),
      backgroundColor: Colors.white,
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
                  margin: EdgeInsets.symmetric(horizontal: width * 0.2),
                  width: width * 0.5,
                  height: width * 0.5,
                  child: CircleAvatar(
                    radius: width * 0.25,
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
              '@${ref.read(userNotifierProvider)!.username}',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Colors.black.withAlpha(180),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: height * 0.1),

            Text(
              'Display Name',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 18,
                color: Colors.black.withAlpha(150),
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              name,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 28,
                color: Colors.black.withAlpha(255),
              ),
            ),

            SizedBox(height: height * 0.02),

            Text(
              'Email',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 18,
                color: Colors.black.withAlpha(150),
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              email,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 28,
                color: Colors.black.withAlpha(255),
              ),
            ),

            // Form(
            //   key: key,
            //   child: Column(
            //     children: [
            //       TextFormField(
            //         initialValue: name,
            //         decoration: InputDecoration(
            //           labelText: 'Display Name',
            //           labelStyle: Theme.of(context).textTheme.titleMedium!
            //               .copyWith(
            //                 fontSize: 25,
            //                 color: Colors.black.withAlpha(150),
            //               ),
            //           border: InputBorder.none,
            //         ),
            //         style: Theme.of(context).textTheme.titleLarge!.copyWith(
            //           fontSize: 30,
            //           color: Colors.black.withAlpha(255),
            //         ),
            //         validator: (value) {
            //           if (value!.isEmpty) {
            //             ScaffoldMessenger.of(context).clearSnackBars();
            //             ScaffoldMessenger.of(context).showSnackBar(
            //               SnackBar(content: Text('Please enter your name')),
            //             );
            //           }
            //           return 'please enter your name';
            //         },

            //         onSaved: (value) {},
            //       ),

            //       TextFormField(
            //         initialValue: name,
            //         decoration: InputDecoration(
            //           labelText: 'Display Name',
            //           labelStyle: Theme.of(context).textTheme.bodyLarge!
            //               .copyWith(
            //                 fontSize: 25,
            //                 color: Colors.black.withAlpha(150),
            //               ),
            //           border: InputBorder.none,
            //         ),
            //         style: Theme.of(context).textTheme.titleLarge!.copyWith(
            //           fontSize: 30,
            //           color: Colors.black.withAlpha(255),
            //         ),
            //         validator: (value) {
            //           if (value!.isEmpty) {
            //             ScaffoldMessenger.of(context).clearSnackBars();
            //             ScaffoldMessenger.of(context).showSnackBar(
            //               SnackBar(content: Text('Please enter your name')),
            //             );
            //           }
            //           return 'please enter your name';
            //         },

            //         onSaved: (value) {},
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
