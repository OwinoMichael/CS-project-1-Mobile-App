import 'package:flutter/material.dart';
import 'package:blydev/views/opening_screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Opening View',
      
      home: OpeningView(),
    );
  }
}

