import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';

class DrawerIconImage extends StatelessWidget {
  const DrawerIconImage(
      {Key? key, required this.imagePath, this.color, this.size})
      : super(key: key);
  final String imagePath;
  final Color? color;
  final double? size;
  @override
  Widget build(BuildContext context) {
    final iconSize = size ?? 18;
    return SvgPicture.asset(
      imagePath,
      color: color ?? ColorManager.iconDrawerColor,
      width: iconSize.w,
      height: iconSize.w,
      fit: BoxFit.fill,
    );
  }
}
