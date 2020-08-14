import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String photoUrl;
  final String firstName;
  final String lastName;
  final String locale;
  final String authProvider;

  const User({
    @required this.id,
    @required this.name,
    @required this.firstName,
    @required this.lastName,
    @required this.email,
    @required this.photoUrl,
    @required this.locale,
    @required this.authProvider,
  });

  factory User.fromAuth0(Map<String, Object> user) {
    final sub = user['sub'];
    final firstName = user['given_name'];
    final lastName = user['family_name'];
    final name = user['name'];
    final photoUrl = user['picture'];
    final locale = user['locale'];
    final authProvider = sub.toString().split('|')[0];
    final id = sub.toString().split('|')[1];

    return User(
      id: id,
      name: name,
      email: '',
      photoUrl: photoUrl,
      firstName: firstName,
      lastName: lastName,
      locale: locale,
      authProvider: authProvider,
    );
  }

  factory User.fromFirebase(FirebaseUser user) {
    print(user);
    final String name = (user.displayName?.isNotEmpty == true) ? user.displayName : 'Anonymous';
    final int index = name.indexOf(RegExp(r'\s'));
    final String firstName = index < 0 ? name : name.substring(0, index);
    final String lastName = index < 0 ? '' : name.substring(index + 1);

    return User(
      id: user.uid,
      name: name,
      email: user.email,
      photoUrl: user.photoUrl,
      firstName: firstName,
      lastName: lastName,
      locale: 'en',
      authProvider: 'FirebaseAuth',
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    final String firstName = json['firstName'] ?? '';
    final String lastName = json['lastName'] ?? '';

    return User(
      id: json['username'],
      name: '$firstName $lastName',
      email: json['emailAddress'],
      photoUrl: null,
      firstName: firstName,
      lastName: lastName,
    );
  }

  String get initials => (firstName?.isNotEmpty == true && lastName?.isNotEmpty == true)
      ? '${firstName.substring(0, 1).toUpperCase()}${lastName.substring(0, 1).toUpperCase()}'
      : id.substring(0, 2).toUpperCase();

  @override
  String toString() => '[$id] $firstName $lastName ($initials),$email';
}
