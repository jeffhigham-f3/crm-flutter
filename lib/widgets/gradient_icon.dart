import 'package:flutter/material.dart';

class GradientIcon extends StatelessWidget {
  final Widget child;

  const GradientIcon({Key key, this.child}) : super(key: key);

  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Theme.of(context).primaryColor, Theme.of(context).accentColor],
        // tileMode: TileMode.mirror,
      ).createShader(bounds),
      child: child,
    );
  }
}
