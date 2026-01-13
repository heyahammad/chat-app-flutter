// router/app_router.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:say/screen/auth_screen.dart';
import 'package:say/screen/home_screen.dart';
import 'package:say/screen/nav_screen.dart';
import 'package:say/screen/profile_screen.dart';
import 'package:say/screen/settings_screen.dart';
import 'package:say/service/stream_listener.dart';

final GoRouter sayRouter = GoRouter(
  initialLocation: '/home',

  refreshListenable: StreamListener(FirebaseAuth.instance.authStateChanges()),

  redirect: (context, state) {
    final user = FirebaseAuth.instance.currentUser;
    final isLoggedIn = user != null;

    final isGoingToAuth = state.uri.toString() == '/authscreen';

    if (!isLoggedIn && !isGoingToAuth) {
      return '/authscreen';
    }

    if (isLoggedIn && isGoingToAuth) {
      return '/home';
    }
    return null;
  },

  routes: [
    GoRoute(
      path: '/authscreen',
      builder: (context, state) => const AuthScreen(isLogin: true),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),

    ShellRoute(
      builder: (context, state, child) {
        return SayNavScreen(child: child);
      },
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomneScreen(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),

        GoRoute(
          path: '/search',
          pageBuilder: (context, state) =>
              MaterialPage(child: Center(child: Text('Search'))),
        ),
        GoRoute(
          path: '/contacts',
          pageBuilder: (context, state) =>
              MaterialPage(child: Center(child: Text('Contacts'))),
        ),
      ],
    ),
  ],
);
