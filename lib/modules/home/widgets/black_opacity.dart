import 'package:flutter/material.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';

class BlackOpacity extends StatelessWidget {
  const BlackOpacity({Key? key, this.opacity = 0.5}) : super(key: key);
  final double opacity;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorManager.black.withOpacity(opacity)),
    );
  }
}
