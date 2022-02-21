import 'package:flutter/material.dart';

import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';

class TabBarHeader extends StatelessWidget {
  const TabBarHeader({Key? key, required this.tabBars}) : super(key: key);
  final List<CustomTabBarItem> tabBars;
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
        labelStyle: getBoldStyle(),
        labelPadding: const EdgeInsets.all(0),
        padding: const EdgeInsets.all(0),
        unselectedLabelColor: ColorManager.black,
        unselectedLabelStyle: getSemiBoldStyle(),
        labelColor: ColorManager.black,
        tabs: tabBars.map((e) => Text(e.name)).toList(),
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
