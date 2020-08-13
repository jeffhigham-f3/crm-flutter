import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/widgets/contact_list_widget.dart';

class PeopleTomorrowScreen extends StatefulWidget {
  static const String id = 'glance_tomorrow_screen';

  @override
  _PeopleTomorrowScreenState createState() => _PeopleTomorrowScreenState();
}

class _PeopleTomorrowScreenState extends State<PeopleTomorrowScreen> {
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ContactListWidget(),
      ],
    );
  }
}
