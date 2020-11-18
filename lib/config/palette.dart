import 'package:flutter/material.dart';

class Palette {
  static const Color scaffold = const Color(0xFFF0F2F5);

  // Theme 1
  static const Color purpleAccent = const Color(0xFF6B3EFF);
  static const Color purpleBlueAccent = const Color(0xFF5058FF);
  static const Color blueAccent = const Color(0xFF00A2FF);

  // Theme 2
  static const Color turquoiseAccent = const Color(0xFF21C6B9);
  static const Color turquoisBlueAccent = const Color(0xFF23ACCB);
  static const Color turquoisBlue = const Color(0xFF2490DB);

  // Theme 3
  static const Color redAccent = const Color(0xFFE3705D);
  static const Color redPurpleAccent = const Color(0xFFD17486);
  static const Color redPurple = const Color(0xFFB26FB3);

  static const List<Color> theme1 = [purpleBlueAccent, purpleBlueAccent, blueAccent];
  static const List<Color> theme2 = [turquoiseAccent, turquoisBlueAccent, turquoisBlue];
  static const List<Color> theme3 = [redAccent, redPurpleAccent, redPurple];
  static const List<Color> defaultTheme = theme1;
}
