// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'dart:developer';

import 'package:crudapp/Pages/LogInPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../BackEnd/UserData.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool circular = false;
    final _formkey = GlobalKey<FormState>();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    MoveToLog() async {
      if (_formkey.currentState!.validate()) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: SizedBox(
                height: 32,
                width: 32,
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
            );
          },
        );
        try {
          await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: email.text, password: password.text.trim())
              .then(
            (value) async {
              await UserData.userdata(value.user!.uid);
              if (context.mounted) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LogInPage()));
              }
            },
          );
          Fluttertoast.showToast(
            msg: 'Account Created Successfully :)',
            backgroundColor: Colors.grey,
          );
        } on FirebaseAuthException catch (e) {
          if (e.code == "invalid-email") {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: const Text(
                    "Please Enter A Valid Email",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  actions: [
                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          child: Text("OK"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    )
                  ],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                );
              },
            );
          } else if (e.code == "weak-password") {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: const Text("PLease Enter A Strong Password"),
                  actions: [
                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("OK"))
                      ],
                    )
                  ],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                );
              },
            );
          } else if (e.code == "email-already-in-use") {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content:
                      const Text("This Email is Already Registered With Us"),
                  actions: [
                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("OK"))
                      ],
                    )
                  ],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                );
              },
            );
          } else if (e.code == "network-request-failed") {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content:
                      const Text("Network Error Please Check Your Internet"),
                  actions: [
                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("OK"))
                      ],
                    )
                  ],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
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
                height: 280.0,
                width: 280.0,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                child: Text(
                  "Register",
                  style: GoogleFonts.lato(fontSize: 50.0, color: Colors.blue),
                ),
              ),
              SizedBox(
                height: 5,
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
                height: 5,
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
                    } else if (value.length < 6) {
                      return "Password Should Be Greater Then 6 Digits";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 5,
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
                    // showDialog(context: context, builder: Container(height: 100 , width:  100 , backgroundColor  ));
                    MoveToLog();
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                      padding: MaterialStateProperty.all(EdgeInsets.only(
                          left: 125, right: 125, top: 10, bottom: 10))),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already Have an Account ?"),
                  TextButton(
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LogInPage())),
                      child: Text("Log In")),
                ],
              ),
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
