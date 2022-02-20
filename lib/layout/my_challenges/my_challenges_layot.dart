import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/modules/my_challenges/approved_challenges.dart';
import 'package:mimic/modules/my_challenges/challenges_draft.dart';
import 'package:mimic/modules/my_challenges/new_challenge_requests.dart';
import 'package:mimic/modules/my_challenges/rejected_challenges.dart';
import 'package:mimic/modules/search/search_people.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';

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
              child: TabBar(
                labelStyle: getBoldStyle(),
                labelPadding: const EdgeInsets.all(0),
                padding: const EdgeInsets.all(0),
                unselectedLabelStyle: getBoldStyle(),
                labelColor: ColorManager.black,
                tabs: const [
                  Text('New Request'),
                  Text('Approved'),
                  Text('Rejected'),
                  Text('Draft'),
                ],
                indicatorColor: ColorManager.tabBarIndicator,
              ),
            ),
            const Expanded(
              flex: 10,
              child: TabBarView(children: [
                Center(
                  child: NewChallengeRequests(),
                ),
                Center(
                  child: ApprovedChallenges(),
                ),
                Center(
                  child: RejectedChallenges(),
                ),
                Center(
                  child: ChallengesDraft(),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
