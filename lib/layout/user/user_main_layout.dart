import 'package:flutter/material.dart';
import 'package:mimic/layout/guest/widgets/guest_drawer.dart';
import 'package:mimic/layout/search/search_layout.dart';
import 'package:mimic/layout/user/widgets/user_drawer.dart';
import 'package:mimic/modules/challenges/challenge_details/challenge_details.dart';
import 'package:mimic/modules/home/home_screen.dart';
import 'package:mimic/modules/home/user/user_home_screen.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/bottom_navigation.dart';
import 'package:mimic/widgets/mimic_icons.dart';
import 'package:mimic/widgets/mimic_logo.dart';

class UserMainLayout extends StatefulWidget {
  const UserMainLayout({Key? key}) : super(key: key);

  @override
  State<UserMainLayout> createState() => _UserMainLayoutState();
}

class _UserMainLayoutState extends State<UserMainLayout> {
  int selectedIndex = 0;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _screens = [
    UserHomeScreen(),
    const SearchLayout(),
    Container(),
    UserHomeScreen(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: MimicLogo(width: screenWidth(context) * 0.25),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
          icon: Icon(
            MimicIcons.menu,
            color: Theme.of(context).primaryColor,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                MimicIcons.notifications,
                color: Theme.of(context).primaryColor,
              ))
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        selectedItemColor: ColorManager.selectedBottomColor,
        unselectedItemColor: ColorManager.darkGrey,
        selectedColorOpacity: 0.3,
        items: [
          _bottomNavBarItem(MimicIcons.homeBottomTab, 'Home'),
          _bottomNavBarItem(MimicIcons.discoverBottomTab, 'Discover'),
          _bottomNavBarItem(Icons.add, 'Add'),
          _bottomNavBarItem(MimicIcons.challenges, 'Challenges'),
          _bottomNavBarItem(MimicIcons.accountFilled, 'Account'),
        ],
      ),
      drawer: const UserDrawer(),
      body: _screens[selectedIndex],
    );
  }

  CustomBottomNavBarItem _bottomNavBarItem(IconData icon, String title) {
    return CustomBottomNavBarItem(
      icon: Icon(icon),
      title: Text(
        title,
        style: getSemiBoldStyle(fontSize: FontSize.s14),
      ),
    );
  }
}
