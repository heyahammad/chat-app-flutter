import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:say/provider/user_provider.dart';
import 'package:say/screen/home_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:say/screen/auth_screen.dart';
import 'package:say/screen/splash_screen.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isLogin = true;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Say',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.blue),
        textTheme: TextTheme(
          titleLarge: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          titleMedium: GoogleFonts.inter(color: Colors.white),
          bodyLarge: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          bodyMedium: GoogleFonts.carroisGothic(),
        ),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          } else if (snapshot.hasData) {
            return HomneScreen();
          } else {
            return AuthScreen(isLogin: isLogin);
          }
        },
      ),
    );
  }
}
