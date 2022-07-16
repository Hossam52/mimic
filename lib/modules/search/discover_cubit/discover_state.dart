part of 'discover_cubit.dart';

@immutable
abstract class DiscoverState {}

class DiscoverInitial extends DiscoverState {}
class DiscoverError extends DiscoverState {}
class DiscoverLoading extends DiscoverState {}
class DiscoverSuccess extends DiscoverState {}

