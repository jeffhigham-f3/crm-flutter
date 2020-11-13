import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/config/import.dart';

class ThemeService with ChangeNotifier {
  Color gradientColor1;
  Color gradientColor2;
  Color gradientColor3;
  Color online;
  LinearGradient appBarGradient;
  BoxDecoration appBarGradientDecoration;
  Container flexSpaceNavGradient;
  LinearGradient loginGradient;
  BoxDecoration loginGradientDecoration;
  Container loginvGradientContainer;

  ThemeService({@required List<Color> theme}) {
    setTheme(theme: theme);
  }

  ThemeData getTheme() {
    return ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: gradientColor1,
      accentColor: gradientColor3,
      canvasColor: Palette.scaffold,
      buttonTheme: ButtonThemeData(
        textTheme: ButtonTextTheme.accent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
      ),
    );
  }

  void setTheme({@required List<Color> theme}) async {
    if (theme.length != 3) return;
    gradientColor1 = theme[0];
    gradientColor2 = theme[1];
    gradientColor3 = theme[2];
    online = theme[2];

    appBarGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [gradientColor1, gradientColor3],
      stops: [0.40, 1.0],
    );

    appBarGradientDecoration = BoxDecoration(
      gradient: appBarGradient,
    );

    flexSpaceNavGradient = Container(
      decoration: appBarGradientDecoration,
    );

    // Login Screen Gradient
    loginGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [gradientColor1, gradientColor2, gradientColor3],
      tileMode: TileMode.clamp,
    );

    loginGradientDecoration = BoxDecoration(
      gradient: loginGradient,
    );

    loginvGradientContainer = Container(
      decoration: loginGradientDecoration,
    );
    notifyListeners();
  }
}
