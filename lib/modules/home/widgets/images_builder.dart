import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/modules/home/widgets/black_opacity.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/rounded_image.dart';

class ImagesBuilder extends StatelessWidget {
  const ImagesBuilder({Key? key, required this.imagesCount}) : super(key: key);
  final int imagesCount;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final double imageRadius = 60.r;
      final imagesToRender = constraints.maxWidth / ((imageRadius));
      int i = 0;
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          for (i = 0; i < imagesToRender.toInt() - 1 && i < imagesCount; i++)
            Padding(
              padding: EdgeInsets.only(right: 5.0.w),
              child: RoundedImage(
                imagePath: 'assets/images/static/interest4.png',
                size: imageRadius.r,
              ),
            ),
          if (i < imagesCount) _lastImage(imageRadius, i),
        ],
      );
    });
  }

  Widget _lastImage(double imageRadius, int i) {
    return Stack(
      clipBehavior: Clip.hardEdge,
      alignment: Alignment.center,
      children: [
        RoundedImage(
          imagePath: 'assets/images/static/interest3.png',
          size: imageRadius,
        ),
        // BlackOpacity(),
        CircleAvatar(
            backgroundColor: ColorManager.black.withOpacity(0.40),
            radius: imageRadius / 2),
        Center(
          child: Text(
            ' + ${imagesCount - i}',
            style: getRegularStyle(color: ColorManager.white),
          ),
        ),
      ],
    );
  }
}
