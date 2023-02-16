import 'package:crudapp/Pages/OpenAI.dart';
import 'package:crudapp/Pages/Profile.dart';
import 'package:crudapp/Pages/UpdatedList.dart';
import 'package:crudapp/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
              leading: Icon(
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
                      builder: (context) => Profile(),
                    ));
              },
            ),
            
            ListTile(
                leading: Icon(
                  Icons.search_outlined,
                  size: 25,
                  color: Colors.black,
                ),
                title: Text(
                  "Search",
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => OpenAI()));
                }),
            ListTile(
              leading: Icon(
                Icons.update_disabled_outlined,
                size: 25,
                color: Colors.black,
              ),
              title: Text("Updated",
                  style: TextStyle(fontSize: 20, color: Colors.grey)),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UpdatedList()));
              },
            ),
            ListTile(
              leading: Icon(
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
