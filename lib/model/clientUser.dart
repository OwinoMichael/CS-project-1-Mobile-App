import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Users {
  String ? id;
  String ? token;
  String ? name;
  String ? email;
  String ? phone;
  
  Users ({
    this.id,
    this.token,
    this.name,
    this.email,
    this.phone,
  });

  Users.fromSnapshot(DataSnapshot dataSnapshot){
    id = dataSnapshot.key;
    token = dataSnapshot.value['token'];
    name = dataSnapshot.value['name'];
    email = dataSnapshot.value['email'];
    phone = dataSnapshot.value['phone'];
  }

}