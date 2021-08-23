import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prdip/DataHandler/appData.dart';
import 'package:prdip/screens/cl auth screens/Login_screen.dart';
import 'package:prdip/screens/cl auth screens/forgot_password.dart';
import 'package:prdip/screens/cl auth screens/main_screen.dart';
import 'package:prdip/screens/cl%20auth%20screens/SplashScreen.dart';
import 'package:prdip/screens/cl%20user%20screens/Maps/plumberMap.dart';
import 'package:prdip/screens/cl%20user%20screens/ServiceList/appliance.dart';
import 'package:prdip/screens/cl%20user%20screens/ServiceList/electrical.dart';
import 'package:prdip/screens/cl%20user%20screens/ServiceList/glasswork.dart';
import 'package:prdip/screens/cl%20user%20screens/ServiceList/metalwork.dart';
import 'package:prdip/screens/cl%20user%20screens/ServiceList/paintjob.dart';
import 'package:prdip/screens/cl%20user%20screens/ServiceList/plumbing.dart';
import 'package:prdip/screens/cl%20user%20screens/ServiceList/tiling.dart';
import 'package:prdip/screens/cl%20user%20screens/ServiceList/woodwork.dart';
import 'package:prdip/screens/cl%20user%20screens/search_screen.dart';
import 'package:provider/provider.dart';
import './screens/cl auth screens/Registration_screen.dart';
import './screens/cl auth screens/getting_started_screen.dart';
import 'package:prdip/Controllers/UserAuth.dart';
import 'model/UserModel.dart';


final UserAuth userAuth = new UserAuth();
void main() async
{
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
 DatabaseReference userRef = FirebaseDatabase(databaseURL: "https://prdip-2932d-default-rtdb.europe-west1.firebasedatabase.app/").reference().child("client-users");
 DatabaseReference spRef = FirebaseDatabase(databaseURL: "https://prdip-2932d-default-rtdb.europe-west1.firebasedatabase.app/").reference().child("serviceProvider-users");

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      
      create: (context) => AppData(),
       child:  MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
           textTheme:
                  GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
          primarySwatch: Colors.deepPurple
        ),
       
        //home: GettingStartedScreen(),
        home: FutureBuilder(
              future: userAuth.fetchUser(),
              builder: (context, AsyncSnapshot<User> snapShot) {
                if (snapShot.connectionState == ConnectionState.waiting) {
                  return Splash();
                } else {
                  if (snapShot.hasData) {
                    return MainScreen(
                      //user: snapShot.data,
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
          SearchScreen.idScreen: (context) => SearchScreen(),
          Plumbing.idScreen: (context) => Plumbing(),
          Appliance.idScreen: (context) => Appliance(),
          Electrical.idScreen: (context) => Electrical(),
          Glasswork.idScreen: (context) => Glasswork(),
          Metalwork.idScreen: (context) => Metalwork(),
          PaintJob.idScreen: (context) => PaintJob(),
          Tiling.idScreen: (context) => Tiling(),
          Woodwork.idScreen: (context) => Woodwork(),
          PlumberMap.idScreen: (context) => PlumberMap(),
    
        }
      )
      );
  }
}

