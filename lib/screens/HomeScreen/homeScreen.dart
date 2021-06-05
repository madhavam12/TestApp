import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'LocalWidgets/userProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'LocalWidgets/userTile.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController = PageController();
  int _currentIndex = 0;

  void changeIndex({@required int index}) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Color(0xFFFFFFFF),
        child: DotNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            changeIndex(index: index);

            pageController.jumpToPage(index);
          },
          dotIndicatorColor: Colors.orange,
          items: [
            DotNavigationBarItem(
              icon: Icon(
                LineIcons.home,
              ),
              selectedColor: Colors.orange,
            ),
            DotNavigationBarItem(
              icon: Icon(LineAwesomeIcons.user_astronaut),
              selectedColor: Colors.orange,
            ),
          ],
        ),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: (index) {
          changeIndex(index: index);
        },
        children: <Widget>[
          MainScreen(),
          UserProfileView(),
        ],
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F4FB),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        LineAwesomeIcons.horizontal_sliders,
                        size: 40,
                      ),
                      Icon(
                        LineAwesomeIcons.user_astronaut,
                        size: 40,
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  Container(
                    margin: EdgeInsets.only(top: 5, bottom: 10),
                    child: Text(
                      "All Users",
                      style: TextStyle(
                        fontFamily: "Quicksand",
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.9,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(8),
                child: PaginateFirestore(
                    itemBuilderType:
                        PaginateBuilderType.listView, // listview and gridview
                    itemBuilder: (index, context, snapshot) {
                      String date = "";
                      final DateFormat formatter1 =
                          new DateFormat.yMMMMd('en_US');
                      Timestamp _stamp = snapshot.data()['dateAndTime'];
                      date = formatter1.format(
                        _stamp.toDate(),
                      );

                      return UserTile(
                        name: snapshot.data()['userName'],
                        photoURL: snapshot.data()['photoUrl'],
                        joinedOn: date,
                      );
                    },
                    // orderBy is compulsary to enable pagination
                    query: FirebaseFirestore.instance
                        .collection('users')
                        .orderBy('dateAndTime', descending: true),
                    isLive: true // to fetch real-time data
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
