// ignore_for_file: prefer_adjacent_string_concatenation, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crudapp/Modal/Response.dart';
import 'package:crudapp/Pages/AddNotes.dart';
import 'package:crudapp/Pages/DrawerHeader.dart';
import 'package:crudapp/Pages/Itemheader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Drawer/DrawerHeader.dart';
import '../Drawer/Itemheader.dart';
import '../Modal/Operation.dart';
import '../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Stream<QuerySnapshot> data = Notes.readData();
  final GlobalKey sKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: sKey,
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
                    Icons.logout_outlined,
                    color: Colors.white,
                    size: 25.0,
                  )
                ],
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text(
                      "Add Note",
                      textAlign: TextAlign.center,
                    ),
                    content: AddNotes(sKey: sKey),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                  );
                },
              ),
          child: const Icon(
            CupertinoIcons.add,
            color: Colors.white,
          )),
      body: StreamBuilder(
          stream: data,
          builder:
              (BuildContext content, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.docs.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListView(
                    children: snapshot.data!.docs.map((e) {
                      return Card(
                        child: Padding(
                          padding: EdgeInsets.only(left: 9, right: 9),
                          child: ExpansionTile(
                            title: Text(e["title"],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    letterSpacing: 2,
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold)),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Text(
                                "${e["body"]}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.blueGrey[200]),
                              ),
                            ),
                            children: [
                              const Divider(),
                              ButtonBar(
                                alignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                      onPressed: () => {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return UpdateNotes(
                                                  title: e["title"],
                                                  body: e["body"],
                                                  docID: e.id,
                                                  sKey: sKey,
                                                );
                                              },
                                            ),
                                          },
                                      icon: Icon(Icons.edit_note_rounded)),
                                  IconButton(
                                      onPressed: () async {
                                        Response r =
                                            await Notes.deletedata(docID: e.id);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text("${r.msg}")));
                                      },
                                      icon: Icon(Icons.delete)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              } else {
                return const Center(
                  child: Text("hmm!! No Data"),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Drawerheader(),
                Itemheader(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
