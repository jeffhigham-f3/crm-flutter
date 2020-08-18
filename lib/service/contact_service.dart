import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/models/contact.dart';
import 'package:faker/faker.dart';
import 'dart:async';

class ContactService with ChangeNotifier {
  final _controller = StreamController.broadcast();

  ContactService() {
    _controller.sink.add(
      generateContacts(),
    );

    Timer.periodic(
      Duration(seconds: 5),
      (timer) {
        _controller.sink.add(
          generateContacts(),
        );
      },
    );
  }

  Stream get stream => _controller.stream;

  Stream entityStream() async* {
    await Future<void>.delayed(Duration(milliseconds: 700));
    yield generateContacts();
  }

  List<Contact> generateContacts() {
    List<Contact> contacts = [];

    var max = faker.randomGenerator.integer(50, min: 5);
    for (var i = 0; i < max; i++) {
      contacts.add(
        Contact(
          id: '$i',
          firstName: faker.person.firstName(),
          lastName: faker.person.lastName(),
          email: faker.internet.email(),
          photoUrl: 'http://placeimg.com/200/200/people?id=${faker.randomGenerator.integer(50, min: 1)}',
          online: faker.randomGenerator.boolean(),
          locale: 'en',
          lead: faker.randomGenerator.boolean(),
          customer: faker.randomGenerator.boolean(),
          followUp: faker.randomGenerator.boolean(),
        ),
      );
    }
    return contacts;
  }
}
