import 'package:dio/dio.dart';
import 'package:mimic/shared/helpers/constants_helper.dart';
import 'package:mimic/shared/services/handling_apis.dart';

class ChallengerProfileRepository {
  Future<Response> getProfileDataChallenger(dynamic id) async {
    return await HandlingApis.postData(
        url: ConstantHelper.getClientById,
        data: {
          if (id is int) 'id': id,
          if (id is String) 'user_name': id.split('@').last,
        });
  }

  Future<Response> getProfileDataChallangerByName(String username) async {
    return await HandlingApis.postData(
        url: ConstantHelper.getClientById,
        data: {'user_name': username.split('@').last});
  }

  Future<Response> getChallengesByCreatorId(int id, {int page = 1}) async {
    return await HandlingApis.postData(
        url: ConstantHelper.getChallangesByCreatorId,
        data: {
          'creater_id': id,
        },
        quary: {
          'page': page
        });
  }

  Future<Response> getChallangeJoinedById(int id, {int page = 1}) async {
    return await HandlingApis.postData(
        url: ConstantHelper.getChallangesJoindedById,
        data: {
          'client_id': id
        },
        quary: {
          'page': page,
        });
  }
}
