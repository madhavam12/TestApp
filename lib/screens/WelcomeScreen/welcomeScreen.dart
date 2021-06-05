import 'package:flutter/material.dart';
import 'package:sample_app/screens/LoginScreen/loginScreen.dart';
import 'package:sample_app/screens/SignupScreen/signupScreen.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  Widget _submitButton() {
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

  Widget _signUpButton() {
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

  // Widget _label() {
  //   return Container(
  //       margin: EdgeInsets.only(top: 40, bottom: 20),
  //       child: Column(
  //         children: <Widget>[
  //           Text(
  //             'Quick login with Touch ID',
  //             style: TextStyle(color: Colors.white, fontSize: 17),
  //           ),
  //           SizedBox(
  //             height: 20,
  //           ),
  //           Icon(Icons.fingerprint, size: 90, color: Colors.white),
  //           SizedBox(
  //             height: 20,
  //           ),
  //           Text(
  //             'Touch ID',
  //             style: TextStyle(
  //               color: Colors.white,
  //               fontSize: 15,
  //               decoration: TextDecoration.underline,
  //             ),
  //           ),
  //         ],
  //       ));
  // }

  Widget _title() {
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

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xfffFFF7EA), Color(0xffFFF7EA)],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Positioned(
              //     top: -height * .15,
              //     right: -MediaQuery.of(context).size.width * .4,
              //     child: BezierContainer()),

              Container(
                height: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/welcome.png"),
                      fit: BoxFit.cover),
                ),
              ),
              _title(),
              SizedBox(
                height: 80,
              ),
              _signUpButton(),
//TODO dnt make use r entr number on sign up whn they post/ buy a gig thn checkif they hv number nd if nt thn ask thm to
              SizedBox(
                height: 20,
              ),
              _submitButton(),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
