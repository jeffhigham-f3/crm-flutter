import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/app/import.dart';

class App with ChangeNotifier {
  String id;
  String name;
  String description;
  String slug;
  List<AppFeature> features;
  IconData icon;
  bool enabled;

  App({this.id, this.name, this.description, this.enabled, this.icon, this.slug});

  factory App.fromFirestore(Map<String, dynamic> m) {
    final app = App(
      id: m['id'],
      name: m['name'],
      description: m['description'],
      enabled: m['enabled'],
      slug: m['slug'],
    );
    return app;
  }

  factory App.fromConfig(Map<String, dynamic> m) {
    final app = App(
      id: m['id'],
      name: m['name'],
      description: m['description'],
      enabled: (m['enabled'] as bool),
      icon: (m['icon'] as IconData),
      slug: m['slug'],
    );
    app.features = [];
    (m['features'] as List<Map<String, dynamic>>).forEach((f) {
      app.features.add(AppFeature.fromMap(f));
    });
    print(app);
    return app;
  }

  toggleEnabled() {
    this.enabled = !this.enabled;
    this.notifyListeners();
  }

  bool hasActiveFeatures() {
    return features
            .where(
              (f) => f.enabled,
            )
            .toList()
            .length >
        0;
  }

  @override
  String toString() =>
      'id: $id, name: $name, description: $description, slug: $slug, enabled: $enabled, features: ${features.toString()}';
}
