import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:random_color/random_color.dart';
import 'package:verb_crm_flutter/config/import.dart';
import 'package:faker/faker.dart';
import 'dart:math';
import 'package:contacts_service/contacts_service.dart' as device;

enum ContactSource {
  Generated,
  Device,
  SalesForce,
  HubSpot,
  Google,
  Facebook,
  Verb,
  External,
  Apple,
  Whatsapp,
  Linkedin,
  Slack,
  Microsoft
}

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

    final contact = Contact(
      id: uuid,
      name: '$firstName $lastName',
      photoAsset: 'assets/avatar/$uuid.png',
      firstName: firstName,
      lastName: lastName,
      accentColor: _randomColor.randomColor(colorHue: ColorHue.blue),
      source: Contact.randomSource(),
      tags: [],
    );
    contact.emails = [
      device.Item.fromMap(
        {'label': 'home', 'value': faker.internet.email()},
      ),
      device.Item.fromMap(
        {'label': 'work', 'value': faker.internet.email()},
      ),
    ];
    contact.phones = [
      device.Item.fromMap(
        {'label': 'mobile', 'value': Contact.generatePhoneNumber()},
      ),
      device.Item.fromMap(
        {'label': 'work', 'value': Contact.generatePhoneNumber()},
      ),
      device.Item.fromMap(
        {'label': 'home', 'value': Contact.generatePhoneNumber()},
      ),
    ];

    if (faker.randomGenerator.boolean()) contact.tags.add(kSlugLead);
    if (faker.randomGenerator.boolean() && !contact.lead) contact.tags.add(kSlugCustomer);
    if (faker.randomGenerator.boolean()) contact.tags.add(kSlugFollowUp);
    if (faker.randomGenerator.boolean()) contact.tags.add(kSlugOnline);
    return contact;
  }

  IconData getIconSource() {
    switch (source) {
      case ContactSource.Device:
        return FontAwesomeIcons.mobileAlt;
        break;

      case ContactSource.Generated:
        return FontAwesomeIcons.code;
        break;

      case ContactSource.External:
        return FontAwesomeIcons.cloud;
        break;

      case ContactSource.Facebook:
        return FontAwesomeIcons.facebookF;
        break;

      case ContactSource.SalesForce:
        return FontAwesomeIcons.salesforce;
        break;

      case ContactSource.HubSpot:
        return FontAwesomeIcons.hubspot;
        break;

      case ContactSource.Google:
        return FontAwesomeIcons.google;
        break;

      case ContactSource.Apple:
        return FontAwesomeIcons.apple;
        break;

      case ContactSource.Whatsapp:
        return FontAwesomeIcons.whatsapp;
        break;

      case ContactSource.Linkedin:
        return FontAwesomeIcons.linkedinIn;
        break;

      case ContactSource.Slack:
        return FontAwesomeIcons.slack;
        break;

      case ContactSource.Microsoft:
        return FontAwesomeIcons.microsoft;
        break;

      default:
        return FontAwesomeIcons.exclamation;
    }
  }

  static String generatePhoneNumber() {
    final numbers = faker.randomGenerator.numbers(9, 10);
    return '(${numbers[0]}${numbers[1]}${numbers[2]}) ${numbers[3]}${numbers[4]}${numbers[5]}-${numbers[6]}${numbers[7]}${numbers[8]}${numbers[8]}';
  }

  static ContactSource randomSource() {
    final sources = [
      ContactSource.SalesForce,
      ContactSource.HubSpot,
      ContactSource.Facebook,
      ContactSource.Google,
      ContactSource.Apple,
      ContactSource.Whatsapp,
      ContactSource.Linkedin,
      ContactSource.Slack,
      ContactSource.Microsoft
    ];
    int index = Random().nextInt(sources.length);
    return sources.elementAt(index);
  }

  device.Item get email => emails.length > 0 ? emails.first : null;
  device.Item get phone => phones.length > 0 ? phones.first : null;
  device.PostalAddress get postalAddress => postalAddresses.length > 0 ? postalAddresses.first : null;
  bool get lead => tags.contains(kSlugLead);
  bool get customer => tags.contains(kSlugCustomer);
  bool get followUp => tags.contains(kSlugFollowUp);
  bool get online => tags.contains(kSlugOnline);
  IconData get sourceIcon => getIconSource();

  String get initials => (firstName?.isNotEmpty == true && lastName?.isNotEmpty == true)
      ? '${firstName.substring(0, 1).toUpperCase()}${lastName.substring(0, 1).toUpperCase()}'
      : id.substring(0, 2).toUpperCase();

  @override
  String toString() =>
      'id: $id, firstName: $firstName, lastName: $lastName, initials $initials, email: $email, phone: $phone, photoUrl: $photoUrl, photoAsset: $photoAsset';
}
