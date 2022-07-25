import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimic/layout/my_challenges/cubit/my_challenges_cubit.dart';
import 'package:mimic/layout/my_challenges/my_challenges_layot.dart';
import 'package:mimic/layout/my_profile/my_profile_layout.dart';
import 'package:mimic/layout/search/search_layout.dart';
import 'package:mimic/layout/user/cubit/user_states.dart';
import 'package:mimic/modules/home/user/user_home_screen.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/shared/methods.dart';

class UserCubit extends Cubit<UserStates> {
  UserCubit() : super(InitAppState());
  static UserCubit instance(BuildContext context) =>
      BlocProvider.of<UserCubit>(context);
  final _userScreens = [
    UserHomeScreen(),
    const SearchLayout(),
    Container(),
    const MyChallengesLayout(),
    const MyProfileLayout(),
  ];
  int _selectedScreenIndex = 0;
  int get selectedScreenIndex => _selectedScreenIndex;

  Widget get screen => _userScreens[selectedScreenIndex];

  //My Challenges navigation tab bar
  void navigateToMyChallengesApproved(BuildContext context) {
    MyChallengesCubit.instance(context).goToApprovedChallenges();
    _navigateToMyChallenges(context);
  }

  void navigateToMyNewRequestChallenges(BuildContext context) {
    MyChallengesCubit.instance(context).geToNewRequestChallenges();
    _navigateToMyChallenges(context);
  }

  void _navigateToMyChallenges(BuildContext context) =>
      changeScreenIndex(context, 3);
// End My Challenges Navigation tab bar

  void navigateToMyProfile(BuildContext context) =>
      changeScreenIndex(context, 4);
  void navigateToSearch(BuildContext context) => changeScreenIndex(context, 1);

  void changeScreenIndex(BuildContext context, int index) {
    if (index == 2) {
      navigateTo(context, Routes.createChallenge);
    } else {
      _selectedScreenIndex = index;
    }
    emit(ChangeUserScreenIndexAppState());
  }
}
