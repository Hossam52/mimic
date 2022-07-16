import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/models/user_model/user.dart';
import 'package:mimic/presentation/resourses/assets_manager.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/presentation/resourses/values.dart';
import 'package:mimic/widgets/cached_network_image_circle.dart';
import 'package:mimic/widgets/rounded_image.dart';

class PersonDetails extends StatelessWidget {
  const PersonDetails(
      {Key? key,
      this.imageRadius = 28,
      this.nameSize,
      this.timeAgoSize,
      required this.user,
      this.textColor})
      : super(key: key);
  final double imageRadius;
  final User user;
  final double? nameSize;
  final double? timeAgoSize;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppPadding.p6.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: AppSize.s28.r,
            height: AppSize.s28.r,
            child:cachedNetworkImageProvider(user.image, imageRadius.r),
            
          ),
          SizedBox(width: AppSize.s3.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                user.name,
                style: getRegularStyle(
                    color: textColor ?? ColorManager.white,
                    fontSize: nameSize ?? FontSize.s12),
              ),
              Text(
                '2 Min ago',
                style: getRegularStyle(
                    color: textColor != null
                        ? textColor!.withOpacity(0.76)
                        : ColorManager.timeAgo,
                    fontSize: timeAgoSize ?? FontSize.s10),
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
      {Key? key, this.imageRadius = 28, this.nameSize, this.textColor})
      : super(key: key);
  final double imageRadius;
  final double? nameSize;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppPadding.p8.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: AppSize.s28.w,
            child: RoundedImage(
              imagePath: ImageAssets.avater,
              size: imageRadius.r,
            ),
          ),
          SizedBox(width: AppSize.s3.w),
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
                      fontSize: nameSize ?? FontSize.s12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
