import 'package:flutter/material.dart';

class AppFeature with ChangeNotifier {
  String id;
  String name;
  String description;
  String slug;
  bool enabled;

  AppFeature({this.id, this.name, this.description, this.enabled, this.slug});

  factory AppFeature.fromJson(Map<String, dynamic> json) {
    final feature = AppFeature(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      enabled: json['enabled'],
      slug: json['slug'],
    );
    return feature;
  }

  toggleEnabled() {
    this.enabled = !this.enabled;
    this.notifyListeners();
  }

  @override
  String toString() => 'id: $id, name: $name, description: $description, slug: $slug, enabled: $enabled';
}
