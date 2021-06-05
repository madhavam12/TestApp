import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'firebaseStorage.dart';
import 'firestore.dart';

import 'package:sample_app/Models/user.dart';
import 'dart:io';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  get currentUser => _auth.currentUser;

  Future signOut() async {
    await _auth.signOut();
  }

  var signIn;

  Future handleSignInEmail(
      {@required String email, @required String password}) async {
    var result;
    try {
      result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return result.user;
    } catch (error) {
      if (error.message != null) {
        return error.message;
      } else {
        return "Unknown Error Occured";
      }
    }
  }

  Future handleSignUp(
      {@required String email,
      @required String password,
      @required String name,
      @required String photoPath}) async {
    var result;

    try {
      result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (error) {
      if (error.message != null) {
        return error.message;
      } else {
        return "Unknown Error Occured";
      }
    }
    User user = result.user;
    try {
      await user.sendEmailVerification();

      await user.updateDisplayName(name);
      File file = await File.fromUri(
        Uri.parse(photoPath),
      );

      FirebaseStorageService _storage = FirebaseStorageService();
      List<String> imageUrl = await _storage.uploadImageAndGetDownloadUrl(
          image: file, uid: user.uid);

      await user.updatePhotoURL(imageUrl[0]);

      UserModel userModel = UserModel(
        userName: name,
        uid: FirebaseAuth.instance.currentUser.uid,
        email: email,
        photoUrl: imageUrl[0],
      );

      FirestoreDatabaseService _db = FirestoreDatabaseService();

      await _db.createAUser(user: userModel);
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e);
      return 'An error occured while trying to send email verification';
    }
  }

  Future<bool> isEmailVerified(User user) async {
    bool hh = await user.emailVerified;
    return hh;
  }

  Stream authStream() {
    return _auth.authStateChanges();
  }

  sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (error) {
      if (error.message != null) {
        return error.message;
      } else {
        return "An unknown error occured, please try again after some time.";
      }
    }
  }
}
