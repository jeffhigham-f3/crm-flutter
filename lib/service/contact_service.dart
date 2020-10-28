import 'package:verb_crm_flutter/models/contact.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

abstract class ContactServiceAbstract with ChangeNotifier {
  List<Contact> get contacts;
  bool get hasContacts;
  Stream get stream;
  Comparator<Contact> lastNameComparator;
  Future<List<Contact>> getAll({@required String triggerUrl});
  Future<List<Contact>> searchAll({@required String searchText});
  Future<List<Contact>> refreshAll();
}

class ContactService extends ContactServiceAbstract {
  final _controller = StreamController.broadcast();
  final List<Contact> _contacts = [];

  @override
  List<Contact> get contacts => _contacts;

  @override
  bool get hasContacts => contacts.length > 0;

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
    final List<Contact> contactsFiltered = [];
    for (var c in _contacts) {
      if (c.lastName.toLowerCase().startsWith(
                searchText.toLowerCase(),
              ) ||
          c.firstName.toLowerCase().startsWith(
                searchText.toLowerCase(),
              )) {
        contactsFiltered.add(c);
      }
    }
    contactsFiltered.sort(lastNameComparator);
    _controller.sink.add(contactsFiltered);
    return contactsFiltered;
  }

  @override
  Future<List<Contact>> refreshAll() async {
    await Future.delayed(const Duration(milliseconds: 5));
    _controller.sink.add(_contacts);
    return _contacts;
  }
}
