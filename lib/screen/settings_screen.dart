import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:say/provider/user_provider.dart';

import 'package:string_extension/string_extension.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final dp = ref.watch(userNotifierProvider)!.dp;
    final height = MediaQuery.heightOf(context);
    final width = MediaQuery.widthOf(context);
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Settings'),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(CupertinoIcons.back),
        ),
      ),
      child: SizedBox(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: width * 0.05,
            vertical: height * 0.05,
          ),
          height: double.maxFinite,
          width: double.maxFinite,

          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),

                    height: height * 0.12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(255)),
                      color: Color.fromARGB(80, 216, 216, 216),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: [
                        CachedNetworkImage(
                          imageUrl: dp!,
                          key: ValueKey(dp),
                          imageBuilder: (context, imageProvider) =>
                              CircleAvatar(
                                radius: width * 0.12,
                                backgroundImage: imageProvider,
                              ),

                          placeholder: (context, url) => CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            radius: width * 0.12,
                            child: const CircularProgressIndicator(),
                          ),

                          errorWidget: (context, url, error) => CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            radius: width * 0.12,
                            child: const Icon(Icons.error, color: Colors.red),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${ref.watch(userNotifierProvider)!.firstname.capitalize()} ${ref.watch(userNotifierProvider)!.lastname.capitalize()}',
                                  style: Theme.of(context).textTheme.titleLarge!
                                      .copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurface,
                                      ),
                                ),
                                Text(
                                  '@${ref.watch(userNotifierProvider)!.username}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurface.withAlpha(150),
                                      ),
                                ),
                                Text(
                                  'never give up',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        fontSize: 15,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurface,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /*
                
                
                buttons
                
                
                
                */
                  SizedBox(height: height * 0.02),
                  Container(
                    padding: EdgeInsets.all(10),

                    height: height * 0.08,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(255)),
                      color: Color.fromARGB(80, 216, 216, 216),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: [
                        Container(
                          height: width * 0.12,
                          width: width * 0.12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(255),
                            ),
                          ),
                          child: Icon(
                            LineIcons.key,
                            size: 35,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withAlpha(255),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Account',
                                  style: Theme.of(context).textTheme.titleLarge!
                                      .copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurface,
                                      ),
                                ),
                                Text(
                                  'Privacy, Security, Two Factor authentication',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurface.withAlpha(150),
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Container(
                    padding: EdgeInsets.all(10),

                    height: height * 0.08,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(255)),
                      color: Color.fromARGB(80, 216, 216, 216),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: [
                        Container(
                          height: width * 0.12,
                          width: width * 0.12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(255),
                            ),
                          ),
                          child: Icon(
                            LineIcons.facebookMessenger,
                            size: 35,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withAlpha(255),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Chat',
                                  style: Theme.of(context).textTheme.titleLarge!
                                      .copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurface,
                                      ),
                                ),
                                Text(
                                  'Chat history, thene, walpaper',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurface.withAlpha(150),
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Container(
                    padding: EdgeInsets.all(10),

                    height: height * 0.08,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(255)),
                      color: Color.fromARGB(80, 216, 216, 216),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: [
                        Container(
                          height: width * 0.12,
                          width: width * 0.12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(255),
                            ),
                          ),
                          child: Icon(
                            LineIcons.bell,
                            size: 35,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withAlpha(255),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Notifications',
                                  style: Theme.of(context).textTheme.titleLarge!
                                      .copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurface,
                                      ),
                                ),
                                Text(
                                  'Messages, group and others',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurface.withAlpha(150),
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Container(
                    padding: EdgeInsets.all(10),

                    height: height * 0.08,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(255)),
                      color: Color.fromARGB(80, 216, 216, 216),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: [
                        Container(
                          height: width * 0.12,
                          width: width * 0.12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(255),
                            ),
                          ),
                          child: Icon(
                            LineIcons.questionCircle,
                            size: 35,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withAlpha(255),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Help',
                                  style: Theme.of(context).textTheme.titleLarge!
                                      .copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurface,
                                      ),
                                ),
                                Text(
                                  'Help center,contact us, privacy policy',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurface.withAlpha(150),
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Container(
                    padding: EdgeInsets.all(10),

                    height: height * 0.08,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(255)),
                      color: Color.fromARGB(80, 216, 216, 216),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: [
                        Container(
                          height: width * 0.12,
                          width: width * 0.12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(255),
                            ),
                          ),
                          child: Icon(
                            LineIcons.userFriends,
                            size: 35,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withAlpha(255),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Invite a friend',
                                  style: Theme.of(context).textTheme.titleLarge!
                                      .copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurface,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.02),

                  /*
                    
                    
                    
                    Logout
                    
                    
                    
                    */
                  Positioned(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          FirebaseAuth.instance.signOut();
                        });
                      },
                      child: Text(
                        "Logout",
                        style: GoogleFonts.poppins(
                          color: Colors.redAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
