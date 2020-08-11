import 'package:flutter/material.dart';

class Crm with ChangeNotifier {
  String name;
  String logo;
  Icon icon;
  String token;
  String refreshToken;
  bool enabled;

  Crm({this.name, this.logo}) {
    this.enabled = false;
    this.icon = Icon(Icons.business_center);
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
