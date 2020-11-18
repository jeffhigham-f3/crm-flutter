import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum AppFeatureType { Contact, Media, Unknown }

class AppFeature with ChangeNotifier {
  String id;
  bool enabled;
  AppFeatureType featureType;
  AppFeature({this.id, this.enabled, this.featureType});

  factory AppFeature.fromMap(Map<String, dynamic> m) {
    final feature = AppFeature(
      id: m['id'],
      enabled: m['enabled'],
      featureType: m['featureType'],
    );
    return feature;
  }

  Future<void> toggleEnabled() {
    this.enabled = !this.enabled;
    this.notifyListeners();
  }

  String get name => _getName();
  IconData get icon => _getIcon();

  String _getName() {
    switch (featureType) {
      case AppFeatureType.Contact:
        return 'People';
        break;

      case AppFeatureType.Media:
        return 'Media';
        break;

      default:
        return 'Unknown';
    }
  }

  IconData _getIcon() {
    switch (featureType) {
      case AppFeatureType.Contact:
        return FontAwesomeIcons.addressBook;
        break;

      case AppFeatureType.Media:
        return FontAwesomeIcons.photoVideo;
        break;

      default:
        return FontAwesomeIcons.question;
    }
  }

  @override
  String toString() => 'id: $id, enabled: $enabled, featureType: $featureType';
}
