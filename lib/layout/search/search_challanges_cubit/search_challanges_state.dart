part of 'search_challanges_cubit.dart';

@immutable
abstract class SearchChallangesState {}

class SearchChallangesInitial extends SearchChallangesState {}

class SearchChallangesLoading extends SearchChallangesState {
  final bool isFirst;
  SearchChallangesLoading(this.isFirst);
}

class SearchChallangesSuccess extends SearchChallangesState {}

class SearchChallangesError extends SearchChallangesState {
  final String error;
  SearchChallangesError(this.error);
}
