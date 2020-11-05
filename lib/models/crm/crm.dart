import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/models/crm/crm_feature.dart';

class Crm with ChangeNotifier {
  String id;
  String name;
  String description;
  String slug;
  bool enabled;
  List<CrmFeature> features;

  Crm({this.id, this.name, this.description, this.enabled, this.slug, this.features}) {}

  factory Crm.fromJson(Map<String, dynamic> json) {
    final crm = Crm(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        enabled: json['enabled'],
        slug: json['slug'],
        features: [
          CrmFeature(id: '123', name: 'People', description: '', enabled: false, slug: 'people'),
          CrmFeature(id: '456', name: 'Media', description: '', enabled: false, slug: 'media'),
          CrmFeature(id: '789', name: 'Verb AI', description: '', enabled: false, slug: 'ai'),
        ]);
    return crm;
  }

  toggleEnabled() {
    this.enabled = !this.enabled;
    this.notifyListeners();
  }

  @override
  String toString() => 'id: $id, name: $name, description: $description, slug: $slug, enabled: $enabled';
}

class CrmRouteArgs {
  final Crm crm;
  CrmRouteArgs(this.crm);
}
