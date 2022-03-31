import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mimic/modules/challenges/widgets/transparent_app_bar.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/presentation/resourses/values_manager.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/cached_network_image.dart';
import 'package:mimic/widgets/cached_network_image_circle.dart';
import 'package:mimic/widgets/default_text_field.dart';
import 'package:mimic/widgets/defulat_button.dart';
import 'package:mimic/widgets/mimic_icons.dart';
import 'package:mimic/widgets/rounded_image.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({Key? key}) : super(key: key);

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    emailController.text = ValuesManager.email;
    return Scaffold(
      appBar: const TransparentAppBar(title: 'Account settings'),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Opacity(
            opacity: 0.2,
            child: SvgPicture.asset('assets/images/logos/logo_vertical.svg',
                width: double.infinity, height: 245.h),
          ),
          SingleChildScrollView(
              child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const _ProfileImage(),
                SizedBox(height: 10.h),
                Text(
                  ValuesManager.username,
                  style: getBoldStyle(),
                ),
                SizedBox(height: 5.h),
                Text(
                  'San Francisco, CA',
                  style: getRegularStyle(color: ColorManager.commentsColor),
                ),
                SizedBox(height: 40.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.h),
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
        ],
      ),
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
      height: 80.w,
      width: 80.w,
      child: Stack(
        children: [
          cachedNetworkImageProvider(ValuesManager.imageUrl, 80.r),
          //cachedNetworkImage(imageUrl: imageUrl, height: height, width: width)
          // RoundedImage(
          //     imagePath: 'assets/images/static/avatar.png', size: 85.w),
          Align(
            alignment: Alignment.bottomRight,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.r)),
              elevation: 1,
              child: Padding(
                padding: EdgeInsets.all(4.r),
                child: SvgPicture.asset(
                    'assets/images/edit_profile_icons/edit.svg'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PrefixIconImage extends StatelessWidget {
  const _PrefixIconImage({Key? key, required this.svgImagePath, this.size = 15})
      : super(key: key);
  final String svgImagePath;
  final double size;
  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: SizedBox(
        width: size.w,
        height: size.w,
        child: FittedBox(
          child: SvgPicture.asset(
            svgImagePath,
          ),
        ),
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
            hintText: ValuesManager.email,
            controller: TextEditingController(),
            marginAfterEnd: spaceAfterEnd,
            prefix: const _PrefixIconImage(
                svgImagePath: 'assets/images/edit_profile_icons/email.svg'),
            labelText: 'Email',
            iconColor: Theme.of(context).primaryColor),
        DefaultTextField(
            hintText: ValuesManager.username,
            labelText: 'User Name',
            controller: TextEditingController(),
            marginAfterEnd: spaceAfterEnd,
            prefix: const _PrefixIconImage(
                svgImagePath: 'assets/images/edit_profile_icons/user_name.svg'),
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
              prefix: const _PrefixIconImage(
                svgImagePath: 'assets/images/edit_profile_icons/password.svg',
                size: 25,
              ),
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
            prefix: const _PrefixIconImage(
                svgImagePath: 'assets/images/edit_profile_icons/birthday.svg'),
            enabled: false,
            suffix: _icon(),
            iconColor: Theme.of(context).primaryColor),
        DefaultTextField(
            hintText: '',
            labelText: 'Country',
            controller: TextEditingController(),
            marginAfterEnd: spaceAfterEnd,
            prefix: const _PrefixIconImage(
                svgImagePath: 'assets/images/edit_profile_icons/country.svg'),
            enabled: false,
            suffix: _icon(),
            iconColor: Theme.of(context).primaryColor),
        DefaultTextField(
            hintText: '',
            labelText: 'City',
            controller: TextEditingController(),
            marginAfterEnd: spaceAfterEnd,
            prefix: const _PrefixIconImage(
                svgImagePath: 'assets/images/edit_profile_icons/city.svg'),
            enabled: false,
            suffix: _icon(),
            iconColor: Theme.of(context).primaryColor),
      ],
    );
  }
}
