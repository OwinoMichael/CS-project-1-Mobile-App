import 'package:flutter/material.dart';
import 'package:blydev/screens/sp%20user%20screens/navigation_bloc.dart';

class MyAccount extends StatefulWidget with NavigationStates {

  const MyAccount({ Key? key }) : super(key: key);

  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("My Account"),
    );
  }
}