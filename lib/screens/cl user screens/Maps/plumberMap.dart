import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prdip/Assistants/assistantMethods.dart';
import 'package:prdip/Assistants/requestAssistant.dart';
import 'package:prdip/DataHandler/appData.dart';
import 'package:prdip/model/address.dart';
import 'package:prdip/screens/cl%20user%20screens/Maps/search_map.dart';
import 'package:prdip/widgets/Divider.dart';
import 'package:prdip/widgets/progressDialog.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';


import 'configMaps.dart';

class PlumberMap extends StatefulWidget {

  static const String idScreen = "plumbingMap";
  const PlumberMap({ Key? key }) : super(key: key);

  @override
  _PlumberMapState createState() => _PlumberMapState();
}

class _PlumberMapState extends State<PlumberMap> with TickerProviderStateMixin {

  
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

  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};

  double rideDetailsContainer = 0;
  double searchContainerHeight = 260.0;
  void displayRideDetailsContainer() async {

    await getPlaceDirection();

    setState(() {
      searchContainerHeight = 0;
      rideDetailsContainer = 240;
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

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(-1.2833333, 36.8166667),
      
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);


  @override
  Widget build(BuildContext context) {
     

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

              ListTile(
                leading: Icon(Icons.home),
                title: Text("Home", style: TextStyle(fontSize: 15.0),),
              ),
              ListTile(
                leading: Icon(Icons.plumbing),
                title: Text(
                  "Plumber List",
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
              ListTile(
                leading: Icon(Icons.search),
                title: Text(
                  "Find",
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
              ListTile(
                leading: Icon(Icons.history),
                title: Text(
                  "History",
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
            ],

          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
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
            
            
                      // Row(
                      //   children: [
                      //     Icon(
                      //       Icons.house,
                      //       color: Colors.grey,
                      //     ),
                      //     SizedBox(
                      //       height: 12.0,
                      //     ),
                      //     Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Text("Add another house location"),
                      //         SizedBox(
                      //           height: 4.0,
                      //         ),
                      //         Text(
                      //           "Any other house address",
                      //           style: TextStyle(
                      //               color: Colors.black54, fontSize: 12.0),
                      //         ),
                      //       ],
                      //     ),
                      //   ],
                      // ),
            
            
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
                              onChanged: (value) => this.value = value,
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
                          onPressed: () {},
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
