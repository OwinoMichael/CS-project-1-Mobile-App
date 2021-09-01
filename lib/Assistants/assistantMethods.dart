import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prdip/Assistants/requestAssistant.dart';
import 'package:prdip/DataHandler/appData.dart';
import 'package:prdip/model/address.dart';
import 'package:prdip/model/clientUser.dart';
import 'package:prdip/model/placeDetails.dart';
import 'package:prdip/screens/cl%20user%20screens/Maps/configMaps.dart';
import 'package:provider/provider.dart';

class AssitantMethods {
 

  static Future<String> searchCoordinateAddress(Position position, context) async{

      String placedAddress = "";
      String st1, st2, st3, st4;
      String url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapkey";
      // String url =
      //   "https://maps.googleapis.com/maps/api/geocode/json?latlng=40.714224,-73.961452&key=$mapkey";

      var response = await RequestAssitant.getRequest(url);

      if(response != "failed"){
        // placedAddress = response["results"][0]["formatted_address"];
        //  st1 = response["results"][0]["address_components"][0]["long_name"];
        //  st2 = response["results"][0]["address_components"][1]["long_name"];
        //  st3 = response["results"][0]["address_components"][5]["long_name"];
        //  st4 = response["results"][0]["address_components"][6]["long_name"];
        // placedAddress = st1 + ", " + st2 + ", " + st3 + ", " + st4;

        placedAddress = response["results"][0]["formatted_address"]; 

        Address userPickUpAddress = new Address(latitude: 0.0, longitude: 0.0, placeFormattAddress: '', placeId: '', placeName: '',  );
        userPickUpAddress.longitude = position.longitude;
        userPickUpAddress.latitude = position.latitude;
        userPickUpAddress.placeName = placedAddress;

         Provider.of<AppData>(context, listen: false).updatePickUpLocationAddress(userPickUpAddress);
      }
      
      return placedAddress;
 
    
  }

  static Future<DirectionDetails> obtainPlaceDirectionDetails(LatLng initialPosition, LatLng finalPosition) async {
    String directionUrl = "https://maps.googleapis.com/maps/api/directions/json?origin=${initialPosition.latitude},${initialPosition.longitude}&destination=${finalPosition.latitude},${finalPosition.longitude}&key=$mapkey";

    var res = await RequestAssitant.getRequest(directionUrl);

    //  if(res == "failed"){
    //   return;
    //  }

    DirectionDetails directionDetails = DirectionDetails(distanceText: '', distanceValue: 0, durationText: '', durationValue: 0, encodedPoints: '', );

    directionDetails.encodedPoints = res["routes"][0]["overview_polyline"]["points"];

    directionDetails.distanceText = res["routes"][0]["legs"][0]["distance"]["text"];
    directionDetails.distanceValue = res["routes"][0]["legs"][0]["distance"]["value"];

    directionDetails.durationText = res["routes"][0]["legs"][0]["duration"]["text"];
    directionDetails.durationValue = res["routes"][0]["legs"][0]["duration"]["value"];
    
    return directionDetails;

  }

  static void getCurrentUserInfo() async {
    firebaseUser = await FirebaseAuth.instance.currentUser;
    String userId = firebaseUser!.uid;
    DatabaseReference reference = FirebaseDatabase(
            databaseURL:
                "https://prdip-2932d-default-rtdb.europe-west1.firebasedatabase.app/")
        .reference()
        .child("client-users").child(userId);

  reference.once().then((DataSnapshot dataSnapshot) {
    if(dataSnapshot.value != null ){
      userCurrentInfo = Users.fromSnapshot(dataSnapshot);
    }
  });


  }
} 