import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Pages/ChatScreen.dart';
import 'Pages/Home.dart';
import 'Pages/LogInPage.dart';
import 'Pages/Profile.dart';
import 'Pages/SignUpPage.dart';
import 'Routes/Routes.dart';
import 'Theme/Theme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: MyTheme.lightData(context),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        Routes.signUpPage: (context) => const SignUpPage(),
        Routes.logInPage: (context) => const LogInPage(),
        Routes.homePage: (context) => const HomePage(),
        Routes.profile: (context) => const Profile(),
        Routes.chatScreen: (context) => const ChatScreen(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Image.asset(
              "assets/Images/Notify.png",
              width: 400.0,
              height: 400.0,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 20),
            child: Text("Notify",
                style: GoogleFonts.poppins(
                    fontSize: 50,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const HomePage();
        } else {
          return const LogInPage();
        }
      },
    );
  }
}


// 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

//  Trywithadi API KEY :- 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