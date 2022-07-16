import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mimic/layout/user/cubit/user_cubit.dart';
import 'package:mimic/presentation/resourses/assets_manager.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/extentions/translate_word.dart';
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
              AppStrings.thisVideoIsPostedForReviewWillBePostedSoon
                  .translateString(context),
              style: getSemiBoldStyle(fontSize: FontSize.s14),
            ),
            SvgPicture.asset(ImageAssets.uploadDone,
                width: 120.w, height: 120.h),
            SizedBox(height: 28.h),
            DefaultButton(
                text: AppStrings.viewOtherChallanges,
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  UserCubit.instance(context).changeScreenIndex(context, 3);
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
