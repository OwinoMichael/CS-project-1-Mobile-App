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
    imageUrl: 'assets/images/Slide1.jpg', 
    title: 'Introducing House Fix', 
    description: 'Having trouble finding someone for house repairs? Worry Not, House Fix is here to help!!!'),
  Slide(
    imageUrl: 'assets/images/Slide3.jpg', 
    title: 'Urgent? We have you covered', 
    description: 'House Fix is here to help you to locate the nearest available handyman to address your house repair issues'),
  Slide(
    imageUrl: 'assets/images/Slide2.jpg', 
    title: 'Click to get started', 
    description: 'House Fix links you quickly with our trusted Handymen assist to do repairs'),
];