import 'package:flutter/material.dart';

class GlanceTomorrow extends StatefulWidget {
  static const String id = 'glance_tomorrow_screen';

  @override
  _GlanceTomorrowState createState() => _GlanceTomorrowState();
}

class _GlanceTomorrowState extends State<GlanceTomorrow> {
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Tomorrow',
          style: optionStyle,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'Everything you need to do tomorrow.',
            textAlign: TextAlign.center,
            softWrap: true,
          ),
        )
      ],
    );
  }
}
