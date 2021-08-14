import 'package:flutter/material.dart';
import 'package:prdip/screens/cl%20user%20screens/ServiceList/appliance.dart';
import 'package:prdip/screens/cl%20user%20screens/ServiceList/electrical.dart';
import 'package:prdip/screens/cl%20user%20screens/ServiceList/glasswork.dart';
import 'package:prdip/screens/cl%20user%20screens/ServiceList/metalwork.dart';
import 'package:prdip/screens/cl%20user%20screens/ServiceList/paintjob.dart';
import 'package:prdip/screens/cl%20user%20screens/ServiceList/plumbing.dart';
import 'package:prdip/screens/cl%20user%20screens/ServiceList/tiling.dart';
import 'package:prdip/screens/cl%20user%20screens/ServiceList/woodwork.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  static const String idScreen = "search";

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Screen'),
      ),
      body: ListView(
        //itemCount: serviceList.lenght,

        // child:  ListTile(
        //   title: Text("Plumbing"),
        //   subtitle: Text("Motley Crew"),
        //   leading: Image.network(''),
        //   trailing: Icon(Icons.arrow_forward_ios_rounded),
        // ),
        children: <Widget>[
          GestureDetector(
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
                  context, Plumbing.idScreen, (route) => false);
          },
          child: Card(
            child: ListTile(
              title: Text("Plumbing"),
              subtitle: Text("Motley Crew"),
              leading: Image.network(
                  'https://images.unsplash.com/photo-1628093841756-f940f1fe0415?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80'),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
          ),
          ),


          GestureDetector(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, Electrical.idScreen, (route) => false);
            },
          child:  Card(
            child: ListTile(
              title: Text("Electrical"),
              subtitle: Text("Motley Crew"),
              leading: Image.network(
                  'https://images.unsplash.com/photo-1628093841756-f940f1fe0415?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80'),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
          ),
          ),


          GestureDetector(
          onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, Appliance.idScreen, (route) => false);
            },
          child: Card(
            child: ListTile(
              title: Text("Appliance"),
              subtitle: Text("Motley Crew"),
              leading: Image.network(
                  'https://images.unsplash.com/photo-1628093841756-f940f1fe0415?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80'),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
          ),
          ),


          GestureDetector(
          onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, PaintJob.idScreen, (route) => false);
            },
          child: Card(
            child: ListTile(
              title: Text("Paint"),
              subtitle: Text("Motley Crew"),
              leading: Image.network(
                  'https://images.unsplash.com/photo-1628093841756-f940f1fe0415?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80'),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
          ),
          ),


          GestureDetector(
          onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, Woodwork.idScreen, (route) => false);
            },
          child: Card(
            child: ListTile(
              title: Text("Woodwork"),
              subtitle: Text("Motley Crew"),
              leading: Image.network(
                  'https://images.unsplash.com/photo-1628093841756-f940f1fe0415?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80'),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
          ),
          ),


          GestureDetector(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, Tiling.idScreen, (route) => false);
            },
          child: Card(
            child: ListTile(
              title: Text("Tiling"),
              subtitle: Text("Motley Crew"),
              leading: Image.network(
                  'https://images.unsplash.com/photo-1628093841756-f940f1fe0415?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80'),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
          ),
          ),


          GestureDetector(
          onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, Glasswork.idScreen, (route) => false);
            },
          child: Card(
            child: ListTile(
              title: Text("Glasswork"),
              subtitle: Text("Motley Crew"),
              leading: Image.network(
                  'https://images.unsplash.com/photo-1628093841756-f940f1fe0415?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80'),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
          ),
          ),


          GestureDetector(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, Metalwork.idScreen, (route) => false);
            },
          child: Card(
            child: ListTile(
              title: Text("Metal"),
              subtitle: Text("Motley Crew"),
              leading: Image.network(
                  'https://images.unsplash.com/photo-1628093841756-f940f1fe0415?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80'),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
          ),
          ),
        ],
      ),
    );
  }
}
