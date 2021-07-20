import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prdip/main.dart';
import 'package:prdip/model/UserModel.dart' as u;
import 'package:prdip/screens/forgot_password.dart';
import 'package:prdip/screens/main_screen.dart';
import 'package:prdip/widgets/progressDialog.dart';
import 'Registration_screen.dart';

class LoginScreen extends StatelessWidget {
  static const String idScreen = "login";
  DatabaseReference userRef = FirebaseDatabase(
          databaseURL:
              "https://prdip-2932d-default-rtdb.europe-west1.firebasedatabase.app/")
      .reference()
      .child("users");
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  static const routeName = '/login';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 35.0,
                ),
                Image(
                  image: AssetImage('./assets/images/image1.jpg'),
                  width: 250.0,
                  height: 250.0,
                  alignment: Alignment.center,
                ),
                SizedBox(
                  height: 1.0,
                ),
                Text('Login',
                    style: TextStyle(fontSize: 30.0, fontFamily: ""),
                    textAlign: TextAlign.center),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 1.0,
                      ),
                      TextField(
                        controller: emailTextEditingController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          labelText: "Email",
                          labelStyle: TextStyle(
                            fontSize: 25.0,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 25.0,
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                        controller: passwordTextEditingController,
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                            },
                            child: Icon(
                              Icons.visibility,
                              color: Colors.black,
                            ),
                          ),
                          labelText: "Password",
                          labelStyle: TextStyle(
                            fontSize: 25.0,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 25.0,
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      RaisedButton(
                        color: Colors.deepPurple,
                        textColor: Colors.white,
                        child: Container(
                          height: 50.0,
                          child: Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 25.0,
                                fontFamily: "",
                              ),
                            ),
                          ),
                        ),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(24.0),
                        ),
                        onPressed: () {
                          if (!emailTextEditingController.text.contains("@")) {
                            displayToastMessage(
                                "Email Address is not valid", context);
                          } else if (passwordTextEditingController.text.length <
                              6) {
                            displayToastMessage(
                                "Password must be atleast 6 characters",
                                context);
                          } else {
                            loginAndAuthentication(context);
                          }
                        },
                      )
                    ],
                  ),
                ),
                FlatButton(
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context,
                        ForgotPasswordScreen.idScreen, (route) => false);
                  },
                ),
                SizedBox(
                  height: 4.0,
                ),
                FlatButton(
                  child: Text(
                    "Don't have an Account? Register Here",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, RegistrationScreen.idScreen, (route) => false);
                  },
                ),
              ],
            ),
          ),
        ));
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void loginAndAuthentication(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(
            message: "Authenticating, Please wait ...",
          );
        });

    final User? firebaseUser = (await _firebaseAuth
            .signInWithEmailAndPassword(
                email: emailTextEditingController.text,
                password: passwordTextEditingController.text)
            .catchError((errMsg) {
      Navigator.pop(context);
      displayToastMessage("Error" + errMsg.toString(), context);
    }))
        .user;

    if (firebaseUser != null) {
      //success
      userRef.child(firebaseUser.uid).once().then((DataSnapshot snap) {
        if (snap.value != null) {
          log(snap.value.toString());

          try {
            // Map<String, dynamic> map = json.decode(snap.value.toString());
            Map<String, dynamic> map = Map<String, dynamic>.from(snap.value);
            u.User user = u.User.fromMap(map);
            userAuth.saveUser(user: user);
          } catch (e) {
            log('ERROR IS : $e');
          }
          Navigator.pushNamedAndRemoveUntil(
              context, MainScreen.idScreen, (route) => false);
          displayToastMessage("You are logged in now", context);
        } else {
          Navigator.pop(context);
          _firebaseAuth.signOut();
          displayToastMessage(
              "No record exists of this user. Please create a new Account",
              context);
        }
      });
    } else {
      Navigator.pop(context);
      //Error occured
      displayToastMessage("Error occured, can not be Signed In", context);
    }
  }

  displayToastMessage(String message, BuildContext context) {
    Fluttertoast.showToast(msg: message);
  }
}
