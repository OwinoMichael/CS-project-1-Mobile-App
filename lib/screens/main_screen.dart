import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:prdip/main.dart';
import 'package:prdip/model/UserModel.dart';
import 'package:prdip/screens/user%20screens/home_screen.dart';
import 'package:prdip/screens/user%20screens/orders_screen.dart';
import 'package:prdip/screens/user%20screens/search_screen.dart';
import 'package:prdip/screens/user%20screens/userProfile_screen.dart';

class MainScreen extends StatefulWidget {
  static const String idScreen = "main";
  const MainScreen({Key? key, this.user}) : super(key: key);
  final User? user;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  User? user;
  getUser() {
    userAuth.fetchUser().then((value) {
      setState(() {
        user = value;
      });
    });
  }

  int pageIndex = 0;
  
  List<Widget> pageList () => <Widget>[
    HomeScreen(user: user,),
    SearchScreen(),
    OrderScreen(),
    UserProfile(
      user: user,
    ),
  ];

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      setState(() {
        user = widget.user!;
      });
    } else {
      getUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    return user == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            body: PageTransitionSwitcher(
              transitionBuilder:
                  (child, primaryAnimation, secondaryAnimation) =>
                      FadeThroughTransition(
                animation: primaryAnimation,
                secondaryAnimation: secondaryAnimation,
                child: child,
              ),
              child: pageList()[pageIndex],
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
                BottomNavigationBarItem(
                    icon: Icon(Icons.search), label: "Find"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.history), label: "Past Orders"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle), label: "Profile"),
              ],
            ),
          );
  }
}
