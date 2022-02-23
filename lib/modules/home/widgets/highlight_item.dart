import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/modules/home/widgets/black_opacity.dart';
import 'package:mimic/widgets/person_details.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';

class HighlightItem extends StatelessWidget {
  const HighlightItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: ColorManager.black.withOpacity(0.5)),
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        clipBehavior: Clip.hardEdge,
        children: [
          _image(),
          const BlackOpacity(),
          const PersonDetails(
            nameSize: FontSize.s10,
            timeAgoSize: FontSize.s8,
          ),
        ],
      ),
    );
  }

  Widget _image() {
    return Image.asset(
      _paths[Random.secure().nextInt(_paths.length)],
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.fill,
    );
  }
}

final _paths = [
  'assets/images/static/highlights/highlight1.png',
  'assets/images/static/highlights/highlight2.png',
  'assets/images/static/highlights/highlight3.png',
];
