import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:verb_crm_flutter/service/import.dart';
import 'package:verb_crm_flutter/screens/import.dart';
import 'package:verb_crm_flutter/config/import.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ContactService(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthService(),
        ),
        ChangeNotifierProvider(
          create: (_) => CrmService(),
        ),
        ChangeNotifierProvider(
          create: (_) => AppBarService(),
        ),
        ChangeNotifierProvider(
          create: (_) => TrayIOSolutionService(),
        ),
        ChangeNotifierProvider(
          create: (_) => TrayIOSolutionInstanceService(),
        ),
        ChangeNotifierProvider(
          create: (_) => TrayIOUserService(),
        ),
        ChangeNotifierProvider(
          create: (_) => TrayIOWorkflowService(),
        ),
      ],
      child: _MainApp(),
    ),
  );
}

class _MainApp extends StatelessWidget {
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
        CrmScreen.id: (context) => CrmScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
