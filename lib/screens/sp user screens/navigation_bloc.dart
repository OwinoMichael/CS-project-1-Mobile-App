import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blydev/screens/sp%20user%20screens/Landing_screen.dart';
import 'package:blydev/screens/sp%20user%20screens/MyAccount_screen.dart';
import 'package:blydev/screens/sp%20user%20screens/SpOrder_screen.dart';

enum NavigationEvents {
  SpMainScreenClickedEvent, 
  MyAccountClickedEvent, 
  SpOrderScreenClickedEvent,
  }

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates>{
  NavigationBloc(NavigationStates initialState) : super(initialState);


  //@override
  NavigationStates get initialState => SpMainScreen();
  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch(event){
      case NavigationEvents.SpMainScreenClickedEvent: 
        yield SpMainScreen();
        break;

      case NavigationEvents.MyAccountClickedEvent:
        yield MyAccount();
        break;

      case NavigationEvents.SpOrderScreenClickedEvent:
        yield SpOrders();
        break;


    }
  }

} 