import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/widgets/rounded_image.dart';

class PersonDetails extends StatelessWidget {
  const PersonDetails(
      {Key? key,
      this.imageRadius = 28,
      this.nameSize = FontSize.s12,
      this.timeAgoSize = FontSize.s10,
      this.textColor})
      : super(key: key);
  final double imageRadius;
  final double nameSize;
  final double timeAgoSize;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(6.0.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 28.r,
            height: 28.r,
            child: RoundedImage(
              imagePath: 'assets/images/static/avatar.png',
              size: imageRadius.r,
            ),
          ),
          SizedBox(width: 3.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Ola ahmed',
                style: getRegularStyle(
                    color: textColor ?? ColorManager.white, fontSize: nameSize),
              ),
              Text(
                '2 Min ago',
                style: getRegularStyle(
                    color: textColor != null
                        ? textColor!.withOpacity(0.76)
                        : ColorManager.timeAgo,
                    fontSize: timeAgoSize),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class PersonNameAndImage extends StatelessWidget {
  const PersonNameAndImage(
      {Key? key,
      this.imageRadius = 28,
      this.nameSize = FontSize.s12,
      this.textColor})
      : super(key: key);
  final double imageRadius;
  final double nameSize;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 28,
            child: RoundedImage(
              imagePath: 'assets/images/static/avatar.png',
              size: imageRadius.r,
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Ola ahmed',
                  style: getRegularStyle(
                      color: textColor ?? ColorManager.white,
                      fontSize: nameSize),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
