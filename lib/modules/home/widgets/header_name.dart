import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';

class HeaderName extends StatelessWidget {
  const HeaderName(
    this.title, {
    Key? key,
    this.opacity = 1,
    this.selected = false,
    this.onTap,
    this.displaySelectedIndicator = true,
    this.fontSize,
  }) : super(key: key);
  final String title;
  final double opacity;
  final bool selected;
  final VoidCallback? onTap;
  final bool displaySelectedIndicator;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            title,
            style: getBoldStyle(fontSize: fontSize ?? FontSize.s18).copyWith(
              color: selected
                  ? ColorManager.black
                  : ColorManager.black.withOpacity(0.49),
            ),
          ),
          if (selected && displaySelectedIndicator)
            CircleAvatar(backgroundColor: ColorManager.black, radius: 3.r),
        ],
      ),
    );
  }
}
