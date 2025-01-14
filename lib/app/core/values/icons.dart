import 'package:flutter/material.dart';

class TaskIcons {
  static const personIcon = 0xe491; // person
  static const workIcon = 0xe11c; // work
  static const movieIcon = 0xe40f; // movie
  static const sportIcon = 0xe4dc; // sport
  static const travelIcon = 0xe071; // travel
  static const shopIcon = 0xe59c; // shop

  static IconData getIcon(int hex) {
    return IconData(hex, fontFamily: 'MaterialIcons');
  }
}
