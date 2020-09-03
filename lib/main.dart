import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verb_crm_flutter/models/goal_manager.dart';
import 'package:verb_crm_flutter/models/crm_manager.dart';
import 'package:verb_crm_flutter/service/glance_service.dart';
import 'package:verb_crm_flutter/service/contact_service.dart';
import 'package:verb_crm_flutter/service/tray_io_service.dart';
import 'package:verb_crm_flutter/screens/main_app.dart';
import 'package:verb_crm_flutter/service/auth_service.dart';

void main() {
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
        ChangeNotifierProvider<TrayIOService>.value(
          value: TrayIOService(),
        ),
      ],
      child: MainApp(),
    ),
  );
}
