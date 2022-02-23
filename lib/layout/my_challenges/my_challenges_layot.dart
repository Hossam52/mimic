import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/layout/widgets/tab_bar_header.dart';
import 'package:mimic/modules/my_challenges/approved_challenges.dart';
import 'package:mimic/modules/my_challenges/challenges_draft.dart';
import 'package:mimic/modules/my_challenges/new_challenge_requests.dart';
import 'package:mimic/modules/my_challenges/rejected_challenges.dart';
import 'package:mimic/modules/search/search_people.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';

final List<CustomTabBarItem> _myChallengesTabBars = [
  CustomTabBarItem(name: 'New Request', widget: const NewChallengeRequests()),
  CustomTabBarItem(name: 'Approved', widget: const ApprovedChallenges()),
  CustomTabBarItem(name: 'Rejected', widget: const RejectedChallenges()),
  CustomTabBarItem(name: 'Draft', widget: const ChallengesDraft()),
];

class MyChallengesLayout extends StatelessWidget {
  const MyChallengesLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            Expanded(
                child: TabBarHeader(
              tabBars: _myChallengesTabBars,
              fontSize: FontSize.s10,
            )),
            Expanded(
              flex: 10,
              child: TabBarView(
                children: _myChallengesTabBars
                    .map((e) => Center(child: e.widget))
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
