import 'dart:ui';

import 'package:blydev/screens/sp%20auth%20screens/forgot_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:blydev/main.dart';
import 'package:blydev/screens/sp user screens/Landing_screen.dart';
import 'package:blydev/screens/sp%20auth%20screens/Primary_screen.dart';
import 'package:blydev/widgets/progressDialog.dart';
import 'package:blydev/screens/sp auth screens/Sp_SignUp_screen.dart';

class SpLoginScreen extends StatefulWidget {
  static const String idScreen = "sp_login";

  @override
  _SpLoginScreenState createState() => _SpLoginScreenState();
}

class _SpLoginScreenState extends State<SpLoginScreen> {
  TextEditingController emailTextEditingController = TextEditingController();

  TextEditingController passwordTextEditingController = TextEditingController();

  bool _showEye = false;

  bool _passwordIsEncrypted = true;

  String _password = '';

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
              SizedBox(height: 35.0,),
              Image(
                image: AssetImage('./assets/images/image1.jpg'),
                width: 250.0,
                height: 250.0,
                alignment: Alignment.center,
                ),

              SizedBox(height: 1.0,),
              Text(
                'Login as Handyman',
                style: TextStyle(fontSize: 30.0, fontFamily: ""),
                textAlign: TextAlign.center
              ),

              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [

                    SizedBox(height: 1.0,),
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
                style: TextStyle(fontSize: 14.0,),
              ),


                SizedBox(height: 10.0,),


                    TextField(
                        controller: passwordTextEditingController,
                        obscureText: _showEye ? _passwordIsEncrypted : true,
                        onChanged: (enteredPassword) {
                          _password = enteredPassword;
                          if (enteredPassword.isEmpty) {
                            setState(() {
                              _showEye = false;
                            });
                          } else {
                            if (!_showEye) {
                              setState(() {
                                _showEye = !_showEye;
                              });
                            }
                          }
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: _showEye
                              ? GestureDetector(
                                  child: _passwordIsEncrypted
                                      ? Container(
                                          child: Icon(
                                            Icons.visibility,
                                            color: Colors.blueGrey,
                                          ),
                                        )
                                      : Container(
                                          child: Icon(
                                            Icons.visibility_off,
                                            color: Colors.deepPurple,
                                          ),
                                        ),
                                  onTap: () {
                                    setState(() {
                                      _passwordIsEncrypted =
                                          !_passwordIsEncrypted;
                                    });
                                  },
                                )
                              : null,
                          labelText: "Password",
                          labelStyle: TextStyle(
                            fontSize: 20.0,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 20.0,
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),

                SizedBox(height: 10.0,),

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
                    if(!emailTextEditingController.text.contains("@")){
                      displayToastMessage("Email Address is not valid", context);
                    }else if(passwordTextEditingController.text.length < 6){
                      displayToastMessage("Password must be atleast 6 characters", context);
                    }
                    else{
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
                          fontSize: 18.0,),
                ),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, ForgotPasswordScreen.idScreen, (route) => false);
                },
              ),

              SizedBox(height: 4.0,),

              FlatButton(
                child: Text(
                  "Don't have an Account? Register Here",
                  style: TextStyle(
                          fontSize: 18.0,),
                ),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, SpRegistrationScreen.idScreen, (route) => false);
                },
              ),
            ],
          ),
        ),
      )
      );
  }

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

void loginAndAuthentication( BuildContext context) async {

  showDialog(
    context: context, 
    barrierDismissible: false,
    builder: (BuildContext context){
      return ProgressDialog(message: "Authenticating, Please wait ...",);
    }
    );

   final  User? firebaseUser = ( await _firebaseAuth
        .signInWithEmailAndPassword(
          email: emailTextEditingController.text, 
          password: passwordTextEditingController.text
          ).catchError((errMsg){
            Navigator.pop(context);
            displayToastMessage("Error" + errMsg.toString(), context);
          })).user;
      
              if(firebaseUser != null){ //success
                 spRef.child(firebaseUser.uid).once().then((DataSnapshot snap){
                   if(snap.value != null){
                     Navigator.pushNamedAndRemoveUntil(context, PrimaryScreen.idScreen, (route) => false);
                     displayToastMessage("You are logged in now", context);
                   }
                   else{
                     Navigator.pop(context);
                     _firebaseAuth.signOut();
                     displayToastMessage("No record exists of this user. Please create a new Account", context);
                   }
                 });
              }else{
                Navigator.pop(context);
                //Error occured
                displayToastMessage("Error occured, can not be Signed In", context);
              }
        }

        displayToastMessage(String message, BuildContext context){
          Fluttertoast.showToast(msg: message);
        }
}