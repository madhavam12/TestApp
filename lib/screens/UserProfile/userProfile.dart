import 'package:flutter/material.dart';

import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'LocalWidgets/optionRow.dart';
import 'LocalWidgets/editProfile.dart';
import 'package:intl/intl.dart';
import 'package:sample_app/Models/user.dart';
import 'package:sample_app/Screens/WelcomeScreen/welcomeScreen.dart';
import 'package:sample_app/services/firebaseAuth.dart';
import 'package:sample_app/services/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileView extends StatefulWidget {
  @override
  _UserProfileViewState createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  FirestoreDatabaseService _db = FirestoreDatabaseService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: StreamBuilder<DocumentSnapshot>(
            stream: _db.userDataStream(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "${snapshot.error}",
                    style: TextStyle(color: Colors.red),
                  ),
                );
              }

              if (!snapshot.hasData) {
                return Center(
                  child: Text(
                    "No data present",
                    style: TextStyle(color: Colors.black),
                  ),
                );
              }

              String date = "";
              final DateFormat formatter1 = new DateFormat.yMMMMd('en_US');
              Timestamp _stamp = snapshot.data.data()['dateAndTime'];
              date = formatter1.format(
                _stamp.toDate(),
              );
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(75.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            image: DecorationImage(
                              image: NetworkImage(
                                  "${UserModel.fromJson(snapshot.data.data()).photoUrl}"),
                              fit: BoxFit.contain,
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
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${UserModel.fromJson(snapshot.data.data()).userName}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  letterSpacing: 1.5,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "QuickSand",
                                  fontSize: 35.0,
                                ),
                              ),
                              Text(
                                "Joined on",
                                maxLines: 5,
                                style: TextStyle(
                                  letterSpacing: 1.5,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "QuickSand",
                                  fontSize: 25.0,
                                ),
                              ),
                              Text(
                                "$date",
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  letterSpacing: 1.5,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "QuickSand",
                                  fontSize: 18.0,
                                ),
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  OptionRow(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfilePage(),
                        ),
                      );
                    },
                    iconColor2: Color(0xFFFEF0E4),
                    text: "Edit Profile",
                    iconData: LineAwesomeIcons.pencil_ruler,
                    iconColor: Color(0xFFFE6D1E),
                  ),
                  OptionRow(
                    onTap: () async {
                      Auth _auth = Auth();

                      await _auth.signOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WelcomePage(),
                        ),
                      );
                    },
                    iconColor2: Color(0xFFF989A4),
                    text: "Sign out",
                    iconData: LineAwesomeIcons.alternate_sign_out,
                    iconColor: Colors.white,
                  ),
                ],
              );
            }),
      ),
    );
  }
}
