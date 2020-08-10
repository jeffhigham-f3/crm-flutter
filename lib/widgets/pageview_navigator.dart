import 'package:flutter/material.dart';

class PageviewNavigator extends StatelessWidget {
  final List<Widget> children;

  const PageviewNavigator({Key key, this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: this.children,
      ),
    );
  }
}
