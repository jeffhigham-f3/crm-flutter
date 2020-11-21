import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/app/import.dart';
import 'package:verb_crm_flutter/contact/import.dart';

enum AppType { Device, CRM, Unknown }

class App with ChangeNotifier {
  String id;
  String name;
  String description;
  String slug;
  List<AppFeature> features;
  IconData icon;
  bool enabled;
  AppType appType;

  App({
    this.id,
    this.name,
    this.description,
    this.enabled,
    this.icon,
    this.slug,
    this.appType,
  });

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
    return app;
  }

  toggleEnabled() {
    this.enabled = !this.enabled;
    this.notifyListeners();
  }

  bool get hasFeatures => features.length > 0;
  bool get hasEnabledFeatures => features.where((f) => f.enabled).toList().length > 0;
  bool get hasFeaturesContact => featuresContact.length > 0;
  bool get hasFeaturesMedia => featuresMedia.length > 0;
  List<AppFeature> get featuresContact => _getFeatures(AppFeatureType.Contact);
  List<AppFeature> get featuresMedia => _getFeatures(AppFeatureType.Media);
  List<AppFeature> get featuresContactEnabled => _getEnabledFeatures(featuresContact);
  List<AppFeature> get featuresMediaEnabled => _getEnabledFeatures(featuresMedia);

  List<AppFeature> _getFeatures(AppFeatureType featureType) {
    return features.where((f) => f.featureType == featureType).toList();
  }

  List<AppFeature> _getEnabledFeatures(List<AppFeature> features) {
    return features.where((f) => f.enabled == true).toList();
  }

  // TODO - Complete contat loading for each AppType
  Future<List<Contact>> get contacts => _loadContacts();
  Future<List<Contact>> _loadContacts() async {
    if (!hasFeaturesContact) return [];
    switch (appType) {
      case AppType.Device:
        print("Device");
        break;

      case AppType.CRM:
        print("CRM");
        break;

      default:
        break;
    }
  }

  @override
  String toString() =>
      'id: $id, name: $name, description: $description, slug: $slug, enabled: $enabled, features: ${features.toString()}';
}
