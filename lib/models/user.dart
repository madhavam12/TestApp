import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserModel {
  final String userName;

  final String uid;

  final String email;

  final String photoUrl;

  Timestamp dateAndTime;

  UserModel({
    @required this.userName,
    @required this.uid,
    @required this.photoUrl,
    @required this.email,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : userName = json['userName'],
        uid = json['uid'],
        photoUrl = json['photoUrl'],
        email = json['email'],
        dateAndTime = json['dateAndTime'];

  Map<String, dynamic> toJson() => {
        'userName': userName,
        'uid': uid,
        'dateAndTime': Timestamp.now(),
        'photoUrl': photoUrl,
        'email': email,
      };
}
