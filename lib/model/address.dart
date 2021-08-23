import 'package:flutter/cupertino.dart';

class Address {
  

  late String placeFormattAddress;
  late String placeName;
  late String placeId;
  late double latitude;
  late double longitude;

  Address({
      
       required this.placeFormattAddress ,
       required this.placeName ,
       required this.placeId ,
       required this.latitude,
       required this.longitude,
  });

}