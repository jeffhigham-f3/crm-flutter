import 'package:flutter/material.dart';

class Palette {
  // static const Color scaffold = Color(0xFFF0F2F5);

  // static const Color facebookBlue = Color(0xFF1777F2);

  // static const LinearGradient createRoomGradient = LinearGradient(
  //   colors: [Color(0xFF496AE1), Color(0xFFCE48B1)],
  // );

  static final Color online = Colors.lightGreen[300]; // Color(0xFF4BCB1F);

  // static const LinearGradient storyGradient = LinearGradient(
  //   begin: Alignment.topCenter,
  //   end: Alignment.bottomCenter,
  //   colors: [Colors.transparent, Colors.black26],
  // );

  static const LinearGradient navGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [const Color(0xFF6B3EFF), const Color(0xFF5058FF), const Color(0xFF00A2FF)],
  );
  static Container flexSpaceNavGradient = Container(
    decoration: BoxDecoration(
      gradient: navGradient,
    ),
  );
}
