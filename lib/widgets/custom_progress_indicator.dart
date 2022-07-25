import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';

class CustomLoadingProgress extends StatelessWidget {
  final Color? color;
  final double progress;
  const CustomLoadingProgress({Key? key, this.color, required this.progress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 100.r,
        width: 100.r,
        child: CircularProgressIndicator(
          strokeWidth: 5.w,
          value: progress,
          color: color ?? ColorManager.primary,
        ),
      ),
    );
  }
}
