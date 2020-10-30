import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verb_crm_flutter/models/goal_manager.dart';
import 'package:verb_crm_flutter/models/crm/crm_manager.dart';
import 'package:verb_crm_flutter/screens/main_app.dart';
import 'package:verb_crm_flutter/service/import.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => GoalManager(),
        ),
        ChangeNotifierProvider(
          create: (_) => CrmManager(),
        ),
        ChangeNotifierProvider(
          create: (_) => GlanceService(),
        ),
        ChangeNotifierProvider(
          create: (_) => ContactService(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthService(),
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
        ChangeNotifierProvider(
          create: (_) => CrmService(),
        ),
      ],
      child: MainApp(),
    ),
  );
}
