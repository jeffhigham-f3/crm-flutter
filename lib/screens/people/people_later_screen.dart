import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/widgets/contact_list_widget.dart';

class PeopleLaterScreen extends StatefulWidget {
  static const String id = 'glance_later_screen';

  @override
  _PeopleLaterScreenState createState() => _PeopleLaterScreenState();
}

class _PeopleLaterScreenState extends State<PeopleLaterScreen> {
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
