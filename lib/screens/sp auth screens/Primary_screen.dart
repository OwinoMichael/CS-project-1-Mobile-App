import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, BlocProvider;
import 'package:blydev/screens/sp user screens/sidebar.dart';
import 'package:blydev/screens/sp%20user%20screens/Landing_screen.dart';
import 'package:blydev/screens/sp%20user%20screens/SpOrder_screen.dart';
import 'package:blydev/screens/sp%20user%20screens/navigation_bloc.dart';


class PrimaryScreen extends StatelessWidget {
static const String idScreen = "sp_main";

  NavigationStates get initialState => SpMainScreen();

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<NavigationBloc>(
          create: (context) => NavigationBloc(initialState),
          child: Stack(
            children: <Widget>[
              BlocBuilder<NavigationBloc, NavigationStates>(
                builder: (context, navigationState) {
                  return navigationState as Widget;
                },
              ),
              Sidebar(),
            ],
          ),
        ),

    );
  
  }
}