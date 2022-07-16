part of 'home_cubit_cubit.dart';

@immutable
abstract class HomeCubitState {}

class HomeCubitInitial extends HomeCubitState {}

class HomeCubitLoading extends HomeCubitState {}

class HomeCubitSuccess extends HomeCubitState {}

class HomeCubitError extends HomeCubitState {
  final String error;
  HomeCubitError(this.error);
}
