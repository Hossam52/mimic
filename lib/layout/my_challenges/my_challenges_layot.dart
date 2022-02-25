import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/layout/my_challenges/cubit/my_challenges_cubit.dart';
import 'package:mimic/layout/widgets/tab_bar_header.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';

class MyChallengesLayout extends StatefulWidget {
  const MyChallengesLayout({Key? key, this.initialIndex = 0}) : super(key: key);
  final int initialIndex;
  @override
  State<MyChallengesLayout> createState() => _MyChallengesLayoutState();
}

class _MyChallengesLayoutState extends State<MyChallengesLayout> {
  @override
  Widget build(BuildContext context) {
    final instance = MyChallengesCubit.instance(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          Expanded(
              child: TabBarHeader(
            controller: instance.tabBarController,
            onTap: (index) {
              instance.changeTabIndex(index);
            },
            tabBars: instance.getTabs,
            fontSize: FontSize.s10,
          )),
          Expanded(
            flex: 10,
            child: TabBarView(
              controller: instance.tabBarController,
              children: instance.getTabsScreens,
            ),
          )
        ],
      ),
    );
  }
}
