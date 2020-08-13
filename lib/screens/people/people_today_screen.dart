import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/widgets/contact_list_widget.dart';

class PeopleTodayScreen extends StatefulWidget {
  static const String id = 'glance_today_screen';

  @override
  _PeopleTodayScreenState createState() => _PeopleTodayScreenState();
}

class _PeopleTodayScreenState extends State<PeopleTodayScreen> {
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
