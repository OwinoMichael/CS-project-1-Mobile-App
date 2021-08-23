import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:prdip/Assistants/requestAssistant.dart';
import 'package:prdip/DataHandler/appData.dart';
import 'package:prdip/model/address.dart';
import 'package:prdip/screens/cl%20user%20screens/Maps/configMaps.dart';
import 'package:prdip/screens/cl%20user%20screens/Maps/placePredictions.dart';
import 'package:prdip/widgets/Divider.dart';
import 'package:prdip/widgets/progressDialog.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class SearchMap extends StatefulWidget {
  const SearchMap({ Key? key }) : super(key: key);

  @override
  _SearchMapState createState() => _SearchMapState();
}

class _SearchMapState extends State<SearchMap> {

  TextEditingController pickUpTextEditingController = TextEditingController();
  TextEditingController dropOffTextEditingController = TextEditingController();
  List<PlacePredictions> placePredictionList = [];

  @override
  Widget build(BuildContext context) {

     String? placeAddress = Provider.of<AppData>(context).pickUpLocation!.placeName;
     pickUpTextEditingController.text = placeAddress;

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 215.0,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 6.0,
                  spreadRadius: 0.5,
                  offset: Offset(0.7, 0.7),
                )
              ],
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 25.0, top: 25.0, right: 25.0, bottom: 20.0),
              child: Column(
                children: [
                  SizedBox(height: 5.0,),
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back
                          ),
                      ),
                      Center(
                        child: Text("Set Repair Location", style: TextStyle(fontSize: 18.0, fontFamily: "Brand-Bold")),

                      ),
                    ],
                    
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    children: [
                      //Image.asset("", height: 16.0, width: 16.0,),

                      SizedBox(
                        height: 13.0,
                      ),

                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(3.0),
                            child: TextField(
                              controller: pickUpTextEditingController,
                              decoration: InputDecoration(
                                hintText: "Current location",
                                fillColor: Colors.grey[400],
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(left: 11.0, top: 8.0, bottom: 8.0),
                              ),
                            ),
                          ),
                        ),
                        ),
                    ],
                  ),

                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      // Image.asset(
                      //   "",
                      //   height: 16.0,
                      //   width: 16.0,
                      // ),
                      SizedBox(
                        height: 13.0,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(3.0),
                            child: TextField(
                              onChanged: (val){
                                findPlace(val);
                              },
                              controller: dropOffTextEditingController,
                              decoration: InputDecoration(
                                hintText: "Repair/service location",
                                fillColor: Colors.grey[400],
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(
                                    left: 11.0, top: 8.0, bottom: 8.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ),
          ),

          ///////
          (placePredictionList.length > 0) 
            ? Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: ListView.separated(
                padding: EdgeInsets.all(0.0),
                itemBuilder: (context, index){
                  return PredictionTile(placePredictions: placePredictionList[index], key: UniqueKey(),);
                }, 
                separatorBuilder: (BuildContext context, int index) => DividerWidget(), 
                itemCount: placePredictionList.length,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                ),
            ) 
            : Container(),
        ],
      ),
    );
  }
    void findPlace(String placeName) async {
      if(placeName.length > 1){
        String autoCompleteUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$mapkey&sessiontoken=1234567890&components=country:ke";
        //String autoCompleteUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&types=geocode&key=$mapkey";
        var res = await RequestAssitant.getRequest(autoCompleteUrl);

        if(res == "failed"){
          return;
        }
        
        if(res["status"] == "OK"){
          var predictions = res["predictions"];

          var placesList = (predictions as List).map((e) => PlacePredictions.fromJson(e)).toList();
          setState(() {
            placePredictionList = placesList;
          });
          
        }
      }
    }
}

class PredictionTile extends StatelessWidget{

  final PlacePredictions placePredictions; 

  PredictionTile({required Key key, required this.placePredictions,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(0.0),
      onPressed: () {
        getPlaceAddressDetails(placePredictions.place_id, context);
      },
    child: Container(
      child: Column(
        children: [
         SizedBox(
            width: 10.0,
          ), 
         Row(
          children: [
            Icon(Icons.add_location),
            SizedBox(width: 14.0,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(placePredictions.main_text,overflow: TextOverflow.ellipsis ,style: TextStyle(fontSize: 16.0,),),
                  SizedBox(height: 3.0,),
                  Text(
                    placePredictions.secondary_text,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
           ],
         ),
         SizedBox(
            width: 10.0,
          ),
        ],
      ),
    ),
    );
  }

  void getPlaceAddressDetails(String placeId, context) async{

    showDialog(context: context, 
    builder: (BuildContext) => ProgressDialog(message: "Loading location on Map",)
    );

    String placeDetailsUrl = "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$mapkey";

    var res = await RequestAssitant.getRequest(placeDetailsUrl);

    Navigator.pop(context);

    if(res == "failed"){
      return null;
    }

    if(res["status"] == "OK"){
      Address address = Address(
        latitude: 0.0,
        longitude: 0.0,
        placeFormattAddress: '',
        placeId: '',
        placeName: '',
      );
      address.placeName= res["result"]["name"];
      address.placeId= placeId;
      address.latitude = res["result"]["geometry"]["location"]["lat"];
      address.longitude = res["result"]["geometry"]["location"]["lng"];

      Provider.of<AppData>(context, listen: false).updateDropOffLocationAddress(address);
      print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
      print(address.placeName);

      Navigator.pop(context, "obtainDirection");
    }
  }

}
