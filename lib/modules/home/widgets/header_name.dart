import 'package:flutter/material.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';

class HeaderName extends StatelessWidget {
  const HeaderName(
    this.title, {
    Key? key,
    this.opacity = 1,
  }) : super(key: key);
  final String title;
  final double opacity;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: getBoldStyle(fontSize: FontSize.s18).copyWith(
          color:
              getBoldStyle(fontSize: FontSize.s18).color!.withOpacity(opacity)),
    );
  }
}
