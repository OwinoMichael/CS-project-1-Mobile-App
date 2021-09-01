import 'dart:async';
import 'dart:developer';
import 'package:async/async.dart';
import 'package:blydev/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blydev/screens/sp%20user%20screens/menu_item.dart';
import 'package:blydev/screens/sp%20user%20screens/navigation_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'dart:ffi';
import 'package:rxdart/rxdart.dart';
import 'package:blydev/model/UserModel.dart' as u;
import 'package:flutter/material.dart';

class Sidebar extends StatefulWidget with NavigationStates {
  const Sidebar({Key? key, this.user}) : super(key: key);
  final u.User? user;
 
  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> with SingleTickerProviderStateMixin<Sidebar>{
  late AnimationController _animationController;
  late StreamController<bool> isSidebarOpendedStreamController;
  late Stream<bool> isSidebarOpendedStream;
  late StreamSink<bool> isSidebarOpendedSink;
  //final bool isSidebarOpended = true;
  final _animationDuration = const Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
          vsync: this,
          duration: _animationDuration,
    );
    isSidebarOpendedStreamController = PublishSubject<bool>();
    isSidebarOpendedStream = isSidebarOpendedStreamController.stream;
    isSidebarOpendedSink = isSidebarOpendedStreamController.sink;
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpendedStreamController.close();
    isSidebarOpendedSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus =  _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;


    if(isAnimationCompleted){
      isSidebarOpendedSink.add(false);
      _animationController.reverse();
    }else{
      isSidebarOpendedSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {

    //late AnimationController _animationController;
    final screenWidth = MediaQuery.of(context).size.width;
    //final _animationDuration = const Duration(milliseconds: 500);

    return StreamBuilder<bool>(
      initialData: false,
      stream: isSidebarOpendedStream,
      builder: (context, isSideBarOpendedAsync){
        return AnimatedPositioned(
          top: 0,
          bottom: 0,
          left: isSideBarOpendedAsync.data! ? 0 : -screenWidth,
          right: isSideBarOpendedAsync.data! ? 0 : screenWidth - 45,
          duration: _animationDuration,


              child: Row(
                children: <Widget>[
                  Expanded(
                    
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      color: Colors.deepPurple,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 10,),
                          

                          Divider(
                            height: 64,
                            thickness: 0.5,
                            color: Colors.white.withOpacity(0.3),
                            indent: 32,
                            endIndent: 32,
                          ),

                          MenuItem(
                            icon: Icons.home,
                            title: "Home",
                            onTap: () {
                              onIconPressed();
                              BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.SpMainScreenClickedEvent);
                              
                            }
                          ),
                          MenuItem(
                            icon: Icons.person,
                            title: "My Account",
                            onTap: () {
                              onIconPressed();
                              BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.MyAccountClickedEvent);
                            },
                          ),
                          MenuItem(
                            icon: Icons.history,
                            title: "My Orders",
                            onTap: () {
                              onIconPressed();
                            BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.SpOrderScreenClickedEvent);
                            },
                          ),

                          Divider(
                            height: 64,
                            thickness: 0.5,
                            color: Colors.white.withOpacity(0.3),
                            indent: 32,
                            endIndent: 32,
                          ),

                          MenuItem(
                            icon: Icons.exit_to_app,
                            title: "Logout",
                            onTap:  () => userAuth.logout().then(
                              (value) {
                                if (value) {
                                  Phoenix.rebirth(context);
                                } else {
                                  log('Error logging out');
                                }
                              },
                            ),



                          ),

                        ],
                      ),
                    ),
                  ),
                  
                  Align(
                    alignment: Alignment(0, -0.9),
                    

                    child: GestureDetector(
                      onTap: () {
                        onIconPressed();
                      },
                      child: ClipPath(
                        clipper: CustomMenuClipper(),
                        child: Container(
                        width: 35,
                        height: 110,
                        color: Colors.deepPurple,
                        alignment: Alignment.centerLeft,
                        child: 
                          AnimatedIcon(
                            progress: _animationController.view,
                            icon: AnimatedIcons.menu_close,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
          
                  ),

                ],
              )
        );
      },
          
    );
  }
}

class CustomMenuClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
      Paint paint = Paint();
      paint.color = Colors.white;
      final width =  size.width;
      final height = size.height;

      Path path = Path();
      path.moveTo(0, 0);
      path.quadraticBezierTo(0, 8, 10, 16);
      path.quadraticBezierTo(width-1, height/2- 20, width, height/2);
      path.quadraticBezierTo(width+1, height/2+ 20, 10, height-16);
      path.quadraticBezierTo(0, height - 8, 0, height);

      path.close();

    return path;
      
    }
  
    @override
    bool shouldReclip( CustomClipper<Path> oldClipper) {
    return true;
  }
}
