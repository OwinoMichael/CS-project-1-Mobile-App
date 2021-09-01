import 'package:flutter/material.dart';

class OrderData {
  String ? clientToken;
  String ? service;
  String ? handyName;
  String ? loco;
  String ? timeCreated;

  OrderData({
    this.clientToken,
    this.service,
    this.handyName,
    this.loco,
    this.timeCreated
  });
}