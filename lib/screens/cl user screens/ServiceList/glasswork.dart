import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class Glasswork extends StatefulWidget {
  static const String idScreen = "glasswork";

  @override
  _GlassworkState createState() => _GlassworkState();
}

class _GlassworkState extends State<Glasswork> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  appBar: AppBar(
      //    title: Text('Appliance'),
      //  ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                height: 15.0,
              ),
              Text('Glasswork',
                  style: TextStyle(fontSize: 30.0, fontFamily: ""),
                  textAlign: TextAlign.center),
              SizedBox(
                height: 15.0,
              ),
              FlatButton(
                child: Text(
                  'Urgent? Find in Map',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                padding: const EdgeInsets.all(15),
                color: Colors.deepPurple,
                textColor: Colors.white,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
