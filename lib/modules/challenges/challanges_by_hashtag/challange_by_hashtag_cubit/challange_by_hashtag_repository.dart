import 'package:dio/dio.dart';
import 'package:mimic/shared/helpers/constants_helper.dart';
import 'package:mimic/shared/services/handling_apis.dart';

class ChallangeByHashtagRepository {
  Future<Response> getChallangesByHashtagId(int id,{int page=1}) async 
  {
    return await HandlingApis.postData(url: ConstantHelper.searchOnChallangesByHashTagId,
    data: 
    {'id':id,},quary: {'page':page,});
  }
}
