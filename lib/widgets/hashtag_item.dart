import 'package:flutter/material.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';

class HashtagItem extends StatelessWidget {
  const HashtagItem({Key? key, required this.title, this.color})
      : super(key: key);
  final String title;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: getBoldStyle(
          color: color ?? ColorManager.hashtagColor, fontSize: FontSize.s11),
    );
  }
}
