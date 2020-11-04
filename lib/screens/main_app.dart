import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/screens/import.dart';
import 'package:verb_crm_flutter/config/palette.dart';

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: Palette.theme[0],
        accentColor: Palette.theme[2],
        canvasColor: Palette.scaffold,
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
        LiveVideoScreen.id: (context) => LiveVideoScreen(),
        SolutionsScreen.id: (context) => SolutionsScreen(),
        WorkflowScreen.id: (context) => WorkflowScreen(),
        CrmScreen.id: (context) => CrmScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
