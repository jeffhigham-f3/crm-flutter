import 'package:verb_crm_flutter/config/constants.dart';
import 'package:verb_crm_flutter/models/contact/contact.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:platform_info/platform_info.dart';
import 'package:contacts_service/contacts_service.dart' as device;
import 'package:verb_crm_flutter/service/import.dart';
import 'dart:async';

abstract class _ContactServiceAbstract with ChangeNotifier {
  AppService get appService;
  List<Contact> get contacts;
  List<Contact> get visibleContacts;
  List<Contact> get followUpContacts;
  List<String> get tags;
  bool get hasContacts;
  bool get tagActive;
  Comparator<Contact> lastNameComparator;
  Future<void> searchAll({@required String searchText});
  Future<void> refreshAll();
  Future<PermissionStatus> requestPermissions();
  Future<void> loadDeviceContacts();
  void toggleTagActive();
  Future<void> toggleTag({String tag});
  void addTag({String tag});
  void removeTag({String tag});
  bool hasTag({String tag});
}

class ContactService extends _ContactServiceAbstract {
  final List<Contact> _contacts = [];
  List<Contact> _visibleContacts = [];
  List<Contact> _followUpContacts = [];
  final List<String> _tags = [];
  bool _tagActive = false;
  String _cachedSearchText = '';
  AppService _appService;

  ContactService({@required AppService appService}) : _appService = appService;

  AppService get appService => _appService;

  @override
  List<Contact> get contacts => _contacts;

  @override
  List<Contact> get visibleContacts => _visibleContacts;

  @override
  List<Contact> get followUpContacts => _followUpContacts;

  @override
  bool get hasContacts => contacts.length > 0;

  @override
  bool get tagActive => _tagActive;

  @override
  List<String> get tags => _tags;

  @override
  Comparator<Contact> lastNameComparator = (c1, c2) => c1.lastName.compareTo(c2.lastName);

  @override
  Future<void> searchAll({@required String searchText}) async {
    _cachedSearchText = searchText;
    final List<Contact> contactsWithTags = [];
    for (var c in _contacts) {
      final bool matchFirst = c.firstName.toLowerCase().startsWith(searchText.toLowerCase());
      final bool matchLast = c.lastName.toLowerCase().startsWith(searchText.toLowerCase());
      final bool matchName = (matchFirst || matchLast);
      bool matchTags = true;
      if (!matchName) continue;
      if (tags.length == 0) {
        contactsWithTags.add(c);
        continue;
      }
      tags.forEach((tag) {
        if (!c.tags.contains(tag)) matchTags = false;
      });
      if (!contactsWithTags.contains(c) && matchTags) contactsWithTags.add(c);
    }
    contactsWithTags.sort(lastNameComparator);
    _visibleContacts = contactsWithTags;
    notifyListeners();
  }

  @override
  Future<void> refreshAll() async {
    // TODO - Load contacts from apps with contacts enabled (app.dart:76)
    print(
        'ContactService can see ${_appService.appsContact.length} contact apps with ${_appService.appsContactEnabled.length} enabled.');
    _contacts.removeRange(0, _contacts.length);
    _tags.removeRange(0, tags.length);
    _tagActive = false;
    await Future.delayed(Duration(seconds: 1));
    await loadDeviceContacts();
    kContactUUIDs.forEach((uuid) {
      _contacts.add(Contact.generate(uuid: uuid));
    });
    _contacts.sort(lastNameComparator);
    _visibleContacts = _contacts;
    _followUpContacts = _contacts.where((contact) {
      return (contact.tags.contains(kSlugOnline) && contact.tags.contains(kSlugFollowUp));
    }).toList();
    notifyListeners();
  }

  @override
  void toggleTagActive() {
    _tagActive = !_tagActive;
    notifyListeners();
  }

  @override
  void addTag({String tag}) {
    _tags.add(tag);
    notifyListeners();
  }

  @override
  void removeTag({String tag}) {
    _tags.remove(tag);
    notifyListeners();
  }

  @override
  bool hasTag({String tag}) {
    return _tags.contains(tag);
  }

  @override
  Future<void> toggleTag({String tag}) async {
    if (hasTag(tag: tag)) {
      removeTag(tag: tag);
    } else {
      addTag(tag: tag);
    }
    if (_tags.length == 0) toggleTagActive();
    await searchAll(searchText: _cachedSearchText);
  }

  @override
  Future<PermissionStatus> requestPermissions() async {
    PermissionStatus status = await Permission.contacts.status;
    if (status.isUndetermined) status = await Permission.contacts.request();
    // if (status.isDenied || status.isPermanentlyDenied || status.isRestricted) ;
    // if (status.isGranted) ;
    notifyListeners();
    return status;
  }

  @override
  Future<void> loadDeviceContacts() async {
    if (Platform.instance.isWeb) return;

    final status = await requestPermissions();
    if (status.isGranted) {
      var deviceContacts =
          (await device.ContactsService.getContacts(withThumbnails: true, iOSLocalizedLabels: kiOSLocalizedLabels))
              .toList();
      deviceContacts.forEach(
        (c) {
          _contacts.add(Contact.fromDevice(c));
        },
      );
    }
    notifyListeners();
  }
}
