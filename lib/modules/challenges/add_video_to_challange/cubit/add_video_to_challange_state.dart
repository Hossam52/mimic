part of 'add_video_to_challange_cubit.dart';

@immutable
abstract class AddVideoToChallangeState {}

class AddVideoToChallangeInitial extends AddVideoToChallangeState {}

class AddVideoToChallangeLoading extends AddVideoToChallangeState {}

class AddVideoToChallangePrepareing extends AddVideoToChallangeState {
  final double progress;
  AddVideoToChallangePrepareing(this.progress);
}

class AddVideoToChallangeSuccess extends AddVideoToChallangeState {}

class AddVideoToChallangeError extends AddVideoToChallangeState {
  final String error;
  AddVideoToChallangeError(this.error);
}
