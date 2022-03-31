import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/layout/widgets/rounded_drawer_header.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/presentation/resourses/values_manager.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/cached_network_image.dart';
import 'package:mimic/widgets/cached_network_image_circle.dart';
import 'package:mimic/widgets/rounded_image.dart';

class UserCustomDrawerHeader extends StatelessWidget {
  const UserCustomDrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedDrawerHeader(
      child: Row(children: [
        //cachedNetworkImageProvider(ValuesManager.imageUrl, 45.r),
        ValuesManager.imageUrl.isEmpty?
        RoundedImage(imagePath: 'assets/images/static/avatar.png', size: 45.r):
        cachedNetworkImage(imageUrl: ValuesManager.imageUrl, height: 45.r, width: 45.r),
        SizedBox(width: 10.w),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Text(ValuesManager.username,
                style: getBoldStyle(
                    fontSize: FontSize.s14, color: ColorManager.white)),
            Text(ValuesManager.email,
                style: getRegularStyle(color: ColorManager.white)),
          ],
        )
      ]),
    );
  }
}
