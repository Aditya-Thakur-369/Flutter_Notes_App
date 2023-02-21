import 'package:crudapp/Pages/ChatScreen.dart';
import 'package:crudapp/Pages/Profile.dart';
import 'package:crudapp/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Itemheader extends StatefulWidget {
  const Itemheader({super.key});

  @override
  State<Itemheader> createState() => _ItemheaderState();
}

class _ItemheaderState extends State<Itemheader> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(
                Icons.dashboard_outlined,
                size: 25,
                color: Colors.black,
              ),
              title: Text(
                "Profile",
                style: TextStyle(fontSize: 20, color: Colors.grey.shade500),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Profile(),
                    ));
              },
            ),
            ListTile(
                leading: const Icon(
                  Icons.search_outlined,
                  size: 25,
                  color: Colors.black,
                ),
                title:const Text(
                  "Search",
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const ChatScreen()));
                }),
            ListTile(
              leading: const Icon(
                Icons.logout_rounded,
                size: 25,
                color: Colors.black,
              ),
              title: Text(
                "Log Out",
                style: TextStyle(fontSize: 20, color: Colors.grey.shade500),
              ),
              onTap: () {
                FirebaseAuth.instance.signOut().then((value) => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MainPage())));
              },
            ),
          ],
        ),
      ),
    );
  }
}
