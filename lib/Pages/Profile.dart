import 'dart:developer';

import 'package:crudapp/BackEnd/models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
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
  @override
  void initState() {
    // dob.text = " ";
    email.text = FirebaseAuth.instance.currentUser!.email.toString();
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
      log(e.toString());
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

        number.text = d.number ?? "";
        hasData = true;
      });
    } else {}
  }

  void movetosavedata() async {
    if (formkey1.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SizedBox(
                height: 32,
                width: 32,
                child: CircularProgressIndicator(
                  color: Colors.black,
                )),
          );
        },
      );
      try {
        Navigator.of(context, rootNavigator: true).pop('dialog');
        UserModel data = UserModel(
            uid: FirebaseAuth.instance.currentUser!.uid,
            dob: dob.text,
            mail: email.text,
            name: name.text,
            number: number.text);
        await UserData.profile(data, FirebaseAuth.instance.currentUser!.uid);
        // ScaffoldMessenger.of(widget.skey.currentState!.context).showSnackBar(SnackBar(content: Text("${r.msg}")));
        Fluttertoast.showToast(
          msg: "Profile Updated",
          backgroundColor: Colors.grey,
          fontSize: 20,
        );
      } catch (e) {
        log(e.toString());
      }
    }
  }

  uploadImage() async {
    await ImagePicker().pickImage(
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
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.purple, Colors.orange, Colors.indigo])),
      child: Scaffold(
        key: key1,
        appBar: AppBar(
          backgroundColor: Colors.blue,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  uploadImage();
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
                      email.text.isEmpty
                          ? " Enter Detailes Below  "
                          : email.text,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w100),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                color: Colors.grey,
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
                                        emailverify = FirebaseAuth.instance
                                            .currentUser!.emailVerified;
                                        log("$emailverify");
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
                                          await FirebaseAuth
                                              .instance.currentUser!
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
                            color: Colors.white,
                            // size: 30,
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue),
                            shape: MaterialStateProperty.all(
                                const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)))),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.only(
                                    left: 125,
                                    right: 125,
                                    top: 10,
                                    bottom: 10)),
                            elevation: MaterialStateProperty.all(1),
                          ),
                          label: Text(
                            hasData ? "Update" : "Submit",
                            style: const TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
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
      ),
    );
  }
}
