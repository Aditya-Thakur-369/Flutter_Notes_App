// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

class NotesModel {
  final String uid;
  List<Map<String , dynamic>>? notes;
  NotesModel({
    required this.uid,
    this.notes,
  });


  NotesModel copyWith({
    String? uid,
    List<Map<String , dynamic>>? notes,
  }) {
    return NotesModel(
      uid: uid ?? this.uid,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'notes': notes,
    };
  }

  factory NotesModel.fromMap(Map<String, dynamic> map) { 
    return NotesModel(
      uid: map['uid'] as String,
      notes: map['notes'] != null ? List<Map<String , dynamic>>.from((map['notes'] as List<int>).map<Map<String , dynamic>?>((x) => x as Map<String, dynamic>,),) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotesModel.fromJson(String source) => NotesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'NotesModel(uid: $uid, notes: $notes)';

  @override
  bool operator ==(covariant NotesModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return 
      other.uid == uid &&
      listEquals(other.notes, notes);
  }

  @override
  int get hashCode => uid.hashCode ^ notes.hashCode;
}

class Option {
  String? title;
  String? body;

  Option({
    this.title,
    this.body,
  });

  Option copyWith({
    String? title,
    String? body, 
  }) {
    return Option(
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'body': body,
    };
  }

  factory Option.fromMap(Map<String, dynamic> map) {
    return Option(
      title: map['title'] != null ? map['title'] as String : null,
      body: map['body'] != null ? map['body'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Option.fromJson(String source) =>
      Option.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Option(title: $title, body: $body)';

  @override
  bool operator ==(covariant Option other) {
    if (identical(this, other)) return true;

    return other.title == title && other.body == body;
  }

  @override
  int get hashCode => title.hashCode ^ body.hashCode;
}
class Note {
  final String title;
  final String body;
  Note({
    required this.title,
    required this.body,
  });

  Note copyWith({
    String? title,
    String? body,
  }) {
    return Note(
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'body': body,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      title: map['title'] as String,
      body: map['body'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) => Note.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Note(title: $title, body: $body)';

  @override
  bool operator ==(covariant Note other) {
    if (identical(this, other)) return true;
  
    return 
      other.title == title &&
      other.body == body;
  }

  @override
  int get hashCode => title.hashCode ^ body.hashCode;
}


class User {
  final String name;
  final String number;
  final String emil;
  final String imageurl;

  final List<Map<String, dynamic>> Notes;

  User({
    required this.name,
    required this.number,
    required this.emil,
    required this.imageurl,
    required this.Notes,
  });

  User copyWith({
    String? name,
    String? number,
    String? emil,
    String? imageurl,
    List<Map<String, dynamic>>? Notes,
  }) {
    return User(
      name: name ?? this.name,
      number: number ?? this.number,
      emil: emil ?? this.emil,
      imageurl: imageurl ?? this.imageurl,
      Notes: Notes ?? this.Notes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'number': number,
      'emil': emil,
      'imageurl': imageurl,
      'Notes': Notes,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] as String,
      number: map['number'] as String,
      emil: map['emil'] as String,
      imageurl: map['imageurl'] as String,
      Notes: List<Map<String, dynamic>>.from(
        (map['Notes'] as List<dynamic>).map<Map<String, dynamic>>(
          (x) => x,
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(name: $name, number: $number, emil: $emil, imageurl: $imageurl, Notes: $Notes)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.number == number &&
        other.emil == emil &&
        other.imageurl == imageurl &&
        listEquals(other.Notes, Notes);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        number.hashCode ^
        emil.hashCode ^
        imageurl.hashCode ^
        Notes.hashCode;
  }
}
