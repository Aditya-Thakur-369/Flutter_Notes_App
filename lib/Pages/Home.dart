// ignore_for_file: prefer_adjacent_string_concatenation, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crudapp/BackEnd/models.dart';
import 'package:crudapp/Pages/AddNotes.dart';
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
  // final Stream<DocumentSnapshot<Object?>> data = Notes.readData();
  // UserModel? data;
  final GlobalKey sKey = GlobalKey<ScaffoldState>();

  // processData() async {
  //   UserModel s = await Notes.readData();
  //   setState(() {
  //     data = s;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // processData();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: Notes.readData2(),
        builder: (context, snapshot) {
          UserModel? data;
          if (snapshot.hasData) {
            var docData = snapshot.data as DocumentSnapshot;
            data = UserModel.fromMap(docData.data() as Map<String, dynamic>);
          }
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
                    onPressed: () => FirebaseAuth.instance.signOut().then(
                        (value) => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MainPage()))),
                    icon: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
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
                          content: AddNotes(
                            data: data!,
                            sKey: sKey,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                        );
                      },
                    ),
                child: const Icon(
                  CupertinoIcons.add,
                  color: Colors.white,
                )),
            body: snapshot.hasData
                ? Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: data!.notes != null
                        ? ListView(
                            children: data.notes!.map((e) {
                              return Card(
                                elevation: 1,
                                margin:
                                    EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 9, right: 9),
                                  child: ListTile(
                                    title: Text(
                                      e["title"].toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.lato(
                                          letterSpacing: 2,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Text(
                                        "${e["body"]}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.blueGrey[300]),
                                      ),
                                    ),
                                    trailing: PopupMenuButton<String>(
                                      onSelected: (String result) {
                                        switch (result) {
                                          case 'edit':
                                            break;
                                          case 'delete':
                                            break;
                                        }
                                      },
                                      itemBuilder: (BuildContext context) =>
                                          <PopupMenuEntry<String>>[
                                        PopupMenuItem<String>(
                                          value: 'edit',
                                          child: ListTile(
                                            leading: Icon(Icons.edit),
                                            title: Text('Edit'),
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return UpdateNotes(
                                                    data: data!,
                                                    index:
                                                        data.notes!.indexOf(e),
                                                    d: e,
                                                    sKey: sKey,
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                        PopupMenuItem<String>(
                                          value: 'delete',
                                          child: ListTile(
                                            leading: Icon(Icons.delete),
                                            title: Text('Delete'),
                                            onTap: () async {
                                              data!.notes!.remove(e);
                                              bool res = await Notes.setData(
                                                  data.toMap());
                                              String msg = "";
                                              if (res) {
                                                msg = "Deleted";
                                              } else {
                                                msg = "Something went wrong";
                                              }
                                              if (context.mounted) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(msg)));
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    isThreeLine: true,
                                  ),
                                ),
                              );
                            }).toList(),
                          )
                        : const Center(child: Text("No data!!")),
                  )
                : const Center(child: CircularProgressIndicator())
            // body: StreamBuilder(
            //     stream: data,
            //     builder: (BuildContext content,
            //         AsyncSnapshot<DocumentSnapshot<Object?>> snapshot) {
            //       if (snapshot.hasData) {
            //         if (snapshot.data != null) {
            //           return Padding(
            //             padding: const EdgeInsets.all(15.0),
            //             child: ListView(
            //               children: snapshot.data!['notes'].map((e) {
            //                 return Card(
            //                   elevation: 1,
            //                   margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
            //                   shape: RoundedRectangleBorder(
            //                     borderRadius: BorderRadius.circular(10),
            //                   ),
            //                   child: Padding(
            //                     padding: EdgeInsets.only(left: 9, right: 9),
            //                     child: ListTile(
            //                       title: Text(
            //                         e["title"].toUpperCase(),
            //                         textAlign: TextAlign.center,
            //                         style: GoogleFonts.lato(
            //                             letterSpacing: 2,
            //                             fontSize: 30,
            //                             fontWeight: FontWeight.bold),
            //                       ),
            //                       subtitle: Padding(
            //                         padding: const EdgeInsets.only(top: 20),
            //                         child: Text(
            //                           "${e["body"]}",
            //                           textAlign: TextAlign.center,
            //                           style: TextStyle(
            //                               fontSize: 20, color: Colors.blueGrey[300]),
            //                         ),
            //                       ),
            //                       trailing: PopupMenuButton<String>(
            //                         onSelected: (String result) {
            //                           switch (result) {
            //                             case 'edit':
            //                               break;
            //                             case 'delete':
            //                               break;
            //                           }
            //                         },
            //                         itemBuilder: (BuildContext context) =>
            //                             <PopupMenuEntry<String>>[
            //                           PopupMenuItem<String>(
            //                             value: 'edit',
            //                             child: ListTile(
            //                               leading: Icon(Icons.edit),
            //                               title: Text('Edit'),
            //                               onTap: () {
            //                                 showDialog(
            //                                   context: context,
            //                                   builder: (context) {
            //                                     return UpdateNotes(
            //                                       title: e["title"],
            //                                       body: e["body"],
            //                                       docID: e.id,
            //                                       sKey: sKey,
            //                                     );
            //                                   },
            //                                 );
            //                               },
            //                             ),
            //                           ),
            //                           PopupMenuItem<String>(
            //                             value: 'delete',
            //                             child: ListTile(
            //                               leading: Icon(Icons.delete),
            //                               title: Text('Delete'),
            //                               onTap: () async {
            //                                 Response r =
            //                                     await Notes.deletedata(docID: e.id);
            //                                 if (context.mounted) {
            //                                   ScaffoldMessenger.of(context)
            //                                       .showSnackBar(SnackBar(
            //                                           content: Text("${r.msg}")));
            //                                 }
            //                               },
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                       isThreeLine: true,
            //                     ),
            //                   ),
            //                 );
            //               }).toList(),
            //             ),
            //           );
            //         } else {
            //           return const Center(
            //             child: Text("hmm!! No Data"),
            //           );
            //         }
            //       } else {
            //         return const Center(
            //           child: CircularProgressIndicator(),
            //         );
            //       }
            //     }),
            ,
            drawer: Drawer(
              backgroundColor: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  children: const [
                    Drawerheader(),
                    Itemheader(),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
