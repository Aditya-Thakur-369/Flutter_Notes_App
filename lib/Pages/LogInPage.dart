import 'dart:developer';
import 'package:crudapp/Pages/Home.dart';
import 'package:crudapp/Pages/SignUpPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    MoveToHome() async {
      if (_formkey.currentState!.validate()) {
        try {
          await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: email.text, password: password.text)
              .then((value) => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomePage())));
        } on FirebaseAuthException catch (e) {
          if (e.code == "invalid-email") {
            return showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: const Text("Please Enter A Valid Email"),
                );
              },
            );
          } else if (e.code == "wrong-password") {
            return showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: const Text("Wrong Password"),
                );
              },
            );
          }
          // print(e);
          log(e.code);
        }
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LogInPage()));
      }
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(children: [
              SizedBox(
                height: 50.0,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                child: SvgPicture.asset(
                  "assets/Images/LogIn.svg",
                  height: 200.0,
                  width: 200.0,
                  // fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                child: Container(
                  // alignment: Alignment.center,
                  child: Text(
                    "Log In",
                    style: GoogleFonts.lato(fontSize: 50.0, color: Colors.blue),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                child: TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                      suffixIcon: Icon(CupertinoIcons.mail),
                      hintText: "username@gmail.com",
                      labelText: "Enter Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Email Can Not Be Empty";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                child: TextFormField(
                  obscureText: true,
                  controller: password,
                  decoration: InputDecoration(
                      suffixIcon: Icon(CupertinoIcons.lock),
                      hintText: "Abcd@54#87",
                      labelText: "Enter Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password Can Not Be Empty";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              ElevatedButton(
                  onPressed: () {
                    MoveToHome();
                  },
                  child: Text(
                    "Log In",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
              TextButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpPage())),
                  child: Text("Create An Account")),
            ]),
          ),
        ),
      ),
    );
  }
}
