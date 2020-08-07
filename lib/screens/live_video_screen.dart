import 'package:flutter/material.dart';

class LiveVideoScreen extends StatefulWidget {
  static const String id = 'live_video_screen';
  @override
  _LiveVideoScreenState createState() => _LiveVideoScreenState();
}

class _LiveVideoScreenState extends State<LiveVideoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Image.asset('assets/live.png'),
        onTap: (() {
          Navigator.pop(context);
        }),
      ),
    );
  }
}
