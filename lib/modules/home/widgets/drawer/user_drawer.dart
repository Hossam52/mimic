import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:mimic/modules/home/widgets/drawer/custom_drawer_header.dart';
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
      child: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CustomDrawerHeader(),
              const SizedBox(height: 20),
              for (int i = 0; i < _DrawerItemState.items.length; i++)
                _drawerItem(_DrawerItemState.items[i], i),
            ],
          ),
        ),
      ),
    );
  }

  Widget _drawerItem(_DrawerItemState item, int index) {
    if (item.subSections == null) {
      return ListTile(
        onTap: item.onPressed,
        leading: Icon(
          item.icon,
          size: 20,
        ),
        title: Text(
          item.title,
          style: getSemiBoldStyle(fontSize: FontSize.s16),
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
            onTap: () {
              setState(() {
                log('Before ${item.isOpen}');
                _DrawerItemState.changeIsOpen(index);
                log('After ${_DrawerItemState.items[index].isOpen}');
              });
              item.onPressed!();
            },
            leading: Icon(
              item.icon,
              size: 20,
            ),
            title: Text(
              item.title,
              style: getSemiBoldStyle(fontSize: FontSize.s16),
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
      padding: const EdgeInsets.all(8.0),
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
                size: 10,
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
        title: 'Discover',
        subSections: [
          _DrawerItemSubSection(icon: MimicIcons.socceer, title: 'Soccer'),
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
      icon: MimicIcons.discover,
      onPressed: () {},
      title: 'Our parteners',
    ),
    _DrawerItemState(
        icon: MimicIcons.challenges,
        onPressed: () {},
        title: 'Language',
        subSections: [
          _DrawerItemSubSection(icon: MimicIcons.rank, title: 'Arabic'),
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
