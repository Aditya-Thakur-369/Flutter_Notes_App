// ignore_for_file: prefer_adjacent_string_concatenation

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Notify",
          style: GoogleFonts.lato(fontSize: 25.0, color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () => FirebaseAuth.instance.signOut().then((value) =>
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainPage()))),
              icon: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    CupertinoIcons.arrow_down_right_circle,
                    color: Colors.white,
                    size: 25.0,
                  )
                ],
              )),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            // Text("Hello , " + FirebaseAuth.instance.currentUser.email()),
            Text(
              "Hello , " + "User",
            )
          ],
        ),
      ),
      drawer: Drawer(),
    );
  }
}
