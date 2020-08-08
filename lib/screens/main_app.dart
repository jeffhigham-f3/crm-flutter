import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/screens/login_screen.dart';
import 'package:verb_crm_flutter/screens/crm_picker_screen.dart';
import 'package:verb_crm_flutter/screens/crm_login_screen.dart';
import 'package:verb_crm_flutter/screens/crm_app_home.dart';
import 'package:verb_crm_flutter/screens/goal_picker_screen.dart';
import 'package:verb_crm_flutter/screens/glance_home_screen.dart';
import 'package:verb_crm_flutter/screens/live_video_screen.dart';

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //https://api.flutter.dev/flutter/material/ThemeData-class.html
      theme: ThemeData(
        primaryColor: Colors.deepPurpleAccent[100],
        accentColor: Colors.deepPurpleAccent[100],
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(
            color: Color(0xFFF3F6FA),
          ),
          hintStyle: TextStyle(
            color: Color(0xFFF3F6FA),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFF3F6FA),
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue,
            ),
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
        GlanceHomeScreen.id: (context) => GlanceHomeScreen(),
        LiveVideoScreen.id: (context) => LiveVideoScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
