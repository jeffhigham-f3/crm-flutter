import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/screens/login_screen.dart';
import 'package:verb_crm_flutter/screens/crm_picker_screen.dart';
import 'package:verb_crm_flutter/screens/crm_login_screen.dart';
import 'package:verb_crm_flutter/screens/crm_app_home.dart';

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        CrmPickerScreen.id: (context) => CrmPickerScreen(),
        CrmLoginScreen.id: (context) => CrmLoginScreen(),
        CrmAppHome.id: (context) => CrmAppHome(),
      },
    );
  }
}
