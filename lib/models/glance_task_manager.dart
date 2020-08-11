import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/models/glance_task.dart';

class GlanceTaskManager with ChangeNotifier {
  final List<GlanceTask> entities = [
    GlanceTask(name: "Task 1", description: "This is task one."),
    GlanceTask(name: "Task 2", description: "This is task twp."),
    GlanceTask(name: "Task 3", description: "This is task three."),
    GlanceTask(name: "Task 4", description: "This is task four."),
    GlanceTask(name: "Task 5", description: "This is task five."),
    GlanceTask(name: "Task 6", description: "This is task six."),
    GlanceTask(name: "Task 7", description: "This is task seven."),
    GlanceTask(name: "Task 8", description: "This is task eight."),
    GlanceTask(name: "Task 9", description: "This is task nine."),
    GlanceTask(name: "Task 10", description: "This is task ten."),
  ];

  toggle({GlanceTask task}) {
    task.completed = !task.completed;
    this.notifyListeners();
  }
}
