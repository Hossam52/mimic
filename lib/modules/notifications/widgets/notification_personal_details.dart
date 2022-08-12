import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mimic/models/notifications/notification.dart';
import 'package:mimic/models/user_model/user_abstract_model.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/widgets/cached_network_image_circle.dart';
import 'package:mimic/widgets/rounded_image.dart';

class NotificationPersonDetails extends StatelessWidget {
  NotificationPersonDetails({
    Key? key,
    this.nameColor,
    this.descriptionColor,
    this.timeAgoColor,
    required this.notificationData,
  }) : super(key: key);
  final Color? nameColor;
  final Color? descriptionColor;
  final Color? timeAgoColor;
  final NotificationData notificationData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.r),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 50.w,
            child:
                cachedNetworkImageProvider(notificationData.sender!.image, 50.r),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  notificationData.sender!.name!,
                  style: getBoldStyle(
                    color: nameColor ?? ColorManager.white,
                  ),
                ),
                Text(
                  notificationData.title,
                  style: getRegularStyle(
                    fontSize: FontSize.s10,
                    color: descriptionColor ??
                        ColorManager.notificationPersonDetails,
                  ),
                ),
              ],
            ),
          ),
          Text(
            notificationData.createdAt,
            style: getRegularStyle(
                fontSize: FontSize.s10,
                color: timeAgoColor ?? ColorManager.white),
          )
        ],
      ),
    );
  }
}
