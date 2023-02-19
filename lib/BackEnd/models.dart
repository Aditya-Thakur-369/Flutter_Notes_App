// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserModel {
  final String uid;
  String? name;
  String? mail;
  String? number;
  String? dob;
  List<Map<String, dynamic>>? notes;

  UserModel({
    required this.uid,
    this.name,
    this.mail,
    this.number,
    this.dob,
    this.notes,
  });

  UserModel copyWith({
    String? uid,
    String? name,
    String? mail,
    String? number,
    String? dob,
    List<Map<String, dynamic>>? notes,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      mail: mail ?? this.mail,
      number: number ?? this.number,
      dob: dob ?? this.dob,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'mail': mail,
      'number': number,
      'dob': dob,
      'notes': notes,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      name: map['name'] != null ? map['name'] as String : null,
      mail: map['mail'] != null ? map['mail'] as String : null,
      number: map['number'] != null ? map['number'] as String : null,
      dob: map['dob'] != null ? map['dob'] as String : null,
      notes: map['notes'] != null
          ? List<Map<String, dynamic>>.from(
              (map['notes'] as List<dynamic>).map<Map<String, dynamic>?>(
                (x) => x,
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(uid: $uid, name: $name, mail: $mail, number: $number, dob: $dob, notes: $notes)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.name == name &&
        other.mail == mail &&
        other.number == number &&
        other.dob == dob &&
        listEquals(other.notes, notes);
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        name.hashCode ^
        mail.hashCode ^
        number.hashCode ^
        dob.hashCode ^
        notes.hashCode;
  }
}
