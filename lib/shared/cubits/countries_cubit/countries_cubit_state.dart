part of 'countries_cubit_cubit.dart';

@immutable
abstract class CountriesCubitState {}

class CountriesCubitInitial extends CountriesCubitState {}

class CountriesCubitLoading extends CountriesCubitState {}

class CountriesCubitSuccess extends CountriesCubitState {}

class CountriesCubitError extends CountriesCubitState {
  final String error;
  CountriesCubitError(this.error);
}
class GetCounterLoading extends CountriesCubitState {}

class GetCounterSuccess extends CountriesCubitState {}

class GetCounterError extends CountriesCubitState {
  GetCounterError();
}
