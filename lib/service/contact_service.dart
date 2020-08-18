import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/models/contact.dart';
import 'package:faker/faker.dart';
import 'dart:async';

class ContactService with ChangeNotifier {
  final _controller = StreamController.broadcast();

  ContactService() {
    var _count = 1;

    Timer.periodic(
      Duration(seconds: 5),
      (timer) {
        List<Contact> contacts = [];

        var max = faker.randomGenerator.integer(20);
        print("Adding $max contact to stream...");

        for (var i = 0; i < max; i++) {
          contacts.add(
            Contact(
              id: '$_count',
              firstName: faker.person.firstName(),
              lastName: faker.person.lastName(),
              email: faker.internet.email(),
              photoUrl: 'http://placeimg.com/200/200/people?id=${faker.randomGenerator.integer(100000)}',
              online: faker.randomGenerator.boolean(),
              locale: 'en',
              lead: true,
              customer: faker.randomGenerator.boolean(),
              followUp: true,
            ),
          );
        }
        _controller.sink.add(contacts);
        _count++;
      },
    );
  }

  Stream get stream => _controller.stream;

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
          locale: 'en',
          lead: faker.randomGenerator.boolean(),
          customer: faker.randomGenerator.boolean(),
          followUp: faker.randomGenerator.boolean(),
        ),
      );
      yield contacts;
    }
  }
}
