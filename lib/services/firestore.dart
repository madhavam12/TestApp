import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:sample_app/Models/user.dart';
import 'firebaseAuth.dart';

class FirestoreDatabaseService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future createAUser({
    @required UserModel user,
  }) async {
    print('SDsdsa');
    await _firestore
        .collection("users")
        .doc(user.uid)
        .set(user.toJson())
        .catchError((e) {
      return e;
    });

    return true;
  }

  Stream userDataStream() {
    Auth _auth = Auth();
    return _firestore
        .collection("users")
        .doc(_auth.currentUser.uid)
        .snapshots();
  }

  Future updateUser({
    @required UserModel userModel,
  }) async {
    await _firestore
        .collection("users")
        .doc(userModel.uid)
        .set(
          userModel.toJson(),
          SetOptions(merge: true),
        )
        .catchError((e) {
      return e;
    });

    return true;
  }
}
