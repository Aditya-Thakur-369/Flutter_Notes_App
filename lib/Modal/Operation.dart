import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crudapp/Modal/Response.dart';

final FirebaseFirestore store = FirebaseFirestore.instance;
final CollectionReference reference = store.collection("Notes");

class Notes {
  static Future<Response> addnote(String title, String body) async {
    Response r = Response();

    DocumentReference documentReference = reference.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "body": body,
    };

    var result = await documentReference
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

  static Stream<QuerySnapshot> readData() {
    return reference.snapshots();
  }
 // ignore: non_constant_identifier_names
 static Future<Response> UpdateData(String title, String body,String docID) async {
  Response r = Response();
  DocumentReference DocRef = reference.doc(docID);

  Map<String, dynamic> data = <String , dynamic>{
    "title" : title,
    "body" : body,
  };
  await DocRef.update(data).whenComplete(() => {
    r.code = 200,
    r.msg = "Record Updated Successfully"
 }).catchError((e) {
  r.code = 500;
  r.msg = e.message;
 });
  return r;
 }



 static Future<Response> deletedata({required String docID}) async {
  Response r = Response();
  DocumentReference ref = reference.doc(docID);
  await ref.delete().whenComplete(() => {
    r.code = 200,
    r.msg = "Record Deleted Sucessfully",
  }).catchError((e){
    r.code = 500;
    r.msg = e.message;
  }
  );
  return r;
 }
}
