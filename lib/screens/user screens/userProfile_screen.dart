import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:prdip/main.dart';
import 'package:prdip/model/UserModel.dart' as u;

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key, this.user}) : super(key: key);
  final u.User? user;

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // final fb = FirebaseDatabase.instance;
  // var retrieveName="";
  // var retrieveEmail="";
  // var retrievePhone="";

  // String name = "";
  // String email = "";
  // String phone = "";

  @override
  Widget build(BuildContext context) {
    // Stream<String> get onAuthStateChanged => _firebaseAuth.authStateChanges().map(
    //     (User? user) => user?.uid,
    //   );
    //  Stream<String> get;
    //  get = onAuthStateChanged => _firebaseAuth.authStateChanges().map((User? user) => user?.uid,);

    //    String getCurrentUID() {
    //   return _firebaseAuth.currentUser!.uid;
    //   }
    //    // GET CURRENT USER
    // Future getCurrentUser() async {
    //   return _firebaseAuth.currentUser;
    // }

    // Future<UserModel> getUser() async {
    //   var firebaseUser = await _auth.currentUser();
    //   return UserModel(firebaseUser.uid, displayName: firebaseUser.displayName);
    // }

    DatabaseReference ref = FirebaseDatabase(
            databaseURL:
                "https://prdip-2932d-default-rtdb.europe-west1.firebasedatabase.app/")
        .reference()
        .child("users");

    // ref.child(getCurrentUID()).once().then((DataSnapshot data){
    // setState(() {
    //         retrieveName=data.value;
    //         // retrieveEmail=data.value;
    //         // retrievePhone=data.value;
    //       });
    //     });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(widget.user!.name!),
            IconButton(
                onPressed: () => userAuth.logout().then((value) {
                      if (value) {
                        Phoenix.rebirth(context);
                      } else {
                        log('ERROR LOGING OUT');
                      }
                    }),
                icon: Icon(Icons.logout)),
            Text("Hey"),
            Text("Hey"),
            //Text(retrieveName),
            // Text(retrieveEmail),
            // Text(retrievePhone),
          ],
        ),
      ),
    );
  }
}
