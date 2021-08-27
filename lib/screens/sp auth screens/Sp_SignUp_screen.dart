import 'dart:convert';
import 'dart:ui';
import 'package:blydev/screens/sp%20auth%20screens/verify.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:blydev/main.dart';
import 'package:blydev/screens/sp user screens/Landing_screen.dart';
import 'package:blydev/screens/sp%20auth%20screens/Primary_screen.dart';
import 'package:blydev/widgets/progressDialog.dart';
import 'package:blydev/screens/sp auth screens/Sp_Login_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class SpRegistrationScreen extends StatefulWidget {
  static const String idScreen = "sp_register";

  @override
  _SpRegistrationScreenState createState() => _SpRegistrationScreenState();
}

class _SpRegistrationScreenState extends State<SpRegistrationScreen> {
  TextEditingController nameTextEditingController = TextEditingController();

  TextEditingController emailTextEditingController = TextEditingController();

  TextEditingController phoneTextEditingController = TextEditingController();

  TextEditingController passwordTextEditingController = TextEditingController();

  TextEditingController serviceTextEditingController = TextEditingController();

  bool _showEye = false;

  bool _passwordIsEncrypted = true;

  String latitudeData = "";
  String longitudeData = "";

  String _password = '';

  final items = [
    "Plumbing","Electrical","Tiling","Woodwork","Glasswork","Paint Job","Metalworks"];
  String? value;

  DropdownMenuItem<String> buildMenuItem(String item) =>
    DropdownMenuItem(
      value: item,
      child: Text(
        item, 
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,),
      ),
    );

  String _timeString = "";

  void _getTime() {
    final String formattedDateTime =
        DateFormat('yyyy-MM-dd \n kk:mm:ss').format(DateTime.now()).toString();
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  
  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    _getTime();
  }

  getCurrentLocation() async {
    final geoposition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high ); 

    setState(() {
      latitudeData = '${geoposition.latitude}';
      longitudeData = '${geoposition.longitude}';
    });
  }
   
   String ? formattedDate;

  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
        appBar: AppBar(
          title: Text('Sign Up'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 25.0,
                ),
                Image(
                  image: AssetImage('./assets/images/image1.jpg'),
                  width: 130.0,
                  height: 130.0,
                  alignment: Alignment.center,
                ),
                SizedBox(
                  height: 1.0,
                ),
                Text('Register an Account as Handyman',
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
                        controller: nameTextEditingController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: "Name",
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
                        height: 1.0,
                      ),
                      TextField(
                        controller: phoneTextEditingController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          labelText: "Phone",
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

                      DropdownButton<String>(

                        //hint: Text("Select Service"),
                        value: value,
                        iconSize: 26,
                        icon: Icon(Icons.keyboard_arrow_down,
                            color: Colors.black),
                        items: items.map(buildMenuItem).toList(),
                        onChanged: (value) => this.value = value,
                      ),

                      SizedBox(
                        height: 10.0,
                      ),

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
                              "Register",
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
                          if (nameTextEditingController.text.length < 4) {
                            displayToastMessage(
                                "Name must be atleast 4 characters", context);
                          } else if (!emailTextEditingController.text
                              .contains("@")) {
                            displayToastMessage(
                                "Email Address is not valid", context);
                          } else if (phoneTextEditingController.text.length <
                              10) {
                            displayToastMessage(
                                "Phone Number is not valid, must be atleast 10 characters",
                                context);
                          } else if (passwordTextEditingController.text.length <
                              6) {
                            displayToastMessage(
                                "Password must be atleast 6 characters",
                                context);
                          } else {
                            registerNewUser(context);
                          }
                        },
                      )
                    ],
                  ),
                ),
                FlatButton(
                  child: Text(
                    "Already have an Account? Login Here",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, SpLoginScreen.idScreen, (route) => false);
                  },
                ),
              ],
            ),
          ),
        ));

    
  }


  

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void registerNewUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(
            message: "Registering, Please wait ...",
          );
        });

    final User? firebaseUser = (await _firebaseAuth
            .createUserWithEmailAndPassword(
                email: emailTextEditingController.text,
                password: passwordTextEditingController.text)
            .catchError((errMsg) {
      Navigator.pop(context);
      displayToastMessage("Error" + errMsg.toString(), context);
    }))
        .user;
    

    if (firebaseUser != null) {
      
      Map userDataMap = {
        "time": _timeString,
        "name": nameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text.trim(),
        "service" : value,
        "latitude": latitudeData,
        "longitude": longitudeData,
        
      };

      spRef.child(firebaseUser.uid).set(userDataMap);

      displayToastMessage(
          "Congratulations, your account has been created.", context);
      // Navigator.pushNamedAndRemoveUntil(
      //     context, PrimaryScreen.idScreen, (route) => false);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => VerifyEmail()));
    } else {
      Navigator.pop(context);
      //Error occured
      displayToastMessage("New User Account has not been created", context);
    }
  }

  displayToastMessage(String message, BuildContext context) {
    Fluttertoast.showToast(msg: message);
  }
}


