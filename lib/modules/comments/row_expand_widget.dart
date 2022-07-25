import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';

class RowExpandWidget extends StatelessWidget {
  const RowExpandWidget({Key? key, required this.iconData, required this.title})
      : super(key: key);
  final String title;
  final IconData iconData;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 10.w),
      child: Row(
        children: [
          Text(
            title,
            style: getMediumStyle(),
          ),
          const Spacer(),
          Icon(iconData)
        ],
      ),
    );
  }
}
