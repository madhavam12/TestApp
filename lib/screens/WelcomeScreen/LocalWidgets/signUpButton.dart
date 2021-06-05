import 'package:flutter/material.dart';
import 'package:sample_app/screens/SignupScreen/signupScreen.dart';

Widget signUpButton({@required BuildContext context}) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SignUpPage()));
    },
    child: Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 13),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        border: Border.all(color: Colors.blue, width: 2),
      ),
      child: Text(
        'Register now',
        style: TextStyle(
          fontSize: 22,
          color: Colors.black,
          fontFamily: "QuickSand",
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
