import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/modules/challenges/widgets/transparent_app_bar.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/default_text_field.dart';
import 'package:mimic/widgets/defulat_button.dart';
import 'package:mimic/widgets/mimic_icons.dart';
import 'package:mimic/widgets/rounded_image.dart';

class ProfileSettings extends StatelessWidget {
  const ProfileSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TransparentAppBar(title: 'Account settings'),
      body: SingleChildScrollView(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const _ProfileImage(),
            SizedBox(height: 10.h),
            Text(
              'Maria Snow',
              style: getBoldStyle(),
            ),
            SizedBox(height: 5.h),
            Text(
              'San Francisco, CA',
              style: getRegularStyle(color: ColorManager.commentsColor),
            ),
            SizedBox(height: 40.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.h),
              child: Column(
                children: [
                  const _AccountSettings(),
                  SizedBox(height: 30.h),
                  const _PersonalData(),
                  SizedBox(height: 30.h),
                  DefaultButton(
                    text: 'Save Changes',
                    onPressed: () {},
                    width: double.infinity,
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: ColorManager.white,
                    hasBorder: false,
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    radius: 24.r,
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}

Widget _icon() {
  return Icon(
    Icons.keyboard_arrow_right,
    size: 25.r,
    color: ColorManager.black,
  );
}

class _ProfileImage extends StatelessWidget {
  const _ProfileImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75.r,
      width: 75.r,
      child: Stack(
        children: [
          RoundedImage(
              imagePath: 'assets/images/static/avatar.png', size: 70.r),
          Align(
            alignment: Alignment.bottomRight,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r)),
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(Icons.edit,
                    color: Theme.of(context).primaryColor, size: 14.r),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AccountSettings extends StatelessWidget {
  const _AccountSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double spaceAfterEnd = 15;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Account', style: getBoldStyle(fontSize: FontSize.s14)),
        const SizedBox(height: spaceAfterEnd),
        DefaultTextField(
            hintText: 'hossam.hassan.fcis@gmail.com',
            controller: TextEditingController(),
            marginAfterEnd: spaceAfterEnd,
            prefixIcon: MimicIcons.email,
            labelText: 'Email',
            iconColor: Theme.of(context).primaryColor),
        DefaultTextField(
            hintText: 'User Name',
            labelText: 'User Name',
            controller: TextEditingController(),
            marginAfterEnd: spaceAfterEnd,
            prefixIcon: MimicIcons.accountFilled,
            iconColor: Theme.of(context).primaryColor),
        GestureDetector(
          onTap: () {
            navigateTo(context, Routes.profileChangePassword);
          },
          child: DefaultTextField(
              hintText: '',
              labelText: 'Change Password',
              controller: TextEditingController(),
              marginAfterEnd: spaceAfterEnd,
              prefixIcon: MimicIcons.password,
              enabled: false,
              suffix: _icon(),
              iconColor: Theme.of(context).primaryColor),
        ),
      ],
    );
  }
}

class _PersonalData extends StatelessWidget {
  const _PersonalData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double spaceAfterEnd = 15;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Personal Data', style: getSemiBoldStyle()),
        const SizedBox(height: spaceAfterEnd),
        DefaultTextField(
            hintText: '',
            labelText: 'Birth date',
            controller: TextEditingController(),
            marginAfterEnd: spaceAfterEnd,
            prefixIcon: MimicIcons.birthday,
            enabled: false,
            suffix: _icon(),
            iconColor: Theme.of(context).primaryColor),
        DefaultTextField(
            hintText: '',
            labelText: 'Country',
            controller: TextEditingController(),
            marginAfterEnd: spaceAfterEnd,
            prefixIcon: MimicIcons.country,
            enabled: false,
            suffix: _icon(),
            iconColor: Theme.of(context).primaryColor),
        DefaultTextField(
            hintText: '',
            labelText: 'City',
            controller: TextEditingController(),
            marginAfterEnd: spaceAfterEnd,
            prefixIcon: MimicIcons.city,
            enabled: false,
            suffix: _icon(),
            iconColor: Theme.of(context).primaryColor),
      ],
    );
  }
}
