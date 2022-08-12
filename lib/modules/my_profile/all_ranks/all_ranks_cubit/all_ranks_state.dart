part of 'all_ranks_cubit.dart';

abstract class AllRanksState extends Equatable {
  const AllRanksState();

  @override
  List<Object> get props => [];
}

class AllRanksInitial extends AllRanksState {}

class AllRanksLoading extends AllRanksState {}

class AllRanksSuccess extends AllRanksState {}

class AllRanksError extends AllRanksState {
  final String error;
  const AllRanksError(this.error);
}
