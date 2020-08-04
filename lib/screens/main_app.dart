import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/screens/login_screen.dart';
import 'package:verb_crm_flutter/screens/crm_picker_screen.dart';

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        CrmPickerScreen.id: (context) => CrmPickerScreen(),
      },
    );
  }
}