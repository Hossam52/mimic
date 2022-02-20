import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/widgets/mimic_icons.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {},
        icon: Icon(
          MimicIcons.notifications,
          size: 20.r,
          color: Theme.of(context).primaryColor,
        ));
  }
}
