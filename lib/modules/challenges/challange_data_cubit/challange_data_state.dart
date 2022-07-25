part of 'challange_data_cubit.dart';

@immutable
abstract class ChallangeDataState {}

class ChallangeDataInitial extends ChallangeDataState {}

class ChallangeDataLoading extends ChallangeDataState {
  bool isFirst;
  ChallangeDataLoading(this.isFirst);
}

class ChallangeDataSuccess extends ChallangeDataState {}

class ChallangeDataSuccessAddVideo extends ChallangeDataState {
  final String message;
  ChallangeDataSuccessAddVideo(this.message);
}

class ChallangeDataError extends ChallangeDataState {
  final String error;
  ChallangeDataError(this.error);
}
