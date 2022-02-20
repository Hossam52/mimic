import 'package:flutter/material.dart';

class ShadowBox extends StatelessWidget {
  const ShadowBox({Key? key, required this.child, this.shadow = 20})
      : super(key: key);
  final Widget child;
  final double shadow;
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.zero,
      color: Colors.transparent,
      elevation: shadow,
      child: child,
    );
  }
}
