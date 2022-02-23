import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/widgets/bottom_navigation.dart';
import 'package:mimic/widgets/mimic_icons.dart';

class MimicBottomBar extends StatelessWidget {
  const MimicBottomBar(
      {Key? key,
      required this.selectedIndex,
      required this.onTap,
      required this.bottomBars,
      this.transparentColorIndex = 2})
      : super(key: key);
  final int selectedIndex;
  final void Function(int) onTap;
  final List<MimicBottomBarItem> bottomBars;
  final int
      transparentColorIndex; //to make the selected color add icon is transparent
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(50.r)),
      child: CustomBottomNavBar(
        // itemShape:
        //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        curve: Curves.easeIn,
        currentIndex: selectedIndex,
        onTap: onTap,
        selectedItemColor: ColorManager.selectedBottomColor,
        unselectedItemColor: ColorManager.darkGrey,
        selectedColorOpacity: selectedIndex == transparentColorIndex ? 0 : 0.3,
        margin: EdgeInsets.all(4.h),
        itemPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        items: bottomBars
            .map(
              (e) => _bottomNavBarItem(e.widget, e.title),
            )
            .toList(),
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
}

class MimicBottomBarItem {
  final String title;
  final Widget widget;
  final double? opacity;

  MimicBottomBarItem({required this.title, required this.widget, this.opacity});
}
