import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';
import 'package:faker/faker.dart';

class Contact {
  final String id;
  String name;
  final String firstName;
  final String lastName;
  final String email;
  String phone;
  String photoUrl;
  String locale;
  bool lead;
  bool customer;
  bool online;
  bool followUp;
  Color accentColor;

  Contact(
      {this.id,
      this.name,
      this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.photoUrl,
      this.locale,
      this.lead,
      this.customer,
      this.followUp,
      this.online,
      this.accentColor});

  factory Contact.fromJson(Map<String, dynamic> json) {
    final RandomColor _randomColor = RandomColor();

    final contact = Contact(
      id: json['AccountId'] ??= '',
      name: '${json['FirstName']} ${json['LastName']}',
      email: json['Email'] ??= '',
      phone: json['MobilePhone'] ??= '',
      firstName: json['FirstName'] ??= '',
      lastName: json['LastName'] ??= '',
      lead: false,
      customer: true,
      followUp: faker.randomGenerator.boolean(),
      online: faker.randomGenerator.boolean(),
      accentColor: _randomColor.randomColor(colorHue: ColorHue.blue),
    );
    return contact;
  }

  String get initials => (firstName?.isNotEmpty == true && lastName?.isNotEmpty == true)
      ? '${firstName.substring(0, 1).toUpperCase()}${lastName.substring(0, 1).toUpperCase()}'
      : id.substring(0, 2).toUpperCase();

  @override
  String toString() =>
      'id: $id, firstName: $firstName, lastName: $lastName, initials $initials, email: $email, phone: $phone';
}

enum FollowUp { today, tomorrow, later }
