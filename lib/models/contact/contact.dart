import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';
import 'package:verb_crm_flutter/config/import.dart';
import 'package:faker/faker.dart';
import 'package:contacts_service/contacts_service.dart' as device;

enum ContactSource { Generated, Device, External }

// TODO: - refactor email, phone, address, into lists.
// TODO: - Update UI to support multiple phones, emails, addresses
class Contact {
  final String id;
  String name;
  String firstName;
  String lastName;
  Iterable<device.Item> emails = [];
  Iterable<device.Item> phones = [];
  Iterable<device.PostalAddress> postalAddresses = [];
  String photoUrl;
  String photoAsset;
  String locale;
  List<String> tags;
  Color accentColor;
  ContactSource source;
  device.Item get email => emails.length > 0 ? emails.first : null;
  device.Item get phone => phones.length > 0 ? phones.first : null;
  device.PostalAddress get postalAddress => postalAddresses.length > 0 ? postalAddresses.first : null;

  Contact({
    this.id,
    this.name,
    this.firstName,
    this.lastName,
    this.emails,
    this.phones,
    this.postalAddresses,
    this.photoUrl,
    this.photoAsset,
    this.locale,
    this.accentColor,
    this.source,
    this.tags,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    final RandomColor _randomColor = RandomColor();
    final contact = Contact(
      id: json['AccountId'] ??= '',
      name: '${json['FirstName']} ${json['LastName']}',
      firstName: json['FirstName'] ??= '',
      lastName: json['LastName'] ??= '',
      accentColor: _randomColor.randomColor(colorHue: ColorHue.blue),
      source: ContactSource.External,
      tags: [],
    );
    contact.emails = [
      device.Item.fromMap(
        {'label': 'email', 'value': json['Email']},
      )
    ];
    contact.phones = [
      device.Item.fromMap(
        {'label': 'phone', 'value': json['MobilePhone']},
      )
    ];
    return contact;
  }

  factory Contact.fromDevice(device.Contact c) {
    final RandomColor _randomColor = RandomColor();
    final contact = Contact(
      id: c.identifier,
      name: '${c.givenName} ${c.familyName}',
      firstName: c.givenName,
      lastName: c.familyName,
      accentColor: _randomColor.randomColor(colorHue: ColorHue.blue),
      emails: c.emails,
      phones: c.phones,
      postalAddresses: c.postalAddresses,
      source: ContactSource.Device,
      tags: [],
    );

    if (faker.randomGenerator.boolean()) contact.tags.add(kSlugLead);
    if (faker.randomGenerator.boolean() && !contact.lead) contact.tags.add(kSlugCustomer);
    if (faker.randomGenerator.boolean()) contact.tags.add(kSlugFollowUp);
    if (faker.randomGenerator.boolean()) contact.tags.add(kSlugOnline);
    return contact;
  }

  factory Contact.generate({String uuid}) {
    final RandomColor _randomColor = RandomColor();
    final firstName = faker.person.firstName();
    final lastName = faker.person.lastName();
    final numbers = faker.randomGenerator.numbers(9, 10);
    final phone =
        '(${numbers[0]}${numbers[1]}${numbers[2]}) ${numbers[3]}${numbers[4]}${numbers[5]}-${numbers[6]}${numbers[7]}${numbers[8]}${numbers[8]}';

    final contact = Contact(
      id: uuid,
      name: '$firstName $lastName',
      photoAsset: 'assets/avatar/$uuid.png',
      firstName: firstName,
      lastName: lastName,
      accentColor: _randomColor.randomColor(colorHue: ColorHue.blue),
      source: ContactSource.Generated,
      tags: [],
    );
    contact.emails = [
      device.Item.fromMap(
        {'label': 'email', 'value': faker.internet.email()},
      ),
    ];
    contact.phones = [
      device.Item.fromMap(
        {'label': 'phone', 'value': phone},
      ),
    ];

    if (faker.randomGenerator.boolean()) contact.tags.add(kSlugLead);
    if (faker.randomGenerator.boolean() && !contact.lead) contact.tags.add(kSlugCustomer);
    if (faker.randomGenerator.boolean()) contact.tags.add(kSlugFollowUp);
    if (faker.randomGenerator.boolean()) contact.tags.add(kSlugOnline);
    return contact;
  }

  bool get lead => this.tags.contains(kSlugLead);
  bool get customer => this.tags.contains(kSlugCustomer);
  bool get followUp => this.tags.contains(kSlugFollowUp);
  bool get online => this.tags.contains(kSlugOnline);

  String get initials => (firstName?.isNotEmpty == true && lastName?.isNotEmpty == true)
      ? '${firstName.substring(0, 1).toUpperCase()}${lastName.substring(0, 1).toUpperCase()}'
      : id.substring(0, 2).toUpperCase();

  @override
  String toString() =>
      'id: $id, firstName: $firstName, lastName: $lastName, initials $initials, email: $email, phone: $phone, photoUrl: $photoUrl, photoAsset: $photoAsset';
}
