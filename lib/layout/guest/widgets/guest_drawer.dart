import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mimic/layout/guest/widgets/guest_custom_drawer_header.dart';
import 'package:mimic/layout/widgets/drawer_icon_image.dart';
import 'package:mimic/layout/widgets/drawer_item.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/mimic_icons.dart';
import 'package:mimic/widgets/mimic_logo.dart';
import 'package:mimic/widgets/sized_icon.dart';

class GuestDrawer extends StatelessWidget {
  const GuestDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: screenWidth(context) * 0.6,
        child: Drawer(
          child: Column(
            children: [
              const GuestCustomDrawerHeader(),
              const SizedBox(height: 20),
              _drawerItem('Feed', 'assets/images/drawer_icons/guest/feed.svg'),
              _drawerItem('Discover peopler',
                  'assets/images/drawer_icons/guest/discover.svg'),
              _drawerItem('How To Challenge',
                  'assets/images/drawer_icons/guest/help.svg', onPressed: () {
                navigateTo(context, Routes.howToChallenge);
              }),
              _drawerItem('Support',
                  'assets/images/drawer_icons/guest/customer_service.svg',
                  onPressed: () {
                navigateTo(context, Routes.customerSupport);
              }),
              Divider(
                color: ColorManager.commentsColor,
                endIndent: 40.w,
              ),
              _drawerItem('Login/Register',
                  'assets/images/drawer_icons/guest/login.svg', onPressed: () {
                navigateTo(context, Routes.login);
              }, color: ColorManager.darkGrey),
              const Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 42.h),
                child: MimicLogoHorizontal(width: screenWidth(context) * 0.2),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _drawerItem(String title, String imagePath,
      {VoidCallback? onPressed, Color? color}) {
    return DrawerItem(
      onTap: onPressed,
      imagePath: imagePath,
      title: title,
      iconColor: color,
    );
  }
}
