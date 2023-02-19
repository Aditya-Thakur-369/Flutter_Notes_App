import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../Modal/Response.dart';
import 'models.dart';

final FirebaseFirestore store = FirebaseFirestore.instance;
final CollectionReference reference = store.collection("User");

class UserData {
  static userdata(String uid) async {
    UserModel d = UserModel(uid: uid);
    // log(uid);
    try {
      await store.collection("User").doc(uid).set(d.toMap());
    } catch (e) {
      log(e.toString());
    }
    // log("Done");
  }

  static profile(UserModel data, String uid) async {
    Response r = Response();

    DocumentReference documentReference = reference.doc(uid);
    await documentReference
        .set(data.toMap())
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

  static Future<UserModel?> fetchUser(String uid) async {
    try {
      DocumentSnapshot<Object?> value = await reference.doc(uid).get();
      return UserModel.fromMap(value.data() as Map<String, dynamic>);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
