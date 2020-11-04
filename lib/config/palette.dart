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

  // Theme Gradient Config
  static final theme = theme2;
  static final gradientColor1 = theme[0];
  static final gradientColor2 = theme[1];
  static final gradientColor3 = theme[2];
  static final online = theme[2];

  // AppBar Gradient
  static final LinearGradient appBarGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [gradientColor1, gradientColor3],
  );
  static final BoxDecoration appBarGradientDecoration = BoxDecoration(
    gradient: appBarGradient,
  );
  static final Container flexSpaceNavGradient = Container(
    decoration: appBarGradientDecoration,
  );

  // Login Screen Gradient
  static final LinearGradient loginGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [gradientColor1, gradientColor2, gradientColor3],
    tileMode: TileMode.clamp,
  );
  static final BoxDecoration loginGradientDecoration = BoxDecoration(
    gradient: loginGradient,
  );
  static final Container loginvGradientContainer = Container(
    decoration: loginGradientDecoration,
  );
}
