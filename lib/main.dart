import 'package:crudapp/Pages/ChatScreen.dart';
import 'package:crudapp/Pages/LogInPage.dart';
import 'package:crudapp/Pages/Profile.dart';
import 'package:crudapp/Pages/SignUpPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Pages/ChatScreen.dart';
import 'Pages/Home.dart';
import 'Routes/Routes.dart';
import 'Theme/Theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: MyTheme.lightData(context),
      debugShowCheckedModeBanner: false,
      home: const MainPage(),
      routes: {
        Routes.SignUpPage: (context) => SignUpPage(),
        Routes.LogInPage: (context) => LogInPage(),
        Routes.HomePage: (context) => HomePage(),
        Routes.Profile: (context) => Profile(),
        Routes.ChatScreen: (context) => ChatScreen(),
      },
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