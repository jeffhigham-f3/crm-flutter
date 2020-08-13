import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/models/contact.dart';

class ContactManager with ChangeNotifier {
  final List<Contact> _entities = [
    Contact(id: '1', firstName: 'Person', lastName: 'One', photoUrl: 'https://www.thispersondoesnotexist.com/image'),
    Contact(id: '2', firstName: 'Person', lastName: 'Two', photoUrl: 'https://www.thispersondoesnotexist.com/image'),
    Contact(id: '3', firstName: 'Person', lastName: 'Three', photoUrl: 'https://www.thispersondoesnotexist.com/image'),
    Contact(id: '4', firstName: 'Person', lastName: 'Four', photoUrl: 'https://www.thispersondoesnotexist.com/image'),
    Contact(id: '5', firstName: 'Person', lastName: 'Five', photoUrl: 'https://www.thispersondoesnotexist.com/image'),
  ];

  Stream entityStream() async* {
    List<Contact> contacts = [];
    for (var contact in this._entities) {
      contacts.add(contact);
      yield contacts;
    }
  }
}
