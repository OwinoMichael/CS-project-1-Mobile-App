import 'package:blydev/screens/sp%20auth%20screens/Primary_screen.dart';
import 'package:flutter/material.dart';
import 'package:blydev/screens/sp%20user%20screens/navigation_bloc.dart';
import 'dart:developer';
import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:blydev/main.dart';
import 'package:path/path.dart' as Path;

import 'package:flutter/src/material/icon_button.dart';
import 'package:blydev/model/UserModel.dart' as u;
import 'package:blydev/screens/sp%20user%20screens/Landing_screen.dart';
import 'package:path/path.dart';

class MyAccount extends StatefulWidget with NavigationStates {
  const MyAccount({Key? key, this.user}) : super(key: key);
  final u.User? user;

  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    var _image;

    Future<dynamic> pickImage(BuildContext context) async {
      XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
      });
    }

    var _imageFile;

    Future uploadImage(BuildContext context) async {
      String fileName = basename(_imageFile.path);
      Reference storageReference =
          FirebaseStorage.instance.ref().child('users/profileimage$fileName');
      UploadTask uploadTask = storageReference.putData(_imageFile);
      
      TaskSnapshot taskSnapshot = await uploadTask;
      taskSnapshot.ref.getDownloadURL().then(
            (value) => print("Done: $value"),
          );
    }

    

    return Scaffold(
        appBar: AppBar(
          title: Text('My Account'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () => userAuth.logout().then(
                (value) {
                  if (value) {
                    Phoenix.rebirth(context);
                  } else {
                    log('Error logging out');
                  }
                },
              ),
            )
          ],
        ),
        body: Builder(
            builder: (context) => Container(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  pickImage(context);
                                },
                              ),
                              Align(
                                  alignment: Alignment.center,
                                  child: CircleAvatar(
                                    radius: 55,
                                    backgroundColor: Color(0xffFDCF09),
                                    child: _image != null
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: Image.file(
                                              _image,
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.fitHeight,
                                            ),
                                          )
                                        : Container(
                                            decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            width: 100,
                                            height: 100,
                                            child: Icon(
                                              Icons.camera_alt,
                                              color: Colors.grey[800],
                                            ),
                                          ),
                                  )),
                              SizedBox(
                                height: 1.0,
                              ),
                              Container(
                                margin: EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        children: <Widget>[
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text('Name',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20.0)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(widget.user!.name!,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    SizedBox(width: 10.0),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        child: Icon(
                                          FontAwesomeIcons.pen,
                                          color: Color(0xff476cfb),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Container(
                                margin: EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        children: <Widget>[
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text('Email',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20.0)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(widget.user!.email!,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    SizedBox(width: 5.0),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        child: Icon(
                                          FontAwesomeIcons.pen,
                                          color: Color(0xff476cfb),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Container(
                                margin: EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        children: <Widget>[
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text('Phone Number',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20.0)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(widget.user!.phone!,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    SizedBox(width: 20.0),
                                    Align(
                                      alignment: Alignment.centerRight,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                            ],
                          ))
                    ]))));
  }
}
