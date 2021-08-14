import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/sp auth screens/Primary_screen.dart';
import 'screens/sp auth screens/Sp_Login_screen.dart';
import 'screens/sp auth screens/Sp_SignUp_screen.dart';
import 'screens/sp auth screens/SplashScreen.dart';
import 'screens/sp auth screens/forgot_password.dart';
import 'screens/sp auth screens/getting_started_screen.dart';
import 'screens/sp user screens/Landing_screen.dart';
import 'model/UserModel.dart';
import 'package:blydev/controllers/userAuth.dart';

final UserAuth userAuth = new UserAuth();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //runApp(MyApp());
  runApp(
    Phoenix(
      child: MyApp(),
    ),
  );
}

//Warning!!!! If you set the database location outside the default location i.e. USA, please give the URL instead of instance
// DatabaseReference userRef = FirebaseDatabase(
//         databaseURL:
//             "https://prdip-2932d-default-rtdb.europe-west1.firebasedatabase.app/")
//     .reference()
//     .child("client-users");
DatabaseReference spRef = FirebaseDatabase(
        databaseURL:
            "https://prdip-2932d-default-rtdb.europe-west1.firebasedatabase.app/")
    .reference()
    .child("serviceProvider-users");

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            textTheme:
                GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
            primarySwatch: Colors.deepPurple),

        //home: GettingStartedScreen(),
        home: FutureBuilder(
            future: userAuth.fetchUser(),
            builder: (context, AsyncSnapshot<User> snapShot) {
              if (snapShot.connectionState == ConnectionState.waiting) {
                return Splash();
              } else {
                if (snapShot.hasData) {
                  return PrimaryScreen(
                      //user: snapShot.data,
                      );
                } else {
                  return GettingStartedScreen();
                }
              }
            }),
        routes: {
          //SpLoginScreen.routeName: (ctx) => SpLoginScreen(),
          ForgotPasswordScreen.idScreen: (context) => ForgotPasswordScreen(),
          SpLoginScreen.idScreen: (context) => SpLoginScreen(),
          SpRegistrationScreen.idScreen: (context) => SpRegistrationScreen(),
          PrimaryScreen.idScreen: (context) => PrimaryScreen(),
        });
  }
}
