import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mimic/layout/guest/widgets/guest_drawer.dart';
import 'package:mimic/layout/my_challenges/my_challenges_layot.dart';
import 'package:mimic/layout/my_profile/my_profile_layout.dart';
import 'package:mimic/layout/search/search_layout.dart';
import 'package:mimic/layout/widgets/bottom_bar_widgets.dart';
import 'package:mimic/layout/widgets/mimic_bottom_bar.dart';
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
      //   margin: const EdgeInsets.all(0),
      //   itemPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      //   items: [
      //     _bottomNavBarItem(_icon(MimicIcons.homeBottomTab), 'Home'),
      //     _bottomNavBarItem(_icon(MimicIcons.discoverBottomTab), 'Discover'),
      //     _bottomNavBarItem(_add(), ''),
      //     _bottomNavBarItem(_icon(MimicIcons.challenges), 'Challenges'),
      //     _bottomNavBarItem(_icon(Icons.account_circle_outlined), 'Account'),
      //   ],
      // ),
      drawer: const GuestDrawer(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          // alignment: Alignment.bottomCenter,
          children: [
            Expanded(child: screens[selectedIndex]),
            MimicBottomBar(
              selectedIndex: selectedIndex,
              onTap: (index) => setState(() {
                selectedIndex = index;
              }),
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
