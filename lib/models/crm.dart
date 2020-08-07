import 'package:flutter/material.dart';

class Crm {
  String name;
  String logo;
  Icon icon;
  String token;
  String refreshToken;
  bool enabled;

  Crm({this.name}) {
    this.enabled = false;
    this.icon = Icon(Icons.business_center);
  }
}
