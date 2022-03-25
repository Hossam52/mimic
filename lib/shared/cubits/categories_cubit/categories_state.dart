part of 'categories_cubit.dart';

@immutable
abstract class CategoriesState {}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesSuccess extends CategoriesState {}

class CategoriesError extends CategoriesState {
  final String message;
  CategoriesError(this.message);
}

class CategoriesRebuild extends CategoriesState {}
class CategoriesSubmitLoading extends CategoriesState {}

class CategoriesSubmitSuccess extends CategoriesState {}

class CategoriesSubmitError extends CategoriesState {
  final String message;
  CategoriesSubmitError(this.message);
}
