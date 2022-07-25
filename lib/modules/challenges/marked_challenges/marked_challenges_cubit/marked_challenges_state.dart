part of 'marked_challenges_cubit.dart';

@immutable
abstract class MarkedChallengesState {}

class MarkedChallengesInitial extends MarkedChallengesState {}

class MarkedChallengesLoading extends MarkedChallengesState {
  bool isFirst;
  MarkedChallengesLoading(this.isFirst);
}

class MarkedChallengesSuccess extends MarkedChallengesState {}

class MarkedChallengesError extends MarkedChallengesState {
  final String error;
  MarkedChallengesError(this.error);
}
