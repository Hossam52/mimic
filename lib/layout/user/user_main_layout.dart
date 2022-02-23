import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/layout/guest/widgets/guest_drawer.dart';
import 'package:mimic/layout/my_challenges/my_challenges_layot.dart';
import 'package:mimic/layout/my_profile/my_profile_layout.dart';
import 'package:mimic/layout/search/search_layout.dart';
import 'package:mimic/layout/user/widgets/user_drawer.dart';
import 'package:mimic/layout/widgets/bottom_bar_widgets.dart';
import 'package:mimic/layout/widgets/mimic_bottom_bar.dart';
import 'package:mimic/layout/widgets/notification_icon.dart';
import 'package:mimic/modules/challenges/challenge_details/challenge_details.dart';
import 'package:mimic/modules/home/home_screen.dart';
import 'package:mimic/modules/home/user/user_home_screen.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
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
          icon: Icon(
            MimicIcons.menu,
            size: 18.r,
            color: Theme.of(context).primaryColor,
          ),
        ),
        actions: const [NotificationIcon()],
      ),
      // bottomNavigationBar: CustomBottomNavBar(
      //   curve: Curves.easeIn,
      //   currentIndex: selectedIndex,
      //   onTap: (index) {
      //     setState(() {
      //       selectedIndex = index;
      //     });
      //   },
      //   selectedItemColor: ColorManager.selectedBottomColor,
      //   unselectedItemColor: ColorManager.darkGrey,
      //   selectedColorOpacity: 0.3,
      //   itemPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      //   margin: const EdgeInsets.all(0),
      //   items: [
      //     _bottomNavBarItem(_icon(MimicIcons.homeBottomTab), 'Home'),
      //     _bottomNavBarItem(_icon(MimicIcons.discoverBottomTab), 'Discover'),
      //     _bottomNavBarItem(_add(), ''),
      //     _bottomNavBarItem(_icon(MimicIcons.challenges), 'Challenges'),
      //     _bottomNavBarItem(_icon(Icons.account_circle_outlined), 'Account'),
      //   ],
      // ),
      drawer: const UserDrawer(),
      body: Column(
        children: [
          Expanded(child: _screens[selectedIndex]),
          MimicBottomBar(
            selectedIndex: selectedIndex,
            onTap: (index) {
              if (index == 2) {
                navigateTo(context, Routes.createChallenge);
                return;
              }
              setState(() {
                selectedIndex = index;
              });
            },
            bottomBars: [
              MimicBottomBarItem(
                  title: 'Home', widget: const HomeBottomBarWidget()),
              MimicBottomBarItem(
                  title: 'Discover', widget: const SearchBottomBarWidget()),
              MimicBottomBarItem(
                  title: '', widget: const AddChallengeBottomBarWidget()),
              MimicBottomBarItem(
                  title: 'Challenges',
                  widget: const ChallengesBottomBarWidget()),
              MimicBottomBarItem(
                  title: 'Account', widget: const AccountBottomBarWidget()),
            ],
          ),
        ],
      ),
    );
  }

  CustomBottomNavBarItem _bottomNavBarItem(Widget child, String title) {
    return CustomBottomNavBarItem(
      icon: child,
      title: Text(
        title,
        style: getSemiBoldStyle(fontSize: FontSize.s8)
            .copyWith(fontFamily: FontConstants.poppins),
      ),
    );
  }

  Widget _add() {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10.r)),
      child: Icon(
        Icons.add,
        color: ColorManager.white,
        size: 40.r,
      ),
    );
  }

  Widget _icon(IconData icon) {
    return Icon(
      icon,
      color: ColorManager.commentsColor,
      size: 20.r,
    );
  }
}
