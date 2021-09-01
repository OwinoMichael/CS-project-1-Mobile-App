import 'package:flutter/material.dart';

class OrderData {
  String ? clientToken;
  String ? service;
  String ? handyName;
  String ? contact;
  String ? loco;
  String ? timeCreated;

  OrderData({
    this.clientToken,
    this.service,
    this.handyName,
    this.contact,
    this.loco,
    this.timeCreated
  });
}