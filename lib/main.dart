import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:prdip/screens/cl auth screens/Login_screen.dart';
import 'package:prdip/screens/cl auth screens/forgot_password.dart';
import 'package:prdip/screens/cl auth screens/main_screen.dart';
import './screens/cl auth screens/Registration_screen.dart';
import './screens/cl auth screens/getting_started_screen.dart';


void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();

  runApp(MyApp());
}
//Warning!!!! If you set the database location outside the default location i.e. USA, please give the URL instead of instance
 DatabaseReference userRef = FirebaseDatabase(databaseURL: "https://prdip-2932d-default-rtdb.europe-west1.firebasedatabase.app/").reference().child("users");


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        primarySwatch: Colors.deepPurple
      ),
      home: GettingStartedScreen(),
      routes: {
        LoginScreen.routeName: (ctx) => LoginScreen(),
        RegistrationScreen.idScreen: (context) => RegistrationScreen(),
        LoginScreen.idScreen: (context) => LoginScreen(),
        MainScreen.idScreen: (context) => MainScreen(),
        ForgotPasswordScreen.idScreen: (context) => ForgotPasswordScreen(),
      }
    );
  }
}

