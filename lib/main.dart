import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:prdip/Controllers/UserAuth.dart';
import 'package:prdip/screens/Login_screen.dart';
import 'package:prdip/screens/SplashScreen.dart';
import 'package:prdip/screens/forgot_password.dart';
import 'package:prdip/screens/main_screen.dart';
import './screens/Registration_screen.dart';
import './screens/getting_started_screen.dart';
import 'model/UserModel.dart';

final UserAuth userAuth = new UserAuth();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(Phoenix(
      child: MyApp(),
    ),);
}

//Warning!!!! If you set the database location outside the default location i.e. USA, please give the URL instead of instance
DatabaseReference userRef = FirebaseDatabase(
        databaseURL:
            "https://prdip-2932d-default-rtdb.europe-west1.firebasedatabase.app/")
    .reference()
    .child("users");

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        home: FutureBuilder(
            future: userAuth.fetchUser(),
            builder: (context, AsyncSnapshot<User> snapShot) {
              if (snapShot.connectionState == ConnectionState.waiting) {
                return Splash();
              } else {
                if (snapShot.hasData) {
                  return MainScreen(
                    user: snapShot.data,
                  );
                } else {
                  return GettingStartedScreen();
                }
              }
            }),
        routes: {
          LoginScreen.routeName: (ctx) => LoginScreen(),
          RegistrationScreen.idScreen: (context) => RegistrationScreen(),
          LoginScreen.idScreen: (context) => LoginScreen(),
          MainScreen.idScreen: (context) => MainScreen(),
          ForgotPasswordScreen.idScreen: (context) => ForgotPasswordScreen(),
        });
  }
}
