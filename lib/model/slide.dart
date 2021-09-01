import 'package:flutter/material.dart';

class Slide {
  final String imageUrl;
  final String title;
  final String description;

  Slide({
    required this.imageUrl,
    required this.title,
    required this.description,
  });
}

final slideList = [
  Slide(
    imageUrl: 'assets/images/image1.jpg', 
    title: 'Welcome to House Fix', 
    description: 'Having trouble findinig clients? Worry no more, House Fix is here to help.'),
  Slide(
    imageUrl: 'assets/images/image2.jpg', 
    title: 'Connect with clients', 
    description: 'Once registered, clients can be able to locate you depending on the location you are in.'),
  Slide(
    imageUrl: 'assets/images/image3.jpg', 
    title: 'Click to get started', 
    description: 'The app is simple and easy to use.'),
];