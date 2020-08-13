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
    this.firstName,
    this.lastName,
    this.photoUrl,
  });
}

enum FollowUp { today, tomorrow, later }
