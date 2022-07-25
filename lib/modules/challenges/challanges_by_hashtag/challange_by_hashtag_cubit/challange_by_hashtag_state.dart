part of 'challange_by_hashtag_cubit.dart';

@immutable
abstract class ChallangeByHashtagState {}

class ChallangeByHashtagInitial extends ChallangeByHashtagState {}

class ChallangeByHashtagLoading extends ChallangeByHashtagState {
  final bool isFirst;
  ChallangeByHashtagLoading(this.isFirst);
}

class ChallangeByHashtagSuccess extends ChallangeByHashtagState {}

class ChallangeByHashtagError extends ChallangeByHashtagState 
{
  final String error;
  ChallangeByHashtagError(this.error);
}
