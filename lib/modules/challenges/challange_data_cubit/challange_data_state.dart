part of 'challange_data_cubit.dart';

@immutable
abstract class ChallangeDataState {}

class ChallangeDataInitial extends ChallangeDataState {}

class ChallangeDataLoading extends ChallangeDataState {}

class ChallangeDataSuccess extends ChallangeDataState {}

class ChallangeDataError extends ChallangeDataState {
  final String error;
  ChallangeDataError(this.error);
}
