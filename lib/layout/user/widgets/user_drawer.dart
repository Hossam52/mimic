import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mimic/layout/guest/widgets/guest_custom_drawer_header.dart';
import 'package:mimic/layout/user/widgets/user_custom_drawer_header.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/mimic_icons.dart';

class UserDrawer extends StatefulWidget {
  const UserDrawer({Key? key}) : super(key: key);

  @override
  State<UserDrawer> createState() => _UserDrawerState();
}

class _UserDrawerState extends State<UserDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: screenWidth(context) * 0.62,
        child: Drawer(
          child: Column(
            children: [
              const UserCustomDrawerHeader(),
              const SizedBox(height: 20),
              Expanded(
                flex: 6,
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    for (int i = 0; i < _DrawerItemState.items.length; i++)
                      _drawerItem(_DrawerItemState.items[i], i),
                  ],
                )),
              ),
              Divider(
                color: ColorManager.darkGrey,
                thickness: 1,
                endIndent: 80.w,
              ),
              Expanded(
                child: _drawerItem(
                    _DrawerItemState(
                        icon: MimicIcons.logout,
                        title: 'Logout',
                        onPressed: () {}),
                    0,
                    color: ColorManager.darkGrey),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _drawerItem(_DrawerItemState item, int index, {Color? color}) {
    if (item.subSections == null) {
      return ListTile(
        minLeadingWidth: 0,
        onTap: item.onPressed,
        leading: Icon(
          item.icon,
          size: 18,
          color: color ?? ColorManager.iconDrawerColor,
        ),
        title: Text(
          item.title,
          style: getSemiBoldStyle(fontSize: FontSize.s12),
        ),
      );
    }

    return ExpansionPanelList(
      elevation: 0,
      expandedHeaderPadding: const EdgeInsets.all(0),
      children: [
        ExpansionPanel(
          backgroundColor: Colors.transparent,
          headerBuilder: (_, val) => ListTile(
            minLeadingWidth: 0,
            onTap: () {
              setState(() {
                _DrawerItemState.changeIsOpen(index);
              });
              item.onPressed!();
            },
            leading: Icon(
              item.icon,
              size: 18,
              color: ColorManager.iconDrawerColor,
            ),
            title: Text(
              item.title,
              style: getSemiBoldStyle(fontSize: FontSize.s12),
            ),
          ),
          canTapOnHeader: item.subSections != null,
          isExpanded: item.isOpen,
          body: Column(
            children: item.subSections!
                .map((e) => _DrawerSection(icon: e.icon, title: e.title))
                .toList(),
          ),
        )
      ],
    );
  }
}

class _DrawerSection extends StatelessWidget {
  const _DrawerSection(
      {Key? key, required this.icon, required this.title, this.onPressed})
      : super(key: key);
  final IconData icon;
  final String title;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          width: screenWidth(context) * 0.4,
          color: ColorManager.drawerFillColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              Icon(
                icon,
                size: 13,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 10),
              Text(title, style: getRegularStyle()),
            ]),
          ),
        ),
      ),
    );
  }
}

class _DrawerItemState {
  IconData icon;
  String title;
  List<_DrawerItemSubSection>? subSections;
  bool isOpen;
  VoidCallback? onPressed;
  _DrawerItemState(
      {required this.icon,
      required this.title,
      this.onPressed,
      this.isOpen = false,
      this.subSections});
  static List<_DrawerItemState> items = [
    _DrawerItemState(
        icon: MimicIcons.accountFilled,
        title: 'Profile',
        onPressed: () {},
        subSections: [
          _DrawerItemSubSection(
              icon: MimicIcons.editProfile, title: 'Edit My profile'),
          _DrawerItemSubSection(
              icon: MimicIcons.myRequests, title: 'My requests'),
          _DrawerItemSubSection(icon: MimicIcons.rank, title: 'My rank'),
          _DrawerItemSubSection(
              icon: MimicIcons.myChallenges, title: 'My challenges'),
          _DrawerItemSubSection(icon: MimicIcons.video, title: 'My videos'),
          _DrawerItemSubSection(
              icon: MimicIcons.notifications, title: 'My Notifications'),
        ]),
    _DrawerItemState(
        icon: MimicIcons.discover,
        onPressed: () {},
        title: 'Discover challenges',
        subSections: [
          _DrawerItemSubSection(icon: MimicIcons.soccer, title: 'Soccer'),
          _DrawerItemSubSection(
              icon: MimicIcons.basketball, title: 'Basketballs'),
        ]),
    _DrawerItemState(
      icon: MimicIcons.help,
      onPressed: () {},
      title: 'How to challenge',
    ),
    _DrawerItemState(
      icon: MimicIcons.customerService,
      onPressed: () {},
      title: 'Support',
    ),
    _DrawerItemState(
      icon: MimicIcons.contribution,
      onPressed: () {},
      title: 'Our parteners',
    ),
    _DrawerItemState(
        icon: Icons.language,
        onPressed: () {},
        title: 'Language',
        subSections: [
          _DrawerItemSubSection(icon: Icons.done, title: 'Arabic'),
          _DrawerItemSubSection(
              icon: MimicIcons.myChallenges, title: 'English'),
        ])
  ];
  static void changeIsOpen(int index) {
    items[index].isOpen = !items[index].isOpen;
  }
}

class _DrawerItemSubSection {
  String title;
  IconData icon;
  VoidCallback? onTap;
  _DrawerItemSubSection({
    required this.title,
    required this.icon,
    this.onTap,
  });
}
