import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/modules/home/widgets/black_opacity.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/presentation/resourses/values.dart';
import 'package:mimic/presentation/resourses/values_manager.dart';
import 'package:mimic/widgets/cached_network_image_circle.dart';
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
        alignment: AlignmentDirectional.topStart,
        fit: StackFit.expand,
        clipBehavior: Clip.hardEdge,
        children: [
          _image(),
          const BlackOpacity(),
          // Todo::
          const PersonDetails()
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

class PersonDetails extends StatelessWidget {
  const PersonDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppPadding.p6.w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: AppSize.s28.r,
            height: AppSize.s28.r,
            child: cachedNetworkImageProvider(ValuesManager.imageUrl, 25.r),
          ),
          SizedBox(width: AppSize.s3.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                ValuesManager.username,
                style: getRegularStyle(
                  color: ColorManager.white,
                  fontSize: FontSize.s12,
                ),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  '2 Min ago',
                  style: getRegularStyle(
                      color: ColorManager.timeAgo, fontSize: FontSize.s10),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

final _paths = [
  'assets/images/static/highlights/highlight1.png',
  'assets/images/static/highlights/highlight2.png',
  'assets/images/static/highlights/highlight3.png',
];
