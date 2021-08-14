import 'package:flutter/material.dart';
import 'package:blydev/screens/sp%20user%20screens/navigation_bloc.dart';

class SpOrders extends StatefulWidget with NavigationStates {


  const SpOrders({ Key? key }) : super(key: key);

  @override
  _SpOrdersState createState() => _SpOrdersState();
}

class _SpOrdersState extends State<SpOrders> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Orders"),
    );
  }
}