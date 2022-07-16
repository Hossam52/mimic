import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mimic/models/challenge_models/hashtag_model.dart';
import 'package:mimic/models/global_models/category_model/category.dart';
import 'package:mimic/models/global_models/category_model/category_model.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/presentation/resourses/values_manager.dart';
import 'package:mimic/shared/cubits/categories_cubit/categories_repository.dart';
import 'package:mimic/shared/helpers/error_handling/error_handler.dart';
import 'package:mimic/shared/network/check_network_state/check_network_state.dart';
import 'package:mimic/shared/network/locale/cache_helper.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());
  static CategoriesCubit get(context) => BlocProvider.of(context);
  CategoriesRepository categoriesRepository = CategoriesRepository();
  late final CategoriesModel categoriesModel;
  final ErrorHandler _errorHandler = ErrorHandler();
  late HashTagModel hashTagModel;
  List<HashTag> newHashtags = [];
  List<String> selectedHashtags = [];
  List<Category> selectedCategories = [];

  Future<void> getAllCategories() async {
    emit(CategoriesLoading());
    try {
      if (await checkInternetConnecation()) {
        categoriesModel = await categoriesRepository.getAllCategories();
        emit(CategoriesSuccess());
      } else {
        emit(CategoriesError(AppStrings.checkInternet));
      }
    } catch (e) {
      emit(CategoriesError(e.toString()));
      return;
    }
  }

  Future<void> getCategoryHashtags({required int categoryId}) async {
    emit(HashTagsLoading());
    try {
      if (await checkInternetConnecation()) {
        hashTagModel =
            await categoriesRepository.getHashTagsCategory(id: categoryId);
        emit(HashTagsSuccess());
      } else {
        emit(HashTagsError(AppStrings.checkInternet));
      }
    } catch (e) {
      emit(HashTagsError(_errorHandler.getErrorHappen(e).message));
      rethrow;
    }
  }

  void selectNewHashtag(String hashtagId) {
    if (selectedHashtags.contains(hashtagId)) {
      selectedHashtags.remove(hashtagId);
    } else {
      selectedHashtags.add(hashtagId);
    }
    emit(HashTagsSuccess());
  }

  void addNewHashtag(HashTag hashTag) {
    hashTagModel.hashtags.add(hashTag);
    newHashtags.add(hashTag);
  }

  List<String> hashTagFilters() {
    List<String> newHashtagsNames = [];
    for (int index = 0; index < newHashtags.length; index++) {
      if (selectedHashtags.remove(newHashtags[index].id.toString())) {
        //remove from nawHashtags
        log(newHashtags[index].id.toString());
        newHashtagsNames.add(newHashtags[index].name);
      }
    }
    

    return newHashtagsNames;
  }

  bool chekHashtagNotFound(String hashtagName) {
    return hashTagModel.hashtags
            .firstWhere((element) => element.name == hashtagName, orElse: () {
          return HashTag(id: -1, name: "-1");
        }).id ==
        -1;
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
          categoriesIds:
              selectedCategories.map((e) => int.parse(e.id)).toList());
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
