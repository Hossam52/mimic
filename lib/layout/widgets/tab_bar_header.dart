import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/presentation/resourses/values.dart';

class TabBarHeader extends StatelessWidget {
  const TabBarHeader(
      {Key? key,
      required this.tabBars,
      this.fontSize,
      this.onTap,
      this.controller})
      : super(key: key);
  final List<CustomTabBarItem> tabBars;
  final double? fontSize;
  final void Function(int)? onTap;
  final TabController? controller;
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: ColorManager.tabBarIndicator,
          ),
        ),
      ),
      child: TabBar(
        controller: controller,
        onTap: onTap,
        labelStyle: getBoldStyle(fontSize: fontSize??FontSize.s12),
        labelPadding:  EdgeInsets.all(AppPadding.p4.r),
        padding: EdgeInsets.zero,
        unselectedLabelColor: ColorManager.black,
        unselectedLabelStyle: getSemiBoldStyle(fontSize: fontSize??FontSize.s12),
        labelColor: ColorManager.black,
        tabs: tabBars.map((e) => Center(child: Text(e.name))).toList(),
        indicatorWeight: 2,
        indicatorColor: ColorManager.tabBarIndicator,
      ),
    );
  }
}

class CustomTabBarItem {
  String name;
  Widget widget;
  CustomTabBarItem({
    required this.name,
    required this.widget,
  });
}
