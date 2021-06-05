import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'package:sample_app/providers/providers.dart' as providers;

import 'package:flutter_riverpod/flutter_riverpod.dart';

class Avatar extends StatefulWidget {
  Avatar({Key key}) : super(key: key);

  @override
  _AvatarState createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  void showInSnackBar(
      {String value,
      Color color,
      int sec = 3,
      @required BuildContext context}) {
    FocusScope.of(context).requestFocus(new FocusNode());
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      new SnackBar(
        content: new Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontFamily: "WorkSansSemiBold"),
        ),
        backgroundColor: color,
        duration: Duration(seconds: sec),
      ),
    );
  }

  File _image;

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        StateController<String> path = context.read(providers.imageProvider);

        path.state = pickedFile.path;
      } else {
        showInSnackBar(
            value: "No image selected",
            sec: 4,
            color: Colors.red,
            context: context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            image: DecorationImage(
              fit: _image == null ? BoxFit.contain : BoxFit.cover,
              image: _image == null
                  ? AssetImage('assets/images/avatar.png')
                  : FileImage(_image),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: Offset(5, 5),
                blurRadius: 10,
              )
            ],
          ),
        ),
        Positioned(
          bottom: 10,
          right: 75,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              padding: EdgeInsets.all(0),
              onPressed: () async {
                getImage();
              },
              icon: Icon(
                Icons.camera_alt_outlined,
                color: Colors.black,
                size: 25,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
