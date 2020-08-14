import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  final Widget child;

  const GradientContainer({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment(1.0, 1.5),
          colors: [const Color(0xFF6B3EFF), const Color(0xFF5058FF), const Color(0xFF00A2FF)],
          tileMode: TileMode.clamp,
        ),
      ),
      child: this.child,
    );
  }
}
