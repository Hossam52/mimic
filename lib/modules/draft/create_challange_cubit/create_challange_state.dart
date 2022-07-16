part of 'create_challange_cubit.dart';

@immutable
abstract class CreateChallangeState {}

class CreateChallangeInitial extends CreateChallangeState {}

class CreateChallangeLoading extends CreateChallangeState {}

class CreateChallangeUploadLoading extends CreateChallangeState {}

class CreateChallangeProgressLoading extends CreateChallangeState {
  final double progress;
  CreateChallangeProgressLoading(this.progress);
}

class CreateChallangeSuccess extends CreateChallangeState {}

class CreateChallangeError extends CreateChallangeState {
  final String error;
  CreateChallangeError(this.error);
}
