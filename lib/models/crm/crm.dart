import 'package:flutter/material.dart';

class Crm with ChangeNotifier {
  String id;
  String name;
  String description;
  String slug;
  bool enabled;

  Crm({this.id, this.name, this.description, this.enabled, this.slug});

  factory Crm.fromJson(Map<String, dynamic> json) {
    final crm = Crm(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        enabled: json['enabled'],
        slug: json['slug']);
    return crm;
  }

  toggleEnabled() {
    this.enabled = !this.enabled;
    this.notifyListeners();
  }

  @override
  String toString() => 'id: $id, name: $name, description: $description, slug: $slug, enabled: $enabled';
}
