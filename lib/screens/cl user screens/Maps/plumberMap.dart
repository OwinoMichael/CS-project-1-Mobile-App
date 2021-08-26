import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prdip/Assistants/assistantMethods.dart';
import 'package:prdip/Assistants/requestAssistant.dart';
import 'package:prdip/DataHandler/appData.dart';
import 'package:prdip/model/address.dart';
import 'package:prdip/model/handymanData.dart';
import 'package:prdip/screens/cl%20auth%20screens/main_screen.dart';
import 'package:prdip/screens/cl%20user%20screens/Maps/search_map.dart';
import 'package:prdip/screens/cl%20user%20screens/home_screen.dart';
import 'package:prdip/screens/cl%20user%20screens/orders_screen.dart';
import 'package:prdip/screens/cl%20user%20screens/search_screen.dart';
import 'package:prdip/screens/cl%20user%20screens/userProfile_screen.dart';
import 'package:prdip/widgets/Divider.dart';
import 'package:prdip/widgets/progressDialog.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:animated_text_kit/animated_text_kit.dart';


import 'configMaps.dart';

class MapView extends StatefulWidget {

  static const String idScreen = "mapview";
  const MapView({ Key? key }) : super(key: key);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> with TickerProviderStateMixin {

  
  final items = [
    "Plumbing","Electrical","Tiling","Woodwork","Glasswork","Paint Job","Metalworks"];
  String ? value;

  String ? brz;

  Completer<GoogleMapController> _controllerGoogleMap = Completer();

  List<LatLng> pLineCoordinates = [];
  Set<Polyline> polylineSet = {};

  late GoogleMapController NewGoogleMapController;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  late Position currentPosition;
  var geoLocator = Geolocator();
  double bottomPaddingOfMap = 0;
  double topPaddingOfMap = 0;

  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};

  double rideDetailsContainer = 0;
  double rideRequestContainer = 0;
  double searchContainerHeight = 260.0;


  void displayRideDetailsContainer() async {

    await getPlaceDirection();

    setState(() {
      searchContainerHeight = 0;
      rideDetailsContainer = 240;
      bottomPaddingOfMap = 270;
      double topPaddingOfMap = 30;
    });
  }
  void displayRequestRideContainer(){
    setState(() {
      rideRequestContainer = 274.0;
      rideDetailsContainer = 0;
       bottomPaddingOfMap = 270;
    });
  }

  resetApp(){
    setState(() {
      searchContainerHeight = 260;
      rideDetailsContainer = 0;
      rideRequestContainer = 0;
      bottomPaddingOfMap = 270;
    });
  }

  String ? address;
  
  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latLatPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition = new CameraPosition(target: latLatPosition, zoom: 14);
    NewGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

   String address = await AssitantMethods.searchCoordinateAddress(position, context);
    print("This is your Address :: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX---------***********************%%??????????????????????@@@@@@@@@@" + address);
  }

  //********************************************************* */

  final double range = 500;

  double nowlat = 0;
  double nowLon = 0; // users current location

  getCurrentLocation() async { //fetch users current location
    final geoposition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    nowlat = geoposition.latitude;
    nowLon = geoposition.longitude;
  }

  String service = 'plumber'; //////
  
  final spHandy = FirebaseDatabase(
          databaseURL:
              "https://prdip-2932d-default-rtdb.europe-west1.firebasedatabase.app/")
      .reference()
      .child("serviceProvider-users");

  @override
  void initState() {
   
    super.initState();
    getAvailble();
  }

  void getHandymanData(){
    spHandy.once().then((DataSnapshot snap){
    var data=snap.value;
     data.forEach((key, value){

       Handymen handy = new Handymen(
         Hid: value['id'],
         name: value['name'],
         contact: value['phone'],
         lat: value['latitude'],
         lon: value['longitude'],
         servicepro: value['service'],
        );
      setState(() {
        handyMen.add(handy);
      });
      });
      getAvailble();
    });
  }

  List<Handymen> handyMen = []; //! from db

  List<Handymen> availableMen = []; //! availble;


  double calculateDistance({clientsLat, clientLon, handymanLat, handymanLon}) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
       c((handymanLat - clientsLat) * p) / 2 +
        c(clientsLat * p) *
            c(handymanLat * p) *
            (1 - c((handymanLon - clientLon) * p)) /
            2;
    return 12742 * asin(sqrt(a));
  }

  getAvailble() { // to fetchHandymen
    handyMen.forEach((man) {
      double d = calculateDistance(
          clientsLat: nowlat,
          clientLon: nowLon,
          handymanLat: man.lat,
          handymanLon: man.lon);
      if (d <= range) {
        availableMen.add(man);
      }
    });
  }

  List<Handymen> filtered = [];

  filterHandmen() { //
   setState(() {
     filtered = availableMen
          .where((element) => element.servicepro == service)
          .toList();

      if (filtered.isEmpty) {
        //! tell client no available handy men
      } else {}
   });
  }

  //*************************************************************************** */

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(-1.2833333, 36.8166667),
      
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);


  @override
  Widget build(BuildContext context) {

    const colorizeColors = [
      Colors.green,
      Colors.purple,
      Colors.pink,
      Colors.blue,
      Colors.yellow,
      Colors.red,
      Colors.orange,
      Colors.blue,
      Colors.brown,
      Colors.black,
      Colors.cyan,
      Colors.amber,
      Colors.lime,
      Colors.teal,

    ];

    const colorizeTextStyle = TextStyle(
      fontSize: 50.0,
      fontFamily: 'Horizon',
      //fontFamily: 'Signatra',
      
    );
     

    return Scaffold(
      key: scaffoldKey,

      drawer: Container(
        color: Colors.white,
        width: 255.0,
        child: Drawer(
          child: ListView(
            children:[
              Container(
                height: 165.0,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      //Image.asset('assets\images\handyman1.jpg', height: 60.0, width: 60.0),
                      SizedBox(width: 16.0,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('John Doe', style: TextStyle(fontSize: 16.0, fontFamily: "Brand-Bold"),),
                          SizedBox(height: 16.0,),
                          Text("Visit Profile"),
                        ],
                      ),
                    ],
                  ),

                ),
              ),

              DividerWidget(),

              SizedBox(height: 12.0,),

              GestureDetector(
                onTap: (){
                  Navigator.pushNamedAndRemoveUntil(
                      context, MainScreen.idScreen, (route) => false);
                },
                child: ListTile(
                  leading: Icon(Icons.home),
                  title: Text("Home", style: TextStyle(fontSize: 15.0),),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, MainScreen.idScreen, (route) => false);
                },
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text(
                    "User Profile",
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, SearchScreen.idScreen, (route) => false);
                },
                child: ListTile(
                  leading: Icon(Icons.search),
                  title: Text(
                    "Find",
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, OrderScreen.idScreen, (route) => false);
                },
                child: ListTile(
                  leading: Icon(Icons.history),
                  title: Text(
                    "History",
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
              ),
            ],

          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: bottomPaddingOfMap, top: topPaddingOfMap),
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kLake,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            polylines: polylineSet,
            markers: markersSet,
            circles: circlesSet,
            onMapCreated: (GoogleMapController controller){

              _controllerGoogleMap.complete(controller);
              NewGoogleMapController = controller;

              setState(() {
                bottomPaddingOfMap = 270.0;
                topPaddingOfMap = 30;
              });

              locatePosition();
            },

          ),

          //Hamburger button

          Positioned(
            top: 45.0,
            left: 22.0,
            child: GestureDetector(
              onTap: () {
                scaffoldKey.currentState!.openDrawer();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 6.0,
                      spreadRadius: 0.5,
                      offset: Offset(
                        0.7,
                        0.7,
                      )
                    )
                  ],
                      
                ),
            
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.menu),
                  radius: 20.0,
                ),
              ),
            ),
          ),

          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: AnimatedSize(
              vsync: this,
              curve: Curves.bounceIn,
              duration: new Duration(milliseconds: 160),
              child: Container(
                height: searchContainerHeight,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18.0),
                    topRight: Radius.circular(18.0),
                    ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 16.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7, 0.7),
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 0.6,),
                      Text("Hi, there", style: TextStyle(fontSize: 12.0),),
                      Text(
                        "Which location for repair?",
                        style: TextStyle(fontSize: 20.0, fontFamily: "Brand-Bold",),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                        GestureDetector(
                          onTap: () async {
                           var res = await Navigator.push(context, MaterialPageRoute(builder: (context) => SearchMap()));
            
                           if(res == "obtainDirection"){
                             displayRideDetailsContainer();
                           }
                          },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black54,
                                blurRadius: 6.0,
                                spreadRadius: 0.5,
                                offset: Offset(0.7, 0.7),
                              )
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                            children: [
                              Icon(Icons.search, color: Colors.blueAccent,),
                              SizedBox(width: 10.0,),
                              Text("Search location for service"),
                            ],
                            ),
                            ),
                        ),
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      Row(
                        children: [
                          Icon(Icons.home, color: Colors.grey,),
                          SizedBox(
                            height: 12.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                //"Home"
                                  Provider.of<AppData>(context).pickUpLocation != null ?
                                  Provider.of<AppData>(context).pickUpLocation!.placeName:  "Error" ,
                                 
                                    
                                   
                              ),
                              SizedBox(
                                height: 4.0,
                              ),
                              Text("Your living home address", style: TextStyle(color: Colors.black54, fontSize: 12.0),),
            
                            ],
                          ),
                        ],
                        ),
            
            
                        SizedBox(
                        height: 10.0,
                      ),
            
                      Divider(),
            
                      SizedBox(
                        height: 10.0,
                      ),
            
                    ],
                    ),
                ),
              ),
            ),
            ),

          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: AnimatedSize(
              vsync: this,
              curve: Curves.bounceIn,
              duration: new Duration(milliseconds: 160),
              child: Container(
                height: rideDetailsContainer,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0) ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 16.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7, 0.7),
            
                    )
                  ],
                ),
            
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 17.0,),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        color: Colors.tealAccent[100],
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            // Image.asset(./assets/images/handyman1.jpg),
                            SizedBox( width: 16.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  Provider.of<AppData>(context).dropOffLocation !=
                                          null
                                      ? Provider.of<AppData>(context)
                                          .dropOffLocation!
                                          .placeName
                                      : "Error",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: "Brand-Bold",
                                  ),
                                ),
                                Text(
                                  Provider.of<AppData>(context).pickUpLocation != null ?
                                  Provider.of<AppData>(context).pickUpLocation!.placeName:  "Error" ,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: "Brand-Bold",
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                           ],
                          ),
                      ),
                      SizedBox( height: 20.0,),
            
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: [
                            Icon(Icons.home_repair_service, size: 20.0),
                            SizedBox(width: 15),
                            DropdownButton<String>(
                              //hint: Text("Select Service"),
                              value: value,
                              iconSize: 26,
                              icon: Icon(Icons.keyboard_arrow_down, color: Colors.black),
                              items: items.map(buildMenuItem).toList(),
                              onChanged: (value) {
                                setState(() {
                                  service = value!;
                                });
                              },
                            ),
                            // SizedBox(width: 6.0,),
                            // Icon(Icons.keyboard_arrow_down, color: Colors.black),
            
                          ],
                        ),
                      ),
            
                      SizedBox(height: 24.0,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0,),
                        child: RaisedButton(
                          onPressed: () {
                            displayRequestRideContainer();
                          },
                          color:  Colors.deepPurple,
                          child: Padding(
                            padding: EdgeInsets.all(17.0), 
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Request", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white ,),
                                ),
                                Icon(Icons.handyman, color: Colors.white, size: 26.0,),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          ),
          
          Positioned(
            bottom: 0.0,left: 0.0, right: 0.0,
      
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0),),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 0.5,
                    blurRadius: 16.0,
                    color: Colors.black54,
                    offset: Offset(07, 07),
                  )
                ],
              ),
              height: rideRequestContainer,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(height: 12.0,),
          
                          
                     SizedBox(
                      width: double.infinity,
                      child: AnimatedTextKit(
                        animatedTexts: [
                          ColorizeAnimatedText(                       
                            'Requesting a service...',
                            textStyle: colorizeTextStyle,
                            textAlign: TextAlign.center,
                            colors: colorizeColors,
                          ),
                          ColorizeAnimatedText(
                            'Please wait....',
                            textStyle: colorizeTextStyle,
                            textAlign: TextAlign.center,
                            colors: colorizeColors,
                          ),
                          ColorizeAnimatedText(
                            'Finding a Handyman....',
                            textStyle: colorizeTextStyle,
                            textAlign: TextAlign.center,
                            colors: colorizeColors,
                          ),
                          ],
                          isRepeatingAnimation: true,
                          onTap: () {
                            print("Tap Event");
                          },
                            ),
                     ),

                     SizedBox(
                      height: 18.0,
                    ),
                      Container(
                        height: 60.0,
                        width: 60.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(26.0),
                          border: Border.all(width: 2.0, color: Colors.grey),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            resetApp();
                          },
                          child: Icon(Icons.close, size: 26.0))
                      ),
                      SizedBox(
                      height: 7.0,
                        ),
                      Container(
                        width: double.infinity,
                        child: Text("Cancel", textAlign: TextAlign.center, style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),),
                      ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> getPlaceDirection() async {
    var initialPos = Provider.of<AppData>(context, listen: false).pickUpLocation;
    var finalPos =Provider.of<AppData>(context, listen: false).dropOffLocation;
    
    
    
    var pickUpLatLng = LatLng(initialPos!.latitude, initialPos.longitude);
    var dropOffLatLng = LatLng(finalPos!.latitude, finalPos.longitude);

    showDialog(
      context: context,
      builder: (BuildContext context) => ProgressDialog(message: "Please wait..."), 
    );

    var details = await AssitantMethods.obtainPlaceDirectionDetails(pickUpLatLng, dropOffLatLng);

    Navigator.pop(context);

    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
    print("This is Encoded Points");
    print(details.encodedPoints);

    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodedPolyLinePointsResult = polylinePoints.decodePolyline(details.encodedPoints);

    pLineCoordinates.clear();

    if(decodedPolyLinePointsResult.isNotEmpty){
      decodedPolyLinePointsResult.forEach((PointLatLng pointLatLng){
        pLineCoordinates.add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      });
    }

    polylineSet.clear();

    setState(() {
      Polyline polyline = Polyline(
        color: Colors.pink,
        polylineId: PolylineId("PolylineID"),
        jointType: JointType.round,
        points: pLineCoordinates,
        width: 5,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        geodesic: true,
      );

      polylineSet.add(polyline);
    });

    LatLngBounds latLngBounds;
    if(pickUpLatLng.latitude > dropOffLatLng.latitude && pickUpLatLng.longitude > dropOffLatLng.longitude){
      latLngBounds = LatLngBounds(southwest: dropOffLatLng, northeast: pickUpLatLng);
    }
    else if (pickUpLatLng.longitude > dropOffLatLng.longitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(pickUpLatLng.latitude, dropOffLatLng.longitude),
          northeast: LatLng(dropOffLatLng.latitude, pickUpLatLng.longitude));
    }
    else if (pickUpLatLng.latitude > dropOffLatLng.latitude){
      latLngBounds =
          LatLngBounds(southwest: LatLng(dropOffLatLng.latitude, pickUpLatLng.longitude), northeast: LatLng(pickUpLatLng.latitude, dropOffLatLng.longitude));
    }
    else{
     latLngBounds = latLngBounds =
          LatLngBounds(southwest: pickUpLatLng, northeast: dropOffLatLng);
    }

    NewGoogleMapController.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));

    Marker pickUpLocationMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
      infoWindow: InfoWindow(title: initialPos.placeName, snippet: "my location"),
      position: pickUpLatLng,
      markerId: MarkerId("pickUpId"),

    );

    Marker dropOffLocationMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow:
          InfoWindow(title: finalPos.placeName, snippet: "dropOff location"),
      position: dropOffLatLng,
      markerId: MarkerId("dropOffId"),
    );

    setState(() {
      markersSet.add(pickUpLocationMarker);
      markersSet.add(dropOffLocationMarker);
    });

    Circle pickUpCircle = Circle(
      fillColor: Colors.blueAccent,
      center: pickUpLatLng,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.blueAccent,
      circleId: CircleId("pickUpId"),

    );

    Circle dropOffCircle = Circle(
      fillColor: Colors.purple,
      center: dropOffLatLng,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.purple,
      circleId: CircleId("dropOffId"),
    );

    setState(() {
      circlesSet.add(pickUpCircle);
      circlesSet.add(dropOffCircle);
    });
  }

  DropdownMenuItem<String> buildMenuItem(String item) =>
    DropdownMenuItem(
      value: item,
      child: Text(
        item, 
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,),
      ),
    );

}





