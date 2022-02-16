import 'package:flutter/material.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';

class VideStatisticsItem extends StatelessWidget {
  const VideStatisticsItem(this.icon, this.count,
      {Key? key, this.filledColor, this.iconSize})
      : super(key: key);
  final IconData icon;
  final Color? filledColor;
  final String count;
  final double? iconSize;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: iconSize,
          color: filledColor ?? ColorManager.commentsColor,
        ),
        Text(
          count,
          style: getSemiBoldStyle(),
        ),
      ],
    );
  }
}
