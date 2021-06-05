import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:flutter/material.dart';

class FirebaseStorageService {
  FirebaseStorage storage = FirebaseStorage.instance;
  Future uploadImageAndGetDownloadUrl(
      {@required File image, @required String uid}) async {
    print('hereeee');
    var imageFileName = //TODO chng it to uid so tht it's deleted automatically whn new pic is uploaded
        uid; //uniqueID

    Reference ref = storage.ref().child(imageFileName);

    TaskSnapshot task = await ref.putFile(image).catchError((e) {
      print(e);
    }); //uploading
    print('he222reegasgee');
    var downloadUrl = await task.ref.getDownloadURL().catchError((e) => e);
    return [downloadUrl];
  }
}
