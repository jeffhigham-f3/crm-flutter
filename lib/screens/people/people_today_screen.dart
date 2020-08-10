import 'package:flutter/material.dart';

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
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Today',
          style: optionStyle,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'Everything you need to do today.',
            textAlign: TextAlign.center,
            softWrap: true,
          ),
        )
      ],
    );
  }
}
