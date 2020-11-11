import 'package:flutter/material.dart';

class PageviewNavigationButton extends StatelessWidget {
  final Function onPressed;
  final String text;

  const PageviewNavigationButton({Key key, this.text, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FlatButton(
          child: Text(
            text,
          ),
          onPressed: onPressed,
        ),
        Divider(
          color: Colors.red,
          height: 3.0,
        )
      ],
    );
  }
}
