part of 'search_users_cubit.dart';

@immutable
abstract class SearchUsersState {}

class SearchUsersInitial extends SearchUsersState {}

class SearchUsersLoading extends SearchUsersState {
  final bool isFirst;
  SearchUsersLoading(this.isFirst);
}

class SearchUsersSuccess extends SearchUsersState {}

class SearchUsersError extends SearchUsersState {
  final String error;
  SearchUsersError(this.error);
}
