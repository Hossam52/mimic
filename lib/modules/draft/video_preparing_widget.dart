import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/widgets/custom_progress_indicator.dart';

class VideoPreparingWidget extends StatelessWidget {
  VideoPreparingWidget(
      {Key? key, required this.progress, this.color, this.uploadTime = false})
      : super(key: key);
  final double progress;
  Color? color;
  bool uploadTime;

  @override
  Widget build(BuildContext context) {
    String pro = (progress * 100).toStringAsFixed(2);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          uploadTime ? 'Video uploading now' : 'Video Preparing to upload',
          style: getMediumStyle(fontSize: FontSize.s18),
        ),
        SizedBox(
          height: 15.h,
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            CustomLoadingProgress(progress: progress, color: color),
            Text('$pro %')
          ],
        ),
      ],
    );
  }
}
