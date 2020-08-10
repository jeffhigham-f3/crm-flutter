import 'package:flutter/material.dart';

class GlanceScreenButton extends StatefulWidget {
  final Function onPressed;
  final String text;

  const GlanceScreenButton({Key key, this.text, this.onPressed}) : super(key: key);

  @override
  _GlanceScreenButtonState createState() => _GlanceScreenButtonState();
}

class _GlanceScreenButtonState extends State<GlanceScreenButton> {
  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      child: Text(
        widget.text,
      ),
      onPressed: widget.onPressed,
    );
  }
}
