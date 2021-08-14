import 'dart:async';
import 'package:blydev/screens/sp%20auth%20screens/Sp_Login_screen.dart';
import 'package:blydev/screens/sp%20auth%20screens/Sp_SignUp_screen.dart';
import 'package:flutter/material.dart';
import 'package:blydev/model/slide.dart';

import 'package:blydev/widgets/slide_dots.dart';
import 'package:blydev/widgets/slide_item.dart';


class GettingStartedScreen extends StatefulWidget {
  static const String idScreen = "started";
  @override
  _GettingStartedScreenState createState() => _GettingStartedScreenState();
}

class _GettingStartedScreenState extends State<GettingStartedScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController(
    initialPage: 0
  );

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if( _currentPage < 2) {
        _currentPage++;
      }else{
        _currentPage = 0;
      }

      _pageController.animateToPage(_currentPage, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    });

  }

  @override
  void dispose(){
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('Home')),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                         PageView.builder(
                    scrollDirection: Axis.horizontal,
                    controller: _pageController,
                    onPageChanged: _onPageChanged,
                    itemCount: slideList.length,
                    itemBuilder: (ctx, i) => SlideItem(i),
                    ),
                  Stack(
                    alignment: AlignmentDirectional.topStart,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(bottom: 35),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            for(int i = 0; i<slideList.length; i++)
                              if( i == _currentPage)
                                SlideDots(true)
                              else
                                SlideDots(false)
                          ],
                          ),
                      ),
                    ],
                  )
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  FlatButton(
                    child: Text('Get Started', 
                    style: TextStyle(fontSize: 18,),

                      ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)
                    ),
                    padding: const EdgeInsets.all(15),
                    color: Colors.deepPurple,
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(context, SpRegistrationScreen.idScreen, (route) => false);
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Have an Account?', style: TextStyle(fontSize: 18,),),
                      FlatButton(
                        
                        child: Text(
                          'Login', 
                          style: TextStyle(fontSize: 18,),
                          ),
                          onPressed: () {
                            //Navigator.of(context).pushNamed(SpLoginScreen.routeName);
                            Navigator.pushNamedAndRemoveUntil(context,
                              SpLoginScreen.idScreen, (route) => false);
                          }, 
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
