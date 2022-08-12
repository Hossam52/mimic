import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mimic/models/notifications/notification.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/widgets/cached_network_image_circle.dart';
import 'package:mimic/widgets/rounded_image.dart';

class PersonNotification extends StatelessWidget {
  const PersonNotification({Key? key, required this.notificationData})
      : super(key: key);
  final NotificationData notificationData;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      minVerticalPadding: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      contentPadding: EdgeInsets.all(8.r),
      leading: cachedNetworkImageProvider(
          notificationData.sender == null
              ? null
              : notificationData.sender!.image,
          60.r),
      tileColor: ColorManager.seenNotificationBackground,
      title: Row(
        children: [
          Expanded(
            child: Text(
              notificationData.title,
              style: getRegularStyle(),
            ),
          ),
          Text(notificationData.createdAt, style: getRegularStyle()),
        ],
      ),
      isThreeLine: true,
      subtitle: Text(
        notificationData.body,
        style: getRegularStyle(),
      ),
    );
  }
}
