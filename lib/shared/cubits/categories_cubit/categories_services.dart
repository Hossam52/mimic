import 'package:dio/dio.dart';
import 'package:mimic/shared/helpers/constants_helper.dart';
import 'package:mimic/shared/services/handling_apis.dart';

class CategoriesServices {
  Future<Response> getAllCategories() async =>
      await HandlingApis.getData(url: ConstantHelper.getAllCategories);
  Future<Response> addToMyFav(
    {
     required List<int>categoriesIds,
    }) async =>
      await HandlingApis.postData(url: ConstantHelper.addToFavCategories,
      data:FormData.fromMap(
        {
        'cateories_ids[]':categoriesIds,
        },),);
}
