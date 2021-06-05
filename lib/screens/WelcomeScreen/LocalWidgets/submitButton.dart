import 'package:flutter/material.dart';
import 'package:sample_app/screens/LoginScreen/loginScreen.dart';

Widget submitButton({@required BuildContext context}) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    },
    child: Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 13),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Color(0xffdf8e33).withAlpha(100),
                offset: Offset(2, 4),
                blurRadius: 8,
                spreadRadius: 2)
          ],
          color: Colors.blue),
      child: Text(
        'Login',
        style: TextStyle(
          fontSize: 22,
          color: Colors.white,
          fontFamily: "QuickSand",
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
