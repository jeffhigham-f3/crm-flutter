import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  get logoSvg {
    final String assetName = 'assets/${this.logo}';
    return SvgPicture.asset(
      assetName,
      semanticsLabel: this.name,
    );
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
