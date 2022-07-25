import 'package:dio/dio.dart';
import 'package:mimic/shared/helpers/constants_helper.dart';
import 'package:mimic/shared/services/handling_apis.dart';

class SearchRepository {
  Future<Response> getUsersByName({required String name, int page = 1}) async {
    return await HandlingApis.postData(
        url: ConstantHelper.discoverPeople,
        data: {
          'user_name': name,
        },
        quary: {
          'page': page
        });
  }

  Future<Response> searchOnChallanges({
    int? categoryId,
    int? period,
    int page=1,
  }) async {
    FormData formData = FormData.fromMap(
      {
        if(categoryId!=null)
        'category_id[]':categoryId,
        if(period!=null)
         'period':period,//0 -> last week 1-> last month ,2-> last year
      },
    );
    return await HandlingApis.postData(
        url: ConstantHelper.searchOnChallanges, data: formData,
        quary: {'page':page,});
  }
}
