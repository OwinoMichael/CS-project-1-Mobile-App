import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:prdip/DataHandler/myData.dart';
import 'package:prdip/screens/cl%20user%20screens/Maps/plumberMap.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class Plumbing extends StatefulWidget {
  static const String idScreen = "plumbing";

  @override
  _PlumbingState createState() => _PlumbingState();
}

class _PlumbingState extends State<Plumbing> {

  List<myData> allData = [];

  //@override
  // void initState() {
  //   DatabaseReference doja = FirebaseDatabase(databaseURL: "https://prdip-2932d-default-rtdb.europe-west1.firebasedatabase.app/").reference();
  //   doja.child('client-users').once().then((DataSnapshot snap) {
  //     var keys = snap.value.keys;
  //     var data = snap.value;
  //     //allData.clear();
  //     for (var key in keys) {
  //       myData d = new myData(
  //         data[key]['name'],
  //         data[key]['email'],
  //         data[key]['phone']
  //       );
  //       allData.add(d);
  //     }
  //     setState(() {
  //       print('£££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££.....Lenght: ${allData.length}');
  //     });
  //   });
  // }

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
              Text('Plumbing',
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
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, MapView.idScreen, (route) => false);

                },
              ),
              // allData.length == 0 ? new Text('No data Available'):
              // new ListView.builder(
              //   itemCount: allData.length,
              //   itemBuilder: (_,index) {
              //     //return Grid(allData[index].name, allData[index].email, allData[index].phone);
              //     return GridView.count(
              //       crossAxisCount: 2,
              //       children: List.generate(10, (index) {
              //               return Card(
              //                 elevation: 10.0,
              //                 child: new Container(
              //                   child: Text("Hey",
              //                       style: TextStyle(
              //                           backgroundColor: Colors.green,
              //                           fontSize: 35,
              //                           color: Colors.black)),
              //                 ),
              //               );
              //             }),
              //     );
              // }, ),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
//   Widget Grid(String name, String image, String phone){
//     return GridView.count(
//                 crossAxisCount: 2,
//                 children: List.generate(10, (index) {
//                   return Card(
//                     elevation: 10.0,
//                     child: new Container(
//                       child: Text("$name", style: TextStyle(backgroundColor: Colors.green, fontSize: 35, color: Colors.black)),
//
//                     ),
//                   );
//                 }),
//               );
//
//   }
//
 }
