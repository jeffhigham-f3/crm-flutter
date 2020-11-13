import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/service/import.dart';

class GradientContainer extends StatelessWidget {
  final Widget child;

  const GradientContainer({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeService = context.watch<ThemeService>();

    return Container(
      decoration: themeService.loginGradientDecoration,
      child: this.child,
    );
  }
}
