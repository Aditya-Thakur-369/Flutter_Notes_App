import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../BackEnd/UserData.dart';
import '../BackEnd/models.dart';

class Drawerheader extends StatefulWidget {
  const Drawerheader({super.key});

  @override
  State<Drawerheader> createState() => _DrawerHeaderState();
}

class _DrawerHeaderState extends State<Drawerheader> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  @override
  void initState() {
    // dob.text = " ";
    super.initState();
    fetchData();
  }

  fetchData() async {
    UserModel? d =
        await UserData.fetchUser(FirebaseAuth.instance.currentUser!.uid);
    if (d != null) {
      setState(() {
        name.text = d.name ?? "";
        // email.text = d.mail ?? "";
      });
    } else {}
  }

  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue.shade300,
      height: 200,
      width: double.infinity,
      padding: EdgeInsets.only(top: 20.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          margin: EdgeInsets.only(bottom: 10),
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image:
                DecorationImage(image: AssetImage("assets/Images/profile.png")),
          ),
        ),
        Text(name.text.isEmpty ? "Username" : name.text,
            // FirebaseAuth.instance.currentUser!.email.toString(),
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            )),
        Text(
          // email.text.isEmpty ? "Enter Your Email" : email.text,
          FirebaseAuth.instance.currentUser!.email.toString(),
          style: TextStyle(color: Colors.grey.shade300, fontSize: 10),
        )
      ]),
    );
  }
}
