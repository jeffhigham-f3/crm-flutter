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
        child: Container(
          color: Colors.black87,
          width: double.infinity,
          height: double.infinity,
          child: Image.asset(
            'assets/live.png',
            repeat: ImageRepeat.noRepeat,
          ),
        ),
        onTap: (() {
          Navigator.pop(context);
        }),
      ),
    );
  }
}
