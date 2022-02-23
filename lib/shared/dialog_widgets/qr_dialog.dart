import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/widgets/defulat_button.dart';
import 'package:mimic/widgets/rounded_image.dart';

class QrDialogShareSave extends StatelessWidget {
  const QrDialogShareSave({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w)
            .copyWith(bottom: 40.h, top: 21.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const _ProfileInfo(),
            SizedBox(height: 50.h),
            SvgPicture.asset('assets/images/scan_qr.svg',
                width: 170.w, height: 170.h),
            SizedBox(height: 38.h),
            Row(
              children: [
                Expanded(
                  child: DefaultButton(
                      text: 'Share',
                      onPressed: () {},
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: ColorManager.white,
                      radius: 12.r),
                ),
                SizedBox(width: 11.w),
                Expanded(
                  child: DefaultButton(
                      text: 'Save',
                      onPressed: () {},
                      backgroundColor: ColorManager.white,
                      foregroundColor: ColorManager.black,
                      hasBorder: false,
                      radius: 12.r),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _ProfileInfo extends StatelessWidget {
  const _ProfileInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RoundedImage(
          imagePath: 'assets/images/static/avatar.png',
          size: 65.r,
        ),
        SizedBox(width: 8.w),
        Column(
          children: [
            Text(
              'Maria Snow',
              style: getRegularStyle(
                      fontSize: FontSize.s14, color: ColorManager.profileName)
                  .copyWith(
                      fontFamily: FontConstants.gibsonFamily,
                      fontWeight: FontWeight.w500),
            ),
            Text(
              'San Francisco, CA',
              style: getRegularStyle(
                      fontSize: FontSize.s9,
                      color: ColorManager.profileLocation)
                  .copyWith(fontFamily: FontConstants.gibsonFamily),
            ),
          ],
        )
      ],
    );
  }
}

class ShareSaveToGalery extends StatelessWidget {
  const ShareSaveToGalery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 50.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset('assets/images/scan_qr.svg',
                width: 170.w, height: 170.h),
            SizedBox(height: 50.h),
            Row(
              children: [
                Expanded(
                  child: DefaultButton(
                      text: 'Share',
                      onPressed: () {},
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: ColorManager.white,
                      radius: 12.r),
                ),
                SizedBox(width: 11.w),
                Expanded(
                  child: DefaultButton(
                      text: 'Save to gallery',
                      onPressed: () {},
                      backgroundColor: ColorManager.white,
                      foregroundColor: ColorManager.black,
                      hasBorder: false,
                      radius: 12.r),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
