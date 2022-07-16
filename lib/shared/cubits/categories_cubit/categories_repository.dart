import 'package:dio/dio.dart';
import 'package:mimic/models/challenge_models/hashtag_model.dart';
import 'package:mimic/models/global_models/category_model/category_model.dart';
import 'package:mimic/shared/cubits/categories_cubit/categories_services.dart';

class CategoriesRepository {
  final CategoriesServices _categoriesServices = CategoriesServices();
  Future<CategoriesModel> getAllCategories() async {
    final response = await _categoriesServices.getAllCategories();
    return CategoriesModel.fromJson(response.data);
  }

  Future<Response> submitCategories({required List<int> categoriesIds}) async =>
      await _categoriesServices.addToMyFav(categoriesIds: categoriesIds);
  Future<HashTagModel> getHashTagsCategory({required int id}) async 
  {
    final response =
        await _categoriesServices.getHashTagsCategory(categoryId: id);
    return HashTagModel.fromJson(response.data);
  }
}
