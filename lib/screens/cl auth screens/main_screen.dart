import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:prdip/screens/cl user screens/home_screen.dart';
import 'package:prdip/screens/cl user screens/orders_screen.dart';
import 'package:prdip/screens/cl user screens/search_screen.dart';
import 'package:prdip/screens/cl user screens/userProfile_screen.dart';

class MainScreen extends StatefulWidget {
  static const String idScreen = "main";

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int pageIndex = 0;
  List<Widget> pageList = <Widget>[
    HomeScreen(),
    SearchScreen(),
    OrderScreen(),
    UserProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      PageTransitionSwitcher(
        transitionBuilder: (
          child, 
          primaryAnimation, 
          secondaryAnimation) 
          => FadeThroughTransition(
            animation: primaryAnimation, 
            secondaryAnimation: secondaryAnimation, 
            child: child,
            ),
            child: pageList[pageIndex],
            ),
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Colors.white,
        // selectedIconTheme: IconThemeData(color: Colors.deepPurple),
        // selectedItemColor: Colors.deepOrange,
        // unselectedItemColor: Colors.blueGrey,

        currentIndex: pageIndex,
        onTap: (value) {
          setState(() {
            pageIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Find"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Past Orders"),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: "Profile"),
      ],
      ),
    );
  }
}