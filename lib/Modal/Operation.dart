import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crudapp/BackEnd/UserData.dart';
import 'package:crudapp/BackEnd/models.dart';
import 'package:crudapp/Modal/Response.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore store = FirebaseFirestore.instance;
// final CollectionReference reference = store.collection("Notes");
final CollectionReference reference = store.collection("User");

class Notes {
  static Future<Response> addnote(String title, String body) async {
    Response r = Response();

    DocumentReference documentReference = reference.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "body": body,
    };

    await documentReference
        .set(data)
        .whenComplete(() => {
              r.code = 200,
              r.msg = "Record Stored successfully !!",
            })
        .catchError((e) {
      r.code = 500;
      r.msg = e.message;
      log("${r.msg}");
    });
    return r;
  }

  static Future<bool> setData(Map<String, dynamic> data) async {
    try {
      await reference.doc(FirebaseAuth.instance.currentUser!.uid).set(data);
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  static Future<UserModel> readData() async {
    // return reference.snapshots();
    var dd = await reference.doc(FirebaseAuth.instance.currentUser!.uid).get();
    return UserModel.fromMap(dd.data() as Map<String, dynamic>);
  }

  static Stream<DocumentSnapshot<Object?>> readData2() {
    // return reference.snapshots();
    return reference.doc(FirebaseAuth.instance.currentUser!.uid).snapshots();
  }

  // ignore: non_constant_identifier_names
  static Future<Response> UpdateData(
      String title, String body, String docID) async {
    Response r = Response();
    DocumentReference docRef = reference.doc(docID);

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "body": body,
    };
    await docRef
        .update(data)
        .whenComplete(
            () => {r.code = 200, r.msg = "Record Updated Successfully"})
        .catchError((e) {
      r.code = 500;
      r.msg = e.message;
    });
    return r;
  }

  static Future<Response> deletedata({required String docID}) async {
    Response r = Response();
    DocumentReference ref = reference.doc(docID);
    await ref
        .delete()
        .whenComplete(() => {
              r.code = 200,
              r.msg = "Record Deleted Sucessfully",
            })
        .catchError((e) {
      r.code = 500;
      r.msg = e.message;
    });
    return r;
  }
}
