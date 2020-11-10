import 'package:verb_crm_flutter/models/contact/contact.dart';
import 'package:flutter/foundation.dart';
import 'package:verb_crm_flutter/config/import.dart';
import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

abstract class ContactServiceAbstract with ChangeNotifier {
  List<Contact> get contacts;
  bool get hasContacts;
  bool get filterActive;
  List<String> get filters;
  Stream get stream;
  Comparator<Contact> lastNameComparator;
  Future<List<Contact>> getAll({@required String triggerUrl});
  Future<List<Contact>> searchAll({@required String searchText});
  Future<List<Contact>> refreshAll();
  Future<void> primeContacts();
  void toggleFilterActive();
}

class ContactService extends ContactServiceAbstract {
  final _controller = StreamController.broadcast();
  final List<Contact> _contacts = [];
  final List<String> _filters = [];
  bool _filterActive = false;
  String _cachedSearchText = '';

  @override
  List<Contact> get contacts => _contacts;

  @override
  bool get hasContacts => contacts.length > 0;

  @override
  bool get filterActive => _filterActive;

  @override
  List<String> get filters => _filters;

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
    final List<Contact> contactsFiltered = [];
    for (var c in _contacts) {
      final bool matchFirst = c.firstName.toLowerCase().startsWith(searchText.toLowerCase());
      final bool matchLast = c.lastName.toLowerCase().startsWith(searchText.toLowerCase());
      final bool matchName = (matchFirst || matchLast);
      bool matchFilters = true;
      if (!matchName) continue;
      if (filters.length == 0) {
        contactsFiltered.add(c);
        continue;
      }

      filters.forEach((filter) {
        if (!c.tags.contains(filter)) matchFilters = false;
      });
      if (!contactsFiltered.contains(c) && matchFilters) contactsFiltered.add(c);
    }

    contactsFiltered.sort(lastNameComparator);
    _controller.sink.add(contactsFiltered);
    return contactsFiltered;
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
  void toggleFilterActive() {
    _filterActive = !_filterActive;
    notifyListeners();
  }

  @override
  void addFilter({String filter}) {
    _filters.add(filter);
    notifyListeners();
  }

  @override
  Future<void> removeFilter({String filter}) async {
    _filters.remove(filter);
    notifyListeners();
  }

  @override
  bool hasFilter({String filter}) {
    return _filters.contains(filter);
  }

  @override
  Future<void> toggleFilter({bool selected, String filter}) async {
    if (selected != null && selected) {
      addFilter(filter: filter);
    } else {
      removeFilter(filter: filter);
    }
    if (_filters.length == 0) toggleFilterActive();
    searchAll(searchText: _cachedSearchText);
  }
}
