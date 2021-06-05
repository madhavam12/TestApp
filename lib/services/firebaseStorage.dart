import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:flutter/material.dart';

class FirebaseStorageService {
  FirebaseStorage storage = FirebaseStorage.instance;
  Future uploadImageAndGetDownloadUrl(
      {@required File image, @required String uid}) async {
    var imageFileName = uid; //uniqueID

    Reference ref = storage.ref().child(imageFileName);

    TaskSnapshot task = await ref.putFile(image).catchError((e) {
      print(e);
    }); //uploading

    var downloadUrl = await task.ref.getDownloadURL().catchError((e) => e);
    return [
      downloadUrl
    ]; // returning as a list so that later we can check for error.
  }
}
