import 'dart:developer';

import 'package:crudapp/Pages/LogInPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    MoveToLog() async {
      if (_formkey.currentState!.validate()) {
        try {
          await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: email.text, password: password.text.trim())
              .then((value) => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LogInPage())));
        } on FirebaseAuthException catch (e) {
          if (e.code == "invalid-email") {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: const Text("Please Enter A Valid Email"),
                );
              },
            );
          } else if (e.code == "weak-password") {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: const Text("PLease Enter A Strong Password"),
                );
              },
            );
          }
          log(e.code);
        }
      }
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(children: [
              SvgPicture.asset(
                "assets/Images/referal.svg",
                height: 300.0,
                width: 300.0,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                child: Container(
                  // alignment: Alignment.center,
                  child: Text(
                    "Register",
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
                      suffixIcon: Icon(CupertinoIcons.padlock),
                      hintText: "Abcd@54#87",
                      labelText: "Enter Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password Can Not Be Empty";
                    } else if (value.length > 6) {
                      return "Password Should Be Greater Then 6 Digits";
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
                  decoration: InputDecoration(
                      suffixIcon: Icon(CupertinoIcons.lock),
                      hintText: "Abcd@54#87",
                      labelText: "Confirm Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  validator: (value) {
                    if (value != password.text) {
                      return "Confirm Password Is Not Same As Password";
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
                    MoveToLog();
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
              TextButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LogInPage())),
                  child: Text("Log In")),
              SizedBox(
                height: 10.0,
              )
            ]),
          ),
        ),
      ),
    );
  }
}
