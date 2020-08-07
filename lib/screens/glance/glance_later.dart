import 'package:flutter/material.dart';

class GlanceLater extends StatefulWidget {
  static const String id = 'glance_later_screen';

  @override
  _GlanceLaterState createState() => _GlanceLaterState();
}

class _GlanceLaterState extends State<GlanceLater> {
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
