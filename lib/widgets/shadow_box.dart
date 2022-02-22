import 'package:flutter/material.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';

class ShadowBox extends StatelessWidget {
  const ShadowBox(
      {Key? key, required this.child, this.shadow = 20, this.radius = 0})
      : super(key: key);
  final Widget child;
  final double shadow;
  final double radius;
  @override
  Widget build(BuildContext context) {
    // return Container(
    //   decoration: BoxDecoration(boxShadow: [
    //     BoxShadow(
    //         color: ColorManager.visibilityColor,
    //         blurRadius: 8,
    //         blurStyle: BlurStyle.outer,
    //         spreadRadius: 2)
    //   ]),
    //   child: child,
    // );
    return Material(
      borderRadius: BorderRadius.circular(radius),
      shadowColor: ColorManager.visibilityColor.withOpacity(0.15),
      color: Colors.transparent,
      elevation: shadow,
      child: child,
    );
  }
}
