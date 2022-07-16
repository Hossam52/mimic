import 'package:dio/dio.dart';
import 'package:mimic/shared/helpers/constants_helper.dart';
import 'package:mimic/shared/services/handling_apis.dart';

class ChallengerProfileRepository {
  Future<Response> getProfileDataChallenger(int id) async {
    return await HandlingApis.postData(
        url: ConstantHelper.getClientById, data: {'id': id});
  }

  Future<Response> getChallengesByCreatorId(int id,{int page=1}) async {
    return await HandlingApis.postData(
        url: ConstantHelper.getChallangesByCreatorId, data: {
          'creater_id':id,
        },
        quary: {'page':page});
  }
}
