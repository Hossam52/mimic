abstract class MyChallengesStateState {}

class InitialMyChallengesCubit extends MyChallengesStateState {}

class LoadingMyChallengesCubit extends MyChallengesStateState {}

class SuccessMyChallengesCubit extends MyChallengesStateState {}

class ErrorMyChallengesCubit extends MyChallengesStateState 
{
  final String error;
  ErrorMyChallengesCubit(this.error);
}
