
import 'package:dio/dio.dart';
import 'package:mimic/shared/helpers/constants_helper.dart';
import 'package:mimic/shared/services/handling_apis.dart';

class HomeRepository {
  Future<Response> getCurrentChallanges({int page=1}) async {
    return await HandlingApis.getData(
        url: ConstantHelper.getCurrentChallanges,quary: {'page':page});
  }  
}
