import 'package:flutter/material.dart';
import 'package:prdip/model/UserModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key,this.user}) : super(key: key);
  final User? user;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        actions: [
          // Text(widget.user!.name!)
          GestureDetector(
            onTap: (){
              
            },
            child: CircleAvatar(
              child: Text(widget.user!.name![0].toUpperCase()),
            ),
          )
        ],
      ),
    );
  }
}
