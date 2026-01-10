import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:say/screen/home_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:say/screen/auth_screen.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool isLogin = true;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.blue),
        textTheme: TextTheme(
          titleLarge: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          titleMedium: GoogleFonts.inter(color: Colors.white),
        ),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            return HomneScreen();
          } else {
            return AuthScreen(isLogin: isLogin);
          }
        },
      ),
    );
  }
}
