import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/widgets/defulat_button.dart';

class PostForReviewDialog extends StatelessWidget {
  const PostForReviewDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 46.h, horizontal: 25.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'This video is posted for review will be posted soon',
              style: getSemiBoldStyle(fontSize: FontSize.s14),
            ),
            SvgPicture.asset('assets/images/upload_done.svg',
                width: 120.w, height: 120.h),
            SizedBox(height: 28.h),
            DefaultButton(
                text: 'View Other challenges',
                onPressed: () {
                  Navigator.pop(context);
                },
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: ColorManager.white,
                radius: 12.r),
          ],
        ),
      ),
    );
  }
}
