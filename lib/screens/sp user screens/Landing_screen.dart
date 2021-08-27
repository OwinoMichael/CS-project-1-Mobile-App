import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:blydev/screens/sp%20user%20screens/navigation_bloc.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:http/http.dart';

class SpMainScreen extends StatefulWidget with NavigationStates{

  const SpMainScreen({ Key? key }) : super(key: key);

  @override
  _SpMainScreenState createState() => _SpMainScreenState();
}

class _SpMainScreenState extends State<SpMainScreen> {

  String? time;

  void getTime() async {
    Response response = await get(
        Uri.parse('http://worldtimeapi.org/api/timezone/Africa/Nairobi'));
    Map data = jsonDecode(response.body);

    //get properties
    String datetime = data['datetime'];
    String offset = data['utc_offset'].subString(1, 3);

    DateTime now = DateTime.parse(datetime);
    now = now.add(Duration(hours: int.parse(offset)));

    time = '$now';
    print(
        "***************************%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%££££££££££££££££££££££££££££££££££££££££££££££££££££££££%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^***************************************");
    print(now);
  }

  void initState(){
    super.initState();
    getTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Image(
              image: AssetImage('./assets/images/tools.jpg'),
              alignment: Alignment.center,
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 250.0,
              child: DefaultTextStyle(
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 35.0,
                  fontFamily: 'Agne',
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText('Design first, then code'),
                    TypewriterAnimatedText('Welcome, Docka Stephen'),
                  ],
                  onTap: () {
                    print("Tap Event");
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            Text("$time"),
          ],
        ),
      ),
    );
  }
}

