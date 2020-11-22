import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/app/import.dart';
import 'package:verb_crm_flutter/contact/import.dart';
import 'package:contacts_service/contacts_service.dart' as device;
import 'package:platform_info/platform_info.dart';
import 'package:permission_handler/permission_handler.dart';

enum AppType { Device, CRM, Unknown }
enum AppProduct { HubSpot, Salesforce, Google, Verb, IOS, Android, Web }

class App with ChangeNotifier {
  String id;
  String name;
  String description;
  String slug;
  List<AppFeature> features;
  IconData icon;
  bool enabled;
  AppType appType;
  AppProduct appProduct;

  App({
    this.id,
    this.name,
    this.description,
    this.enabled,
    this.icon,
    this.slug,
    this.appType,
    this.appProduct,
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
      appType: m['appType'] as AppType,
      appProduct: m['appProduct'] as AppProduct,
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

  Future<List<Contact>> get contacts => _loadContacts();
  Future<List<Contact>> _loadContacts() async {
    if (!hasFeaturesContact) return [];
    switch (appType) {
      case AppType.Device:
        return await _loadDeviceContacts();
        break;

      case AppType.CRM:
        return [];
        break;

      default:
        print(appType);
        return [];
        break;
    }
  }

  Future<PermissionStatus> _requestPermissions() async {
    PermissionStatus status = await Permission.contacts.status;
    if (status.isUndetermined) status = await Permission.contacts.request();
    // if (status.isDenied || status.isPermanentlyDenied || status.isRestricted) ;
    // if (status.isGranted) ;
    return status;
  }

  Future<List<Contact>> _loadDeviceContacts() async {
    final List<Contact> contacts = [];
    if (!hasFeaturesContact || Platform.instance.isWeb) return contacts;

    final status = await _requestPermissions();
    if (status.isGranted) {
      var deviceContacts =
          (await device.ContactsService.getContacts(withThumbnails: true, iOSLocalizedLabels: kiOSLocalizedLabels))
              .toList();
      deviceContacts.forEach(
        (c) {
          contacts.add(Contact.fromDevice(c));
        },
      );
    }
    return contacts;
  }

  @override
  String toString() =>
      'id: $id, name: $name, description: $description, slug: $slug, enabled: $enabled, features: ${features.toString()}';
}
