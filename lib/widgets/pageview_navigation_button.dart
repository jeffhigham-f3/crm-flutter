import 'package:flutter/material.dart';

class PageviewNavigationButton extends StatefulWidget {
  final Function onPressed;
  final String text;

  const PageviewNavigationButton({Key key, this.text, this.onPressed}) : super(key: key);

  @override
  _PageviewNavigationButtonState createState() => _PageviewNavigationButtonState();
}

class _PageviewNavigationButtonState extends State<PageviewNavigationButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FlatButton(
          child: Text(
            widget.text,
          ),
          onPressed: widget.onPressed,
        ),
        Divider(
          color: Colors.red,
          height: 3.0,
        )
      ],
    );
  }
}
