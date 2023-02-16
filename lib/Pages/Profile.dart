// ignore_for_file: unused_import

import 'dart:math';
import 'package:email_auth/email_auth.dart';
import 'package:crudapp/BackEnd/models.dart';
import 'package:crudapp/Modal/Response.dart';
import 'package:dob_input_field/dob_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import '../BackEnd/UserData.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final GlobalKey key1 = GlobalKey<ScaffoldState>();
  bool hasData = false;

  bool emailverify = false;
  TextEditingController dob = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController number = TextEditingController();
  final formkey1 = GlobalKey<FormState>();
  void initState() {
    // dob.text = " ";
    super.initState();
    fetchData();
  }

  void sendmail() async {
    Fluttertoast.showToast(msg: "Email Has Been Send Sucessfully :) ");
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    } catch (e) {
      // Fluttertoast.showToast(msg: e.toString(), backgroundColor: Colors.grey);
      print(e.toString());
    }
  }

  fetchData() async {
    UserModel? d =
        await UserData.fetchUser(FirebaseAuth.instance.currentUser!.uid);
    if (d != null) {
      setState(() {
        dob.text = d.dob ?? "";
        name.text = d.name ?? "";
        // email.text = d.mail ?? "";
        email.text = FirebaseAuth.instance.currentUser!.email.toString();
        number.text = d.number ?? "";
        hasData = true;
      });
    } else {}
  }

  void movetosavedata() async {
    if (formkey1.currentState!.validate()) {
      try {
        Navigator.of(context, rootNavigator: true).pop('dialog');
        UserModel data = UserModel(
            dob: dob.text,
            mail: email.text,
            name: name.text,
            number: number.text);
        Response r = await UserData.profile(
            data, FirebaseAuth.instance.currentUser!.uid);
        // ScaffoldMessenger.of(widget.skey.currentState!.context).showSnackBar(SnackBar(content: Text("${r.msg}")));
        Fluttertoast.showToast(
          msg: "Profile Updated",
          backgroundColor: Colors.grey,
          fontSize: 20,
        );
      } catch (e) {
        print(e.toString());
      }
    }
  }

  UploadImage() async {
    final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 75);
    // Reference ref = FirebaseFirestore.instance.ref().child("Profile.jpg");
    // await reference.putFile(File(image!.path));
    // ref.get
  }

  @override
  Widget build(BuildContext context) {
    var data;
    return Scaffold(
      key: key1,
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                UploadImage();
              },
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                height: 95,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage("assets/Images/profile.png")),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              height: 70,
              width: double.infinity,
              child: Column(
                children: [
                  Text(
                    name.text.isEmpty ? "Make Your Profile" : name.text,
                    // data.name,
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.grey[400],
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    email.text.isEmpty ? " Enter Detailes Below  " : email.text,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[300],
                        fontWeight: FontWeight.w100),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              height: 5,
              thickness: 1,
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
              child: SingleChildScrollView(
                child: Form(
                  key: formkey1,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: name,
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.near_me,
                            size: 30,
                            color: Colors.blue[200],
                          ),
                          labelText: "Name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 140,
                            height: 70,
                            child: TextFormField(
                              enabled: false,
                              // controller: email,
                              initialValue:
                                  FirebaseAuth.instance.currentUser!.email,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      emailverify = FirebaseAuth
                                          .instance.currentUser!.emailVerified;
                                      print(emailverify);
                                      if (emailverify) {
                                        Fluttertoast.showToast(
                                            msg: "Email Already Verified",
                                            backgroundColor: Colors.grey);
                                      } else {
                                        sendmail();
                                      }
                                    },
                                    icon: Icon(
                                      Icons.email_rounded,
                                      size: 30,
                                      color: Colors.blue[500],
                                    )),
                                // suffixText: TextButton(onPressed: () => , child: Text("Verify"),  ),
                                labelText: "   Email",

                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30)),
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          SizedBox(
                            width: 100,
                            child: Center(
                              child: !FirebaseAuth
                                      .instance.currentUser!.emailVerified
                                  ? TextButton(
                                      onPressed: () async {
                                        await FirebaseAuth.instance.currentUser!
                                            .sendEmailVerification();
                                        // ignore: use_build_context_synchronously
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                "Verification mail sent to your email, check your inbox."),
                                          ),
                                        );
                                      },
                                      child: const Text("Verify Mail"))
                                  : Text("Verified",
                                      style: TextStyle(
                                          color: Colors.green.shade800)),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: number,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.numbers_rounded,
                            size: 30,
                            color: Colors.blue[200],
                          ),
                          labelText: "   Number",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        validator: (value) {
                          if (value!.length != 10) {
                            return "Please Enter a Valid Number ";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: dob,
                        decoration: InputDecoration(
                          suffixIcon: const Icon(
                            Icons.calendar_today,
                            color: Colors.blue,
                          ),
                          labelText: "DOB",
                          // label: Padding(padding: EdgeInsets.only(left: 1)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              lastDate: DateTime(2100));

                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            setState(() {
                              dob.text = formattedDate;
                            });
                          } else {}
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          movetosavedata();
                        },
                        icon: const Icon(
                          Icons.send,
                          // size: 30,
                        ),
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all(const StadiumBorder()),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.only(
                                  left: 55, right: 55, top: 10, bottom: 10)),
                          elevation: MaterialStateProperty.all(1),
                        ),
                        label: Text(
                          hasData ? "Update" : "Submit",
                          style: const TextStyle(
                              // fontSize: 25,
                              // color: Colors.white,
                              // fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}