import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/models/goal.dart';

class GoalManager with ChangeNotifier {
  final List<Goal> entities = [
    Goal(name: "Goal 1"),
    Goal(name: "Goal 2"),
    Goal(name: "Goal 3"),
    Goal(name: "Goal N"),
  ];

  toggle({Goal goal}) {
    goal.enabled = !goal.enabled;
    this.notifyListeners();
  }
}
