// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

//  Map<String, dynamic> data = <String, dynamic>{
//       "name": name,
//       "email": email,
//       "number": number,
//       "dob": dob,
//     };

class UserModel {
  String? name;
  String? mail;
  String? number;
  String? dob;
  UserModel({
    this.name,
    this.mail,
    this.number,
    this.dob,
  });

  UserModel copyWith({
    String? name,
    String? mail,
    String? number,
    String? dob,
  }) {
    return UserModel(
      name: name ?? this.name,
      mail: mail ?? this.mail,
      number: number ?? this.number,
      dob: dob ?? this.dob,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'mail': mail,
      'number': number,
      'dob': dob,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] != null ? map['name'] as String : null,
      mail: map['mail'] != null ? map['mail'] as String : null,
      number: map['number'] != null ? map['number'] as String : null,
      dob: map['dob'] != null ? map['dob'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(name: $name, mail: $mail, number: $number, dob: $dob)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.mail == mail &&
        other.number == number &&
        other.dob == dob;
  }

  @override
  int get hashCode {
    return name.hashCode ^ mail.hashCode ^ number.hashCode ^ dob.hashCode;
  }
}
