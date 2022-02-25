import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimic/layout/my_challenges/cubit/my_challenges_states.dart';
import 'package:mimic/layout/widgets/tab_bar_header.dart';
import 'package:mimic/modules/my_challenges/approved_challenges.dart';
import 'package:mimic/modules/my_challenges/challenges_draft.dart';
import 'package:mimic/modules/my_challenges/new_challenge_requests.dart';
import 'package:mimic/modules/my_challenges/rejected_challenges.dart';

class MyChallengesCubit extends Cubit<MyChallengesStateState> {
  MyChallengesCubit({required this.tabBarController})
      : super(InitialMyChallengesCubit());
  static MyChallengesCubit instance(BuildContext context) =>
      BlocProvider.of<MyChallengesCubit>(context);
  final TabController tabBarController;
  final List<CustomTabBarItem> _myChallengesTabBars = [
    CustomTabBarItem(name: 'New Request', widget: const NewChallengeRequests()),
    CustomTabBarItem(name: 'Approved', widget: const ApprovedChallenges()),
    CustomTabBarItem(name: 'Rejected', widget: const RejectedChallenges()),
    CustomTabBarItem(name: 'Draft', widget: const ChallengesDraft()),
  ];
  List<CustomTabBarItem> get getTabs => _myChallengesTabBars;
  int _currentIndex = 0;
  int get getInitialIndex => _currentIndex;
  List<Widget> get getTabsScreens =>
      getTabs.map((item) => item.widget).toList();

  void goToApprovedChallenges() {
    _currentIndex = 1;
    tabBarController.animateTo(1);
  }

  void geToNewRequestChallenges() {
    _currentIndex = 1;
    tabBarController.animateTo(0);
  }

  void changeTabIndex(int index) {
    _currentIndex = index;
  }
}
