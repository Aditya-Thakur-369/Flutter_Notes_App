// ignore_for_file: prefer_const_constructors

import 'dart:developer';
import 'package:crudapp/Pages/Home.dart';
import 'package:crudapp/Pages/SignUpPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    moveToHome() async {
      if (formkey.currentState!.validate()) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              content: SizedBox(
                  height: 42,
                  width: 42,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text("Loading ... "),
                      SizedBox(
                        width: 40,
                      ),
                      CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    ],
                  )),
            );
          },
        );
        try {
          await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: email.text, password: password.text)
              .then((value) => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomePage())));
          Fluttertoast.showToast(
            msg: 'Log In Successfully :) ',
          );
        } on FirebaseAuthException catch (e) {
          if (e.code == "invalid-email") {
            return showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: const Text("Please Enter A Valid Email"),
                  actions: [
                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: const Text("OK"))
                      ],
                    )
                  ],
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                );
              },
            );
          } else if (e.code == "wrong-password") {
            return showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: const Text("Wrong Password"),
                  actions: [
                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: const Text("OK"))
                      ],
                    )
                  ],
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                );
              },
            );
          } else if (e.code == "network-request-failed") {
            return showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: const Text("No Internet Connection"),
                  actions: [
                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: const Text("OK"))
                      ],
                    )
                  ],
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                );
              },
            );
          } else if (e.code == "unknown") {
            return showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: const Text("Something Went Wrong"),
                  actions: [
                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: const Text("OK"))
                      ],
                    )
                  ],
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                );
              },
            );
          } else if (e.code == "user-not-found") {
            return showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: const Text("Something Went Wrong"),
                  actions: [
                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: const Text("OK"))
                      ],
                    )
                  ],
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                );
              },
            );
          }
          // print(e);
          log(e.code);
        }
        if (context.mounted) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LogInPage()));
        }
      }
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(children: [
              const SizedBox(
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
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                child: Text(
                  "Log In",
                  style: GoogleFonts.lato(fontSize: 50.0, color: Colors.blue),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                child: TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                      suffixIcon: const Icon(CupertinoIcons.mail),
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
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                child: TextFormField(
                  obscureText: true,
                  controller: password,
                  decoration: InputDecoration(
                      suffixIcon: const Icon(CupertinoIcons.lock),
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
              const SizedBox(
                height: 10.0,
              ),
              ElevatedButton(
                  onPressed: () {
                    moveToHome();
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                      shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                      padding: MaterialStateProperty.all(const EdgeInsets.only(
                          left: 130, right: 130, top: 10, bottom: 10)),
                      elevation: MaterialStateProperty.all(1)),
                  child: const Text(
                    "Log In",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't Have an Account ?"),
                  TextButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpPage())),
                      child: const Text("Create An Account")),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
