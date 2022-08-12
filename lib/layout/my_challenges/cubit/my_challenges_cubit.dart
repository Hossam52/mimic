import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimic/layout/my_challenges/cubit/my_challenges_repository.dart';
import 'package:mimic/layout/my_challenges/cubit/my_challenges_states.dart';
import 'package:mimic/layout/widgets/tab_bar_header.dart';
import 'package:mimic/models/challenge_models/challenge_model.dart';
import 'package:mimic/modules/my_challenges/approved_challenges.dart';
import 'package:mimic/modules/my_challenges/challenges_draft.dart';
import 'package:mimic/modules/my_challenges/new_challenge_requests.dart';
import 'package:mimic/modules/my_challenges/rejected_challenges.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/shared/network/check_network_state/check_network_state.dart';

class MyChallengesCubit extends Cubit<MyChallengesStateState> {
  MyChallengesCubit({required this.tabBarController})
      : super(InitialMyChallengesCubit());
  static MyChallengesCubit instance(BuildContext context) =>
      BlocProvider.of<MyChallengesCubit>(context);
  final MyChallengesRepostiory _myChallengesRepostiory =
      MyChallengesRepostiory();
  Set<Challange> challanges = {};
  final TabController tabBarController;
  final List<CustomTabBarItem> _myChallengesTabBars = [
    CustomTabBarItem(
        name: AppStrings.newRequests, widget:  NewChallengeRequests()),
    CustomTabBarItem(
        name: AppStrings.approved, widget:  ApprovedChallenges()),
    CustomTabBarItem(
        name: AppStrings.rejected, widget:  RejectedChallenges()),
    CustomTabBarItem(name: AppStrings.draft, widget: const ChallengesDraft()),
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

  Future<void> getMyChallengesFilterd({int? categoryId}) async {
    if (await checkInternetConnecation()) {
      emit(LoadingMyChallengesCubit());
      Response response;
      challanges = {};
      try {
        switch (tabBarController.index) {
          case 0:
            response = await _myChallengesRepostiory.getMyChallangesFiltered(
              status: 'pending',
              categoryId: categoryId,
            );
            break;
          case 1:
            response = await _myChallengesRepostiory.getMyChallangesFiltered(
              status: 'accept',
              categoryId: categoryId,
            );

            break;
          case 2:
            response = await _myChallengesRepostiory.getMyChallangesFiltered(
              status: 'reject',
              categoryId: categoryId,
            );

            break;

          default:
            response = await _myChallengesRepostiory.getMyChallangesFiltered(
              status: 'pending',
              categoryId: categoryId,
            );
        }
        if (response.data['status']) {
          challanges =
              ChallengesModel.fromJson(response.data).challenges.data.toSet();
          //   .addAll(ChallengesModel.fromJson(response.data).challenges.data);
          emit(SuccessMyChallengesCubit());
        } else {
          emit(ErrorMyChallengesCubit(response.data['message'].toString()));
        }
        //} else {}
      } catch (e) {
        emit(ErrorMyChallengesCubit(''));
        rethrow;
      }
    } else {
      emit(ErrorMyChallengesCubit(AppStrings.checkInternet));
    }
  }
}
