import 'package:blydev/screens/sp%20auth%20screens/Sp_Login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class ForgotPasswordScreen extends StatelessWidget {
  TextEditingController editController = TextEditingController();
  static const String idScreen = "forgot";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password"),
        ),
        body: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: editController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: "Email",
                  hintText: "Enter Email",
                  border: OutlineInputBorder(),
                )
              ),
              
              SizedBox(height: 10,),

              Container(
                width: double.infinity,
                child: RaisedButton(
                  color: Colors.deepPurple,
                  onPressed: (){
                    if(!editController.text.contains("@")){
                    Fluttertoast.showToast(msg: "Enter valid Email");
                    return;
                  }else{
                     resetPassword(context);
                  }
                   
                  },
                  child: Text("Reset Password", 
                    style: TextStyle(
                      color: Colors.white,
                    ),),
                  ),
              ),

              SizedBox(height: 10,),

              Container(
                width: double.infinity,
                child: RaisedButton(
                  color: Colors.deepPurple,
                  onPressed: (){
                   Navigator.pushNamedAndRemoveUntil(context, SpLoginScreen.idScreen, (route) => false);
                  },
                  child: Text("Back to Login", 
                    style: TextStyle(
                      color: Colors.white,
                    ),),
                  ),
              )
              
            ],
          ),
        ),
    );
  }

  void resetPassword(BuildContext context) async {
    // if(!editController.text.contains("@")){
    //   Fluttertoast.showToast(msg: "Enter valid Email");
    //   return;
    // }

   await FirebaseAuth.instance
    .sendPasswordResetEmail(email: editController.text);
    Fluttertoast.showToast(
      msg: 
      "Reset password link has been sent to your email, please use it to change your password"
      );
      //Navigator.pop(context);
  }

}