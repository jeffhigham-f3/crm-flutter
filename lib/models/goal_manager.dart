import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/models/goal.dart';

class GoalManager with ChangeNotifier {
  final List<Goal> entities = [
    Goal(name: "Increase Sales"),
    Goal(name: "Prospecting"),
    Goal(name: "Conversion"),
    Goal(name: "Build Downline")
  ];

  toggle({Goal goal}) {
    goal.enabled = !goal.enabled;
    this.notifyListeners();
  }
}
