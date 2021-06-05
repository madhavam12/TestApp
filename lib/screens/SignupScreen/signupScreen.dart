import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'LocalWidgets/inputField.dart';

import 'LocalWidgets/avatar.dart';

import 'package:connection_verify/connection_verify.dart';
import 'package:sample_app/services/firebaseAuth.dart';
import 'package:sample_app/providers/providers.dart' as providers;

import 'package:sample_app/Screens/LoginScreen/loginScreen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key key}) : super(key: key);

  final FocusNode emailNode = FocusNode();

  final TextEditingController emailController = TextEditingController();
  final FocusNode nameNode = FocusNode();

  final TextEditingController nameController = TextEditingController();

  final FocusNode passNode = FocusNode();

  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFFDEE1ED),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Create an account",
                  style: TextStyle(
                    fontFamily: "Quicksand",
                    fontSize: 25,
                    color: Color(0xFF7881B3),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 35),
                Avatar(),
                SizedBox(height: 25),
                InputField(
                    icon: LineAwesomeIcons.user_astronaut,
                    controller: nameController,
                    node: nameNode,
                    label: "Name",
                    hint: "Please enter your name"),
                SizedBox(height: 35),
                InputField(
                    icon: LineAwesomeIcons.envelope,
                    controller: emailController,
                    node: emailNode,
                    label: "Email",
                    hint: "Please enter your email"),
                SizedBox(height: 25),
                InputField(
                    icon: LineAwesomeIcons.key,
                    controller: passController,
                    node: passNode,
                    label: "Password",
                    isPass: true,
                    hint: "Please enter your password"),
                SizedBox(height: 25),
                signUpButton(context),
                SizedBox(height: 25),
                Text(
                  "Already have an account?",
                  style: TextStyle(
                    fontFamily: "Quicksand",
                    fontSize: 15,
                    color: Color(0xFF7881B3),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.9,
                  ),
                ),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontFamily: "Quicksand",
                      fontSize: 15,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.9,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

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

  Widget signUpButton(context) {
    return Consumer(builder: (context, watch, child) {
      return GestureDetector(
        onTap: () async {
          if (emailController.text == "" ||
              passController.text == "" ||
              nameController.text == "") {
            showInSnackBar(
                context: context,
                value: "Please fill all the fields",
                color: Colors.red);
            return 0;
          }

          StateController<String> path = context.read(providers.imageProvider);

          if (path.state == "") {
            showInSnackBar(
                context: context,
                value: "Please upload an image",
                color: Colors.red);
            return 0;
          }

          openLoadingDialog(context, "Creating");
          if (!(await ConnectionVerify.connectionStatus())) {
            //when no connection
            Navigator.of(context, rootNavigator: true).pop();
            showInSnackBar(
                context: context,
                value:
                    "No Internet connection. Please connect to the internet and then try again.",
                color: Colors.red);
            return 0;
          }
          Auth _auth = Auth();

          var result = await _auth.handleSignUp(
              email: emailController.text,
              password: passController.text,
              photoPath: path.state,
              name: nameController.text);

          if (result is String) {
            Navigator.of(context, rootNavigator: true).pop();
            showInSnackBar(context: context, value: result, color: Colors.red);
            path.state = "";
            return 0;
          }
          Navigator.of(context, rootNavigator: true).pop();
          showInSnackBar(
              context: context,
              value:
                  "Email verification code sent. Please verify it then login again.",
              color: Colors.orange);
          path.state = "";
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(0xFFCFD3E4),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: Offset(5, 5),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
          ),
          child: Text(
            'Register',
            style: TextStyle(
              fontSize: 20,
              color: Color(0xFF7881B3),
            ),
          ),
        ),
      );
    });
  }
}

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

openLoadingDialog(BuildContext context, String text) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      content: Row(
        children: <Widget>[
          CircularProgressIndicator(
              strokeWidth: 1, valueColor: AlwaysStoppedAnimation(Colors.black)),
          Expanded(
            child: Text(text),
          ),
        ],
      ),
    ),
  );
}
