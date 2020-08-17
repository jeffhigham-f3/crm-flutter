import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/models/contact.dart';
import 'package:faker/faker.dart';

// TODO: move to services/contact_service.dart

class ContactManager with ChangeNotifier {
  Stream entityStream() async* {
    await Future<void>.delayed(Duration(milliseconds: 700));

    List<Contact> contacts = [];
    for (var i = 0; i < 20; i++) {
      await Future<void>.delayed(Duration(milliseconds: 10));
      contacts.add(
        Contact(
          id: '$i',
          firstName: faker.person.firstName(),
          lastName: faker.person.lastName(),
          email: faker.internet.email(),
          photoUrl: 'http://placeimg.com/200/200/people?id=${faker.randomGenerator.integer(100000)}',
          online: faker.randomGenerator.boolean(),
        ),
      );
      yield contacts;
    }
  }
}
