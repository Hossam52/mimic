import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/widgets/video_item.dart';

class MyVideos extends StatelessWidget {
  const MyVideos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (_, index) {
          return SizedBox(height: 10.h);
        },
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (_, index) {
          return VideoOverview(
            borderRadius: 13.r,
            defaultIconColor: ColorManager.commentsColor,
          );
        });
  }
}
