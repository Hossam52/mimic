import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mimic/layout/guest/widgets/guest_drawer.dart';
import 'package:mimic/layout/my_challenges/my_challenges_layot.dart';
import 'package:mimic/layout/my_profile/my_profile_layout.dart';
import 'package:mimic/layout/search/search_layout.dart';
import 'package:mimic/layout/widgets/notification_icon.dart';
import 'package:mimic/modules/home/guest/guest_home_screen.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/bottom_navigation.dart';
import 'package:mimic/widgets/mimic_icons.dart';
import 'package:mimic/widgets/mimic_logo.dart';
import 'package:mimic/widgets/sized_icon.dart';

class GuestMainLayout extends StatefulWidget {
  const GuestMainLayout({Key? key}) : super(key: key);

  @override
  State<GuestMainLayout> createState() => _GuestMainLayoutState();
}

class _GuestMainLayoutState extends State<GuestMainLayout> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedIndex = 0;
  final screens = [
    GuestHomeScreen(),
    const SearchLayout(),
    GuestHomeScreen(),
    const MyChallengesLayout(),
    const MyProfileLayout(),
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
          icon: SizedIcon(
            MimicIcons.menu,
            size: 20,
            color: Theme.of(context).primaryColor,
          ),
        ),
        actions: const [NotificationIcon()],
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
      drawer: const GuestDrawer(),
      body: screens[selectedIndex],
    );
  }

  CustomBottomNavBarItem _bottomNavBarItem(IconData icon, String title) {
    return CustomBottomNavBarItem(
      icon: SvgPicture.asset('assets/images/home_add.svg'),
      //   Icon(
      //   icon,
      //   size: 20.r,
      // ),
      title: Text(
        title,
        style: getSemiBoldStyle(fontSize: FontSize.s14),
      ),
    );
  }
}
