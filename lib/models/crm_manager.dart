import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/models/crm.dart';

class CrmManager with ChangeNotifier {
  final List<Crm> entities = [
    Crm(name: "SalesForce"),
    Crm(name: "HubSpot"),
    Crm(name: "Netsuite"),
    Crm(name: "Verb CRM"),
  ];

  toggle({Crm crm}) {
    crm.enabled = !crm.enabled;
    this.notifyListeners();
  }
}
