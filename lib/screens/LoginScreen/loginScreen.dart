import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'LocalWidgets/inputField.dart';
import 'package:sample_app/services/firebaseAuth.dart';
import 'package:sample_app/Screens/HomeScreen/homeScreen.dart';
import 'package:connection_verify/connection_verify.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key key}) : super(key: key);

  final FocusNode emailNode = FocusNode();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController forgotPasswordController =
      new TextEditingController();

  final FocusNode passNode = FocusNode();

  final TextEditingController passController = TextEditingController();
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

  Widget loginButton(context) {
    return GestureDetector(
      onTap: () async {
        if (emailController.text == "" || passController.text == "") {
          showInSnackBar(
              context: context,
              value: "Please fill all the fields",
              color: Colors.red);
          return 0;
        }

        openLoadingDialog(context, "Logging In");
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

        var result = await _auth.handleSignInEmail(
            email: emailController.text, password: passController.text);

        if (result is String) {
          Navigator.of(context, rootNavigator: true).pop();
          showInSnackBar(context: context, value: result, color: Colors.red);
          return 0;
        }

        if (!await _auth.isEmailVerified(result)) {
          Navigator.of(context, rootNavigator: true).pop();
          showInSnackBar(
              context: context,
              value: "Email not verified, please verify it then login again",
              color: Colors.red);
          await _auth.signOut();
          return 0;
        }
        Navigator.of(context, rootNavigator: true).pop();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
        // showInSnackBar(
        //     context: context,
        //     value:
        //         "Email verification code sent. Please verify it then login again.",
        //     color: Colors.orange);
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
          'Login',
          style: TextStyle(
            fontSize: 20,
            color: Color(0xFF7881B3),
          ),
        ),
      ),
    );
  }

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
                Image(
                  image: AssetImage('assets/images/illus34.png'),
                ),
                Text(
                  "Login to continue",
                  style: TextStyle(
                    fontFamily: "Quicksand",
                    fontSize: 25,
                    color: Color(0xFF7881B3),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 25),
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
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: GestureDetector(
                    onTap: () {
                      Alert(
                          context: context,
                          title: "Reset your Password",
                          content: Column(
                            children: <Widget>[
                              TextField(
                                keyboardType: TextInputType.name,
                                controller: forgotPasswordController,
                                decoration: InputDecoration(
                                  icon: Icon(
                                    LineAwesomeIcons.key,
                                  ),
                                  labelText: 'Enter your email id',
                                ),
                              ),
                            ],
                          ),
                          buttons: [
                            DialogButton(
                              color: Colors.blue,
                              onPressed: () async {
                                Navigator.pop(context);
                                if (forgotPasswordController.text == "") {
                                  showInSnackBar(
                                      context: context,
                                      value: "Enter a valid email.",
                                      color: Colors.green);
                                  return 0;
                                }
                                Auth _auth = Auth();
                                var user = await _auth.sendPasswordResetEmail(
                                    forgotPasswordController.text.trim());

                                if (user is String) {
                                  showInSnackBar(
                                      context: context,
                                      value: "$user",
                                      color: Colors.red);
                                  return 0;
                                }

                                showInSnackBar(
                                    context: context,
                                    value: "Password reset link sent.",
                                    color: Colors.green);
                              },
                              child: Text(
                                "Done",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            )
                          ]).show();
                    },
                    child: Text(
                      "Forgot your password?",
                      style: TextStyle(
                        fontFamily: "Quicksand",
                        fontSize: 15,
                        color: Color(0xFF7881B3),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.9,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                loginButton(context),
              ],
            ),
          ),
        ),
      ),
    );
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
