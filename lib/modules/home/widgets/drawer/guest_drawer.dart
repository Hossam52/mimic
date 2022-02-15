import 'package:flutter/material.dart';
import 'package:mimic/modules/home/widgets/drawer/custom_drawer_header.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/mimic_icons.dart';
import 'package:mimic/widgets/mimic_logo.dart';

class GuestDrawer extends StatelessWidget {
  const GuestDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            const CustomDrawerHeader(),
            const SizedBox(height: 20),
            _drawerItem('Feed', MimicIcons.feed),
            _drawerItem('Discove peopler', MimicIcons.discover),
            _drawerItem('How To Challenge', MimicIcons.help, onPressed: () {
              navigateTo(context, Routes.howToChallenge);
            }),
            _drawerItem('Support', MimicIcons.customerService, onPressed: () {
              navigateTo(context, Routes.customerSupport);
            }),
            const Divider(),
            _drawerItem('Login/Register', MimicIcons.login),
            const Spacer(),
            MimicLogo(width: screenWidth(context) * 0.2),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(String title, IconData icon, {VoidCallback? onPressed}) {
    return ListTile(
      onTap: onPressed,
      leading: Icon(
        icon,
        size: 20,
      ),
      title: Text(
        title,
        style: getSemiBoldStyle(fontSize: FontSize.s16),
      ),
    );
  }
}
