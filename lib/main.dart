import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verb_crm_flutter/models/goal_manager.dart';
import 'package:verb_crm_flutter/models/crm_manager.dart';
import 'package:verb_crm_flutter/models/glance_task_manager.dart';
import 'package:verb_crm_flutter/screens/main_app.dart';

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
          create: (_) => GlanceTaskManager(),
        )
      ],
      child: MainApp(),
    ),
  );
}
