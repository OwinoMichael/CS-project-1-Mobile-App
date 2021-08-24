import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:prdip/screens/cl%20user%20screens/ServiceList/appliance.dart';
import 'package:prdip/screens/cl%20user%20screens/ServiceList/electrical.dart';
import 'package:prdip/screens/cl%20user%20screens/ServiceList/glasswork.dart';
import 'package:prdip/screens/cl%20user%20screens/ServiceList/metalwork.dart';
import 'package:prdip/screens/cl%20user%20screens/ServiceList/paintjob.dart';
import 'package:prdip/screens/cl%20user%20screens/ServiceList/plumbing.dart';
import 'package:prdip/screens/cl%20user%20screens/ServiceList/tiling.dart';
import 'package:prdip/screens/cl%20user%20screens/ServiceList/woodwork.dart';

class HomeScreen extends StatefulWidget {

 static const String idScreen = "homie";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Home Screen'),
      // ),
      body: 
        SingleChildScrollView(child: 
        Column(
        children: <Widget>[
          Container(
            height: 277,
            width: 411.5,
            child: 
              Image.asset('./assets/images/handyman1.jpg', 
              fit: BoxFit.contain,)
          ),
          SizedBox( height: 10,),

          Text("In demand", style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            //fontWeight: FontWeight.normal,
            //backgroundColor: Colors.white,
            //decoration: TextDecoration.underline,
            //wordSpacing: 10.0,
            // shadows: [
            //   Shadow(
            //     color: Colors.deepPurple,
            //     blurRadius: 2.0,
            //     offset: Offset(1,1),
            //   ),
            // ],
          ),
          ),

          SizedBox( height: 10,),

          CarouselSlider(
            
            items: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                        context, Plumbing.idScreen, (route) => false);
                },
                child:  Container(
                    height: 180,
                    width: 360,
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: AssetImage('./assets/images/plumbing.jpg',),
                      fit: BoxFit.cover,
                        ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Plumbing', 
                            style: TextStyle(
                              backgroundColor: Colors.white,
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.bold,
                              fontSize: 22.0,
                            ),
                          ),
                        )
                      ],
                    ),
              ),
              ),

              GestureDetector(child:  Container(
                height: 180,
                width: 360,
                margin: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: AssetImage('./assets/images/electrical.jpg',),
                   fit: BoxFit.cover,
                    ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Electrical works', 
                        style: TextStyle(
                          backgroundColor: Colors.white,
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, Electrical.idScreen, (route) => false);
                  },
              ),

              GestureDetector(child: Container(
                height: 180,
                width: 360,
                margin: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: AssetImage('./assets/images/woodwork.jpg',),
                   fit: BoxFit.cover,
                    ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Woodwork', 
                        style: TextStyle(
                          backgroundColor: Colors.white,
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, Woodwork.idScreen, (route) => false);
                  },
              ), 


              GestureDetector(child:  Container(
                height: 180,
                width: 360,
                margin: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: AssetImage('./assets/images/appliance.jpg',),
                   fit: BoxFit.cover,
                    ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Appliance Fixing', 
                        style: TextStyle(
                          backgroundColor: Colors.white,
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, Appliance.idScreen, (route) => false);
                  },
              ),


            ], 
            options: CarouselOptions(
              height: 180.0,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16/9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
            
            ),

          SizedBox( height: 10,),

          Text("Latest", style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            //fontWeight: FontWeight.normal,
            //backgroundColor: Colors.white,
            //decoration: TextDecoration.underline,
            //wordSpacing: 10.0,
            // shadows: [
            //   Shadow(
            //     color: Colors.deepPurple,
            //     blurRadius: 2.0,
            //     offset: Offset(1,1),
            //   ),
            // ],
          ),),

          SizedBox( height: 10,),
            
          CarouselSlider(
            
            items: [
              GestureDetector(child:  Container(
                height: 180,
                width: 360,
                margin: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: AssetImage('./assets/images/paintjob.jpg',),
                   fit: BoxFit.cover,
                    ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Paint Job', 
                        style: TextStyle(
                          backgroundColor: Colors.white,
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, PaintJob.idScreen, (route) => false);
                  },
              ),

              GestureDetector(child:  Container(
                height: 180,
                width: 360,
                margin: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: AssetImage('./assets/images/tiler.jpg',),
                   fit: BoxFit.cover,
                    ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Floor Tiles', 
                        style: TextStyle(
                          backgroundColor: Colors.white,
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, Tiling.idScreen, (route) => false);
                  },
              ),

              GestureDetector( child:  Container(
                height: 180,
                width: 360,
                margin: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: AssetImage('./assets/images/metalworks.jpg',),
                   fit: BoxFit.cover,
                    ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Metalworks', 
                        style: TextStyle(
                          backgroundColor: Colors.white,
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, Metalwork.idScreen, (route) => false);
                  },
              ),


              GestureDetector(child: Container(
                height: 180,
                width: 360,
                margin: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: 
                    DecorationImage(
                    image: AssetImage('./assets/images/glasswork.jpg',),
                   fit: BoxFit.cover,
                    ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Glasswork', 
                        style: TextStyle(
                          backgroundColor: Colors.white,
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, Glasswork.idScreen, (route) => false);
                  },
              ), 


            ], 
            options: CarouselOptions(
              height: 180.0,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16/9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
            
            ),

        ],
        ),
        ),
        
    );
  }
}