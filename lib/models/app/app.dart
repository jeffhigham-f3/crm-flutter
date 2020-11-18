import 'package:flutter/material.dart';

class App with ChangeNotifier {
  String id;
  String name;
  String description;
  String slug;
  bool enabled;

  App({this.id, this.name, this.description, this.enabled, this.slug});

  factory App.fromFirestore(Map<String, dynamic> json) {
    final app = App(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        enabled: json['enabled'],
        slug: json['slug']);
    return app;
  }

  factory App.fromConfig(Map<String, dynamic> json) {
    final app = App(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        enabled: json['enabled'],
        slug: json['slug']);
    return app;
  }

  toggleEnabled() {
    this.enabled = !this.enabled;
    this.notifyListeners();
  }

  @override
  String toString() => 'id: $id, name: $name, description: $description, slug: $slug, enabled: $enabled';
}
