import 'package:flutter/material.dart';

import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';

import 'LocalWidgets/mainPage.dart';

import 'package:sample_app/screens/UserProfile/userProfile.dart';

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
