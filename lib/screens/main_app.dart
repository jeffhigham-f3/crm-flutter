import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/screens/login_screen.dart';
import 'package:verb_crm_flutter/screens/app_home.dart';
import 'package:verb_crm_flutter/screens/goal_picker_screen.dart';
import 'package:verb_crm_flutter/screens/people_home_screen.dart';
import 'package:verb_crm_flutter/screens/live_video_screen.dart';
import 'package:verb_crm_flutter/screens/solution_screen.dart';

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //https://api.flutter.dev/flutter/material/ThemeData-class.html
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
//        primaryColor: Color(0xFF6B3EFF),
//        accentColor: Color(0xFF6B3EFF),
//        canvasColor: Colors.white,
        // https://api.flutter.dev/flutter/widgets/Text-class.html
        textTheme: TextTheme(
          bodyText1: const TextStyle(),
          bodyText2: const TextStyle(),
          button: const TextStyle(),
          caption: const TextStyle(),
          headline1: const TextStyle(),
          headline2: const TextStyle(),
          headline3: const TextStyle(),
          headline4: const TextStyle(),
          headline5: const TextStyle(),
          headline6: const TextStyle(),
          subtitle1: const TextStyle(),
          subtitle2: const TextStyle(),
        ),
        buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.accent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: const TextStyle(),
          hintStyle: const TextStyle(),
          errorStyle: const TextStyle(),
          enabledBorder: const UnderlineInputBorder(
            borderSide: const BorderSide(),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: const BorderSide(),
          ),
        ),
      ),
      home: LoginScreen(),
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        AppHome.id: (context) => AppHome(),
        GoalPickerScreen.id: (context) => GoalPickerScreen(),
        PeopleHomeScreen.id: (context) => PeopleHomeScreen(),
        LiveVideoScreen.id: (context) => LiveVideoScreen(),
        SolutionsScreen.id: (context) => SolutionsScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
