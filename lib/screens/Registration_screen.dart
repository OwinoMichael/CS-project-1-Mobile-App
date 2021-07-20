import 'dart:developer';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prdip/Controllers/UserAuth.dart';
import 'package:prdip/main.dart';
import 'package:prdip/model/UserModel.dart' as u;
import 'package:prdip/screens/main_screen.dart';
import 'package:prdip/screens/verify.dart';
import 'package:prdip/widgets/progressDialog.dart';

import 'Login_screen.dart';

final UserAuth _userAuth = new UserAuth();

class RegistrationScreen extends StatefulWidget {
  static const String idScreen = "register";

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController nameTextEditingController = TextEditingController();

  TextEditingController emailTextEditingController = TextEditingController();

  TextEditingController phoneTextEditingController = TextEditingController();

  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Future getImage() async{
    //   var image= await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    //   //var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    //   setState(() {
    //     _image=image as File;
    //   });
    // }

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
                Text('Register an Account',
                    style: TextStyle(fontSize: 30.0, fontFamily: ""),
                    textAlign: TextAlign.center),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      //  Row(
                      //    mainAxisAlignment: MainAxisAlignment.center,
                      //    children: <Widget>[
                      //      Align(
                      //        alignment: Alignment.center,
                      //        child:CircleAvatar(
                      //          radius: 100,
                      //          backgroundColor: Colors.deepPurple,
                      //          child: ClipOval(
                      //            child: SizedBox(
                      //              width: 100,
                      //              height: 100,
                      //              child: (_image!=null)?Image.file(_image, fit: BoxFit.fill)
                      //              :Image.network(
                      //                "https://images.unsplash.com/photo-1514316454349-750a7fd3da3a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80",
                      //                fit: BoxFit.fill,
                      //                ),
                      //            ),
                      //            ),
                      //        )
                      //      ),
                      //      Padding(
                      //        padding: EdgeInsets.only(top: 60.0),
                      //        child: IconButton(
                      //          icon: Icon(
                      //            FontAwesomeIcons.camera,
                      //            size: 30.0,
                      //          ),
                      //          onPressed: () {
                      //            getImage();
                      //           },
                      //          ),
                      //          )
                      //    ],

                      // ),

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
                        context, LoginScreen.idScreen, (route) => false);
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
      //success
      //save info to DB
      Map<String, dynamic> userDataMap = {
        "name": nameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text.trim(),
      };

      log(userDataMap.toString());

      userRef.child(firebaseUser.uid).set(userDataMap);
      displayToastMessage(
          "Congratulations, your account has been created.", context);
      u.User user = u.User.fromMap(userDataMap);
      _userAuth.saveUser(user: user);
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
