import 'package:dio/dio.dart';
import 'package:mimic/shared/helpers/constants_helper.dart';
import 'package:mimic/shared/services/handling_apis.dart';

class ChallangeDataRepository {
  Future<Response> challangeVideos({required int challangeId}) async {
    return await HandlingApis.postData(
        url: ConstantHelper.getChallangeVideos,
        data: {'challenge_id': challangeId});
  }

  Future<Response> challangeDetails({required int challangeId}) async {
    return await HandlingApis.postData(
        url: ConstantHelper.getChallangeDetails,
        data: {'challenge_id': challangeId});
  }
}
