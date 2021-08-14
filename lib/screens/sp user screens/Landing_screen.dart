import 'package:flutter/material.dart';
import 'package:prdip/screens/sp%20user%20screens/navigation_bloc.dart';

class SpMainScreen extends StatefulWidget with NavigationStates{

  const SpMainScreen({ Key? key }) : super(key: key);

  @override
  _SpMainScreenState createState() => _SpMainScreenState();
}

class _SpMainScreenState extends State<SpMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Home"),
    );
  }
}

