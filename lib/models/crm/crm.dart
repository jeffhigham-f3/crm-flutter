import 'package:flutter/material.dart';

class Crm with ChangeNotifier {
  String name;
  String logo;
  Icon icon;
  String token;
  String refreshToken;
  bool enabled;

  Crm({this.name, this.logo}) {}

  factory Crm.fromJson(Map<String, dynamic> json) {
    final crm = Crm(name: json['name']);
    return crm;
  }

  toggleEnabled() {
    this.enabled = !this.enabled;
    this.notifyListeners();
  }
}

class CrmRouteArgs {
  final Crm crm;
  CrmRouteArgs(this.crm);
}
