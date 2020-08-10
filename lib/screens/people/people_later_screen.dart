import 'package:flutter/material.dart';

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
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Later',
          style: optionStyle,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'Everything you need to do later.',
            textAlign: TextAlign.center,
            softWrap: true,
          ),
        )
      ],
    );
  }
}
