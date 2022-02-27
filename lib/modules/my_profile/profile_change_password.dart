import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mimic/modules/challenges/widgets/transparent_app_bar.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/widgets/default_text_field.dart';
import 'package:mimic/widgets/defulat_button.dart';
import 'package:mimic/widgets/mimic_icons.dart';

class ProfileChangePassword extends StatelessWidget {
  const ProfileChangePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double spaceAfterEnd = 10.h;
    return Scaffold(
      appBar: const TransparentAppBar(title: 'Change password'),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(44.0),
        child: Column(
          children: [
            DefaultTextField(
              isPassword: true,
              borderRadius: 5.r,
              hintText: 'Current Password',
              controller: TextEditingController(),
              marginAfterEnd: spaceAfterEnd,
              icon: Icons.visibility_outlined,
              iconColor: ColorManager.commentsColor,
            ),
            DefaultTextField(
              isPassword: true,
              borderRadius: 5.r,
              hintText: 'New Password',
              controller: TextEditingController(),
              icon: Icons.visibility_outlined,
              marginAfterEnd: spaceAfterEnd,
              iconColor: ColorManager.commentsColor,
            ),
            DefaultTextField(
              isPassword: true,
              borderRadius: 5.r,
              hintText: 'Confirm New Password',
              controller: TextEditingController(),
              marginAfterEnd: spaceAfterEnd,
              icon: Icons.visibility_outlined,
              iconColor: ColorManager.commentsColor,
            ),
            SizedBox(height: 30.h),
            Opacity(
              opacity: 0.7,
              child: SvgPicture.asset(
                'assets/images/logos/logo_vertical.svg',
                width: double.infinity,
                height: 220.h,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 30.h),
            SizedBox(
              width: double.infinity,
              child: DefaultButton(
                text: 'Save Changes',
                onPressed: () {},
                width: double.infinity,
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: ColorManager.white,
                hasBorder: false,
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                radius: 26.r,
              ),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      )),
    );
  }
}
