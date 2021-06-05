import 'package:flutter/material.dart';

Widget title({@required BuildContext context}) {
  return Container(
    // margin: EdgeInsets.all(20),
    child: Column(
      children: [
        Text(
          "Sample App",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            letterSpacing: 1.5,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: "QuickSand",
            fontSize: 40.0,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Login / Register to continue",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            letterSpacing: 1.5,
            color: Colors.black.withOpacity(0.97),
            fontWeight: FontWeight.bold,
            fontFamily: "QuickSand",
            fontSize: 20.0,
          ),
        ),
      ],
    ),
  );
}
