import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/config/palette.dart';

class GradientContainer extends StatelessWidget {
  final Widget child;

  const GradientContainer({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Palette.loginGradientDecoration,
      child: this.child,
    );
  }
}
