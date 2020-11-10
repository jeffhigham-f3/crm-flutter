import 'package:verb_crm_flutter/models/contact/contact.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

abstract class ContactServiceAbstract with ChangeNotifier {
  List<Contact> get contacts;
  bool get hasContacts;
  bool get tagActive;
  List<String> get tags;
  Stream get stream;
  Comparator<Contact> lastNameComparator;
  Future<List<Contact>> getAll({@required String triggerUrl});
  Future<List<Contact>> searchAll({@required String searchText});
  Future<List<Contact>> refreshAll();
  Future<void> primeContacts();
  void toggleTagActive();
}

class ContactService extends ContactServiceAbstract {
  final _controller = StreamController.broadcast();
  final List<Contact> _contacts = [];
  final List<String> _tags = [];
  bool _tagActive = false;
  String _cachedSearchText = '';

  @override
  List<Contact> get contacts => _contacts;

  @override
  bool get hasContacts => contacts.length > 0;

  @override
  bool get tagActive => _tagActive;

  @override
  List<String> get tags => _tags;

  @override
  Stream get stream => _controller.stream;

  @override
  Comparator<Contact> lastNameComparator = (c1, c2) => c1.lastName.compareTo(c2.lastName);

  @override
  Future<List<Contact>> getAll({@required String triggerUrl}) async {
    if (triggerUrl == null) {
      _controller.sink.add([]);
      return [];
    }
    var response = await http.get(triggerUrl);
    _contacts.removeRange(0, _contacts.length);
    switch (response.statusCode) {
      case 200:
        {
          var jsonResponse = convert.jsonDecode(response.body);
          for (var c in jsonResponse) {
            _contacts.add(Contact.fromJson(c));
          }
          _contacts.sort(lastNameComparator);
          _controller.sink.add(_contacts);
          return _contacts;
        }
        break;

      default:
        _controller.sink.add([]);
        return [];
        break;
    }
  }

  @override
  Future<List<Contact>> searchAll({@required String searchText}) async {
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
    _controller.sink.add(contactsWithTags);
    return contactsWithTags;
  }

  @override
  Future<List<Contact>> refreshAll() async {
    await Future.delayed(const Duration(milliseconds: 10));
    if (_contacts.isEmpty) {
      await primeContacts();
      return null;
    }
    _controller.sink.add(_contacts);
    notifyListeners();
    return _contacts;
  }

  @override
  Future<void> primeContacts() async {
    Iterable<int>.generate(25).toList().forEach(
      (_) {
        _contacts.add(Contact.generate());
      },
    );
    notifyListeners();
  }

  @override
  void toggleTagActive() {
    _tagActive = !_tagActive;
    notifyListeners();
  }

  void addTag({String tag}) {
    _tags.add(tag);
    notifyListeners();
  }

  Future<void> removeTag({String tag}) async {
    _tags.remove(tag);
    notifyListeners();
  }

  bool hasTag({String tag}) {
    return _tags.contains(tag);
  }

  Future<void> toggleTag({bool selected, String tag}) async {
    if (selected != null && selected) {
      addTag(tag: tag);
    } else {
      removeTag(tag: tag);
    }
    if (_tags.length == 0) toggleTagActive();
    searchAll(searchText: _cachedSearchText);
  }
}
