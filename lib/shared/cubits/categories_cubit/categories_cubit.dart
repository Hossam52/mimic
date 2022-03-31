import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mimic/models/global_models/category_model/category.dart';
import 'package:mimic/models/global_models/category_model/category_model.dart';
import 'package:mimic/presentation/resourses/values_manager.dart';
import 'package:mimic/shared/cubits/categories_cubit/categories_repository.dart';
import 'package:mimic/shared/helpers/constants_helper.dart';
import 'package:mimic/shared/network/locale/cache_helper.dart';
import 'package:mimic/shared/services/handling_apis.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());
  static CategoriesCubit get(context) => BlocProvider.of(context);
  CategoriesRepository categoriesRepository = CategoriesRepository();
  late final CategoriesModel categoriesModel;
  List<Category> selectedCategories = [];
  Future<void> getAllCategories() async {
    emit(CategoriesLoading());
    try {
      categoriesModel = await categoriesRepository.getAllCategories();
      emit(CategoriesSuccess());
    } catch (e) {
      emit(CategoriesError(e.toString()));
      return;
    }
  }

  void selecteCategory(Category category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
    emit(CategoriesRebuild());
  }

  void toggleSelectAllCategories({required bool toggleSelectAll}) {
    if (toggleSelectAll) {
      for (Category category in categoriesModel.categories.categories) {
        if (!selectedCategories.contains(category)) {
          selectedCategories.add(category);
        }
      }
    } else {
      selectedCategories.clear();
    }
    emit(CategoriesRebuild());
  }

  Future<void> submitCategoriesSelected() async {
    emit(CategoriesSubmitLoading());
    try {
      final response = await categoriesRepository.submitCategories(
          categoriesIds: selectedCategories.map((e) => int.parse(e.id)).toList());
      print(response.data);
      if (response.data['status']) {
        CacheHelper.saveDate(
              key: ValuesManager.emailKey, value: ValuesManager.email);
          CacheHelper.saveDate(
              key: ValuesManager.imageKey, value: ValuesManager.imageUrl);
          CacheHelper.saveDate(
              key: ValuesManager.usernameKey, value: ValuesManager.username);
          CacheHelper.saveDate(
              key: ValuesManager.tokenKey, value: ValuesManager.tokenValue);
        emit(CategoriesSubmitSuccess());
      } else {
        emit(CategoriesSubmitError(response.data['message']));
      }
    } catch (e) {
      emit(CategoriesSubmitError(e.toString()));
      return;
    }
  }
}
