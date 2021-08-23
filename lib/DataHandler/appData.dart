import 'package:flutter/cupertino.dart';
import 'package:prdip/model/address.dart';
import 'package:flutter/cupertino.dart';

class AppData extends ChangeNotifier{

  Address ? pickUpLocation;
  Address ? dropOffLocation;

  void updatePickUpLocationAddress(Address ? pickUpAddress){
    this.pickUpLocation = pickUpAddress;
    notifyListeners();
  }

  void updateDropOffLocationAddress(Address ? dropOffAddress) {
    this.dropOffLocation = dropOffAddress;
    notifyListeners();
  }
}