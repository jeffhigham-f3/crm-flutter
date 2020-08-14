class Contact {
  final String id;
  String name;
  final String firstName;
  final String lastName;
  String email;
  String phone;
  String photoUrl;
  String locale;
  bool prospect;
  bool lead;
  FollowUp followUp;

  Contact({
    this.id,
    this.name,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.photoUrl,
    this.locale,
  });

  String get initials => (firstName?.isNotEmpty == true && lastName?.isNotEmpty == true)
      ? '${firstName.substring(0, 1).toUpperCase()}${lastName.substring(0, 1).toUpperCase()}'
      : id.substring(0, 2).toUpperCase();

  @override
  String toString() => '[$id] $firstName $lastName ($initials),$email';
}

enum FollowUp { today, tomorrow, later }
