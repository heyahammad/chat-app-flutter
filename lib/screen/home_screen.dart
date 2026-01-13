import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icons.dart';

import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:say/provider/user_provider.dart';
import 'package:say/screen/profile_screen.dart';

import 'package:say/screen/settings_screen.dart';

final user = FirebaseAuth.instance.currentUser;
final store = FirebaseFirestore.instance;

class HomneScreen extends ConsumerStatefulWidget {
  const HomneScreen({super.key});

  @override
  ConsumerState<HomneScreen> createState() => _HomneScreenState();
}

class _HomneScreenState extends ConsumerState<HomneScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(userNotifierProvider.notifier).loadUser();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userNotifierProvider);
    Widget content;
    if (user == null) {
      content = Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.primary,
        ),
      );
    } else {
      content = Container(
        decoration: BoxDecoration(color: Colors.white60),
        child: Center(
          child: InkWell(
            onTap: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (ctx) => ProfileScreen())),
            child: Text(ref.watch(userNotifierProvider)!.mail),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Image.asset('assets/logo.png', width: 100),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: IconButton(
              onPressed: () {
                // Navigator.of(context).push(
                //   MaterialPageRoute(builder: (content) => SettingsScreen()),
                // );
                GoRouter.of(context).go('/settings');
              },
              // icon: HugeIcon(
              //   icon: HugeIcons.strokeRoundedUserCircle,
              //   size: 35,
              //   strokeWidth: 2,
              //   color: Colors.blueAccent,
              // ),
              icon: Icon(
                CupertinoIcons.settings,
                size: 30,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
      // bottomNavigationBar: SafeArea(
      //   child: Container(
      //     margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Container(
      //           width: MediaQuery.sizeOf(context).width * 0.8,
      //           decoration: BoxDecoration(
      //             color: Color.fromARGB(15, 0, 0, 0),
      //             borderRadius: BorderRadius.circular(100),
      //           ),
      //           child: GNav(
      //             rippleColor: Colors.grey[300]!,
      //             hoverColor: Colors.grey[100]!,
      //             gap: 8,
      //             activeColor: Colors.black,
      //             iconSize: 24,
      //             padding: const EdgeInsets.symmetric(
      //               horizontal: 20,
      //               vertical: 12,
      //             ),
      //             duration: const Duration(milliseconds: 400),
      //             tabBackgroundColor: Colors.grey[100]!,
      //             color: Colors.black,
      //             tabShadow: [
      //               BoxShadow(
      //                 color: Colors.grey.withOpacity(0.1),
      //                 blurRadius: 8,
      //               ),
      //             ],

      //             tabs: [
      //               const GButton(icon: LineIcons.home, text: 'Home'),
      //               const GButton(icon: LineIcons.list, text: 'People'),
      //               const GButton(icon: LineIcons.search, text: 'Search'),
      //               const GButton(icon: LineIcons.user, text: 'Profile'),
      //             ],
      //             onTabChange: (value) {
      //               if (value == 3) {
      //                 GoRouter.of(
      //                   context,
      //                 ).pushNamed(SayRoutersConstants.profile);
      //               }
      //             },
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      body: content,
    );
  }
}
