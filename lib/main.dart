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
          create: (_) => ThemeService(theme: Palette.defaultTheme),
        ),
        ChangeNotifierProvider(
          create: (_) => ContactService(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthService(),
        ),
        ChangeNotifierProvider(
          create: (_) => AppService(),
        ),
        ChangeNotifierProvider(
          create: (_) => AppBarService(),
        ),
      ],
      child: _MainApp(),
    ),
  );
}

class _MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);
    return MaterialApp(
      theme: themeService.getTheme(),
      home: LoginScreen(),
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        AppHome.id: (context) => AppHome(),
        AppScreen.id: (context) => AppScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
