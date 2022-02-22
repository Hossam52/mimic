import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mimic/layout/guest/widgets/guest_custom_drawer_header.dart';
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
              _drawerItem('Feed', MimicIcons.feed),
              _drawerItem('Discover peopler', MimicIcons.discover),
              _drawerItem('How To Challenge', MimicIcons.help, onPressed: () {
                navigateTo(context, Routes.howToChallenge);
              }),
              _drawerItem('Support', MimicIcons.customerService, onPressed: () {
                navigateTo(context, Routes.customerSupport);
              }),
              const Divider(),
              _drawerItem('Login/Register', MimicIcons.login, onPressed: () {
                navigateTo(context, Routes.login);
              }, color: ColorManager.darkGrey),
              const Spacer(),
              MimicLogo(width: screenWidth(context) * 0.2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _drawerItem(String title, IconData icon,
      {VoidCallback? onPressed, Color? color}) {
    return ListTile(
      minLeadingWidth: 20.w,
      onTap: onPressed,
      leading: SizedIcon(
        icon,
        size: 18.r,
        color: color ?? ColorManager.iconDrawerColor,
      ),
      title: Text(
        title,
        style: getSemiBoldStyle(),
      ),
    );
  }
}
