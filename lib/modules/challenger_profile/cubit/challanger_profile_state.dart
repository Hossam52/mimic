part of 'challanger_profile_cubit.dart';

@immutable
abstract class ChallangerProfileState {}

class ChallangerProfileInitial extends ChallangerProfileState {}

class ChallangerProfileLoading extends ChallangerProfileState {
  final bool isFirst;
  ChallangerProfileLoading(this.isFirst);
}

class ChallangerProfileSuccess extends ChallangerProfileState {}

class ChallangerProfileError extends ChallangerProfileState {
  final String error;
  ChallangerProfileError(this.error);
}
