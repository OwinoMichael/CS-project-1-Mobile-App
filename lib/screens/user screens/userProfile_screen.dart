import 'dart:developer';
import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:prdip/main.dart';
import 'package:path/path.dart';


import 'package:flutter/src/material/icon_button.dart';
import 'package:prdip/model/UserModel.dart' as u;
import 'package:prdip/screens/user%20screens/home_screen.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key, this.user}) : super(key: key);
  final u.User? user;

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  // late File _image;
  @override
  Widget build(BuildContext context) {
  //    final picker = ImagePicker();

  // Future <dynamic>pickImage({required ImageSource source}) async {
  //   final imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if(imageFile != null){
  //     setState(() {
      
  //     File image = File(imageFile.path);
  //   });
  // }
  //   }

    
  //  var _imageFile;
  //  _imageFile as File;


  // Future <dynamic>uploadImageToFirebase(BuildContext context) async {
  //   String fileName = _imageFile.path;
  //   Reference firebaseStorageRef =
  //       FirebaseStorage.instance.ref().child('profile-image/$fileName');
  //   UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
  //   TaskSnapshot taskSnapshot = await uploadTask;
  //   taskSnapshot.ref.getDownloadURL().then(
  //         (value) => print("Done: $value"),
  //       );
  // }

    return Scaffold(
        appBar: AppBar(
          title: Text('User Profile'),
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
                      
                      
                      Container(
                margin: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Name',
                        style:
                            TextStyle(color: Colors.black, fontSize: 40.0)),
                        ),
                      ],),
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Email',
                        style:
                            TextStyle(color: Colors.black, fontSize: 40.0)),
                        ),
                      ],),
                    ),
                     Align(
                            alignment: Alignment.centerLeft,
                            child: Text(widget.user!.email!,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold)),
                          ),
                    SizedBox(width: 20.0),
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Phone Number',
                        style:
                            TextStyle(color: Colors.black, fontSize: 40.0)),
                        ),
                      ],),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    color: Color(0xff476cfb),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    elevation: 4.0,
                    splashColor: Colors.blueGrey,
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ),
                  RaisedButton(
                    color: Color(0xff476cfb),
                    onPressed: () {
                    Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()));
                    },
                                     
                    elevation: 4.0,
                    splashColor: Colors.blueGrey,
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                      
                    ),
                    
                    
                  ),
                  
                                ]),
                        ])
                            )
    ));
                   
  }
}


