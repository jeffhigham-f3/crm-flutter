import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';
import 'package:verb_crm_flutter/config/import.dart';
import 'package:faker/faker.dart';

class Contact {
  final String id;
  String name;
  final String firstName;
  final String lastName;
  final String email;
  String phone;
  String photoUrl;
  String photoAsset;
  String locale;
  Color accentColor;
  List<String> tags;

  Contact({
    this.id,
    this.name,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.photoUrl,
    this.photoAsset,
    this.locale,
    this.accentColor,
    this.tags,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    final RandomColor _randomColor = RandomColor();

    final contact = Contact(
      id: json['AccountId'] ??= '',
      name: '${json['FirstName']} ${json['LastName']}',
      email: json['Email'] ??= '',
      phone: json['MobilePhone'] ??= '',
      firstName: json['FirstName'] ??= '',
      lastName: json['LastName'] ??= '',
      accentColor: _randomColor.randomColor(colorHue: ColorHue.blue),
      tags: [],
    );
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
      email: faker.internet.email(),
      phone: phone,
      photoAsset: 'assets/avatar/$uuid.png',
      firstName: firstName,
      lastName: lastName,
      accentColor: _randomColor.randomColor(colorHue: ColorHue.blue),
      tags: [],
    );

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

enum FollowUp { today, tomorrow, later }
