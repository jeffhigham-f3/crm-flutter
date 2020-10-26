import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verb_crm_flutter/models/goal_manager.dart';
import 'package:verb_crm_flutter/models/crm_manager.dart';
import 'package:verb_crm_flutter/screens/main_app.dart';
import 'package:verb_crm_flutter/service/import.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
        ChangeNotifierProvider<AuthService>.value(
          value: AuthService(),
        ),
        ChangeNotifierProvider<TrayIOSolutionService>.value(
          value: TrayIOSolutionService(),
        ),
        ChangeNotifierProvider<TrayIOSolutionInstanceService>.value(
          value: TrayIOSolutionInstanceService(),
        ),
        ChangeNotifierProvider<TrayIOUserService>.value(
          value: TrayIOUserService(),
        ),
        ChangeNotifierProvider<TrayIOWorkflowService>.value(
          value: TrayIOWorkflowService(),
        ),
      ],
      child: MainApp(),
    ),
  );
}
