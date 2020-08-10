import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/screens/login_screen.dart';
import 'package:verb_crm_flutter/screens/crm_picker_screen.dart';
import 'package:verb_crm_flutter/screens/crm_login_screen.dart';
import 'package:verb_crm_flutter/screens/crm_app_home.dart';
import 'package:verb_crm_flutter/screens/goal_picker_screen.dart';
import 'package:verb_crm_flutter/screens/people_home_screen.dart';
import 'package:verb_crm_flutter/screens/live_video_screen.dart';

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //https://api.flutter.dev/flutter/material/ThemeData-class.html
      theme: ThemeData(
//        primaryColor: Color(0xFF6B3EFF),
//        accentColor: Color(0xFF6B3EFF),
//        canvasColor: Colors.white,
        // https://api.flutter.dev/flutter/widgets/Text-class.html
        textTheme: TextTheme(
          bodyText1: TextStyle(),
          bodyText2: TextStyle(),
          button: TextStyle(),
          caption: TextStyle(),
          headline1: TextStyle(),
          headline2: TextStyle(),
          headline3: TextStyle(),
          headline4: TextStyle(),
          headline5: TextStyle(),
          headline6: TextStyle(),
          subtitle1: TextStyle(),
          subtitle2: TextStyle(),
        ),
        buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.accent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(
//            color: Color(0xFFF3F6FA),
              ),
          hintStyle: TextStyle(
//            color: Color(0xFFF3F6FA),
              ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
//              color: Color(0xFFF3F6FA),
                ),
          ),
          focusedBorder: UnderlineInputBorder(
//            borderSide: BorderSide(
//              color: Colors.blue,
//            ),
              ),
        ),
      ),
      home: LoginScreen(),
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        CrmPickerScreen.id: (context) => CrmPickerScreen(),
        CrmLoginScreen.id: (context) => CrmLoginScreen(),
        CrmAppHome.id: (context) => CrmAppHome(),
        GoalPickerScreen.id: (context) => GoalPickerScreen(),
        PeopleHomeScreen.id: (context) => PeopleHomeScreen(),
        LiveVideoScreen.id: (context) => LiveVideoScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
