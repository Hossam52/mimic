import 'package:dio/dio.dart';
import 'package:mimic/shared/helpers/constants_helper.dart';
import 'package:mimic/shared/services/handling_apis.dart';

class  AllRanksRepository {
  Future<Response>getAllRanks()async=>
   await HandlingApis.getData(url: ConstantHelper.allRanks);
  
}