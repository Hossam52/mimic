import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/mimic_icons.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          navigateTo(context, Routes.notifications, arguments: context);
        },
        icon: Icon(
          MimicIcons.notifications,
          size: 19.sp,
          color: Theme.of(context).primaryColor,
        ));
  }
}
