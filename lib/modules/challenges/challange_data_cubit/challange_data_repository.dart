import 'package:dio/dio.dart';
import 'package:mimic/shared/helpers/constants_helper.dart';
import 'package:mimic/shared/services/handling_apis.dart';

class ChallangeDataRepository {
  Future<Response> challangeVideos(
      {required int challangeId, int page = 1}) async {
    return await HandlingApis.postData(
        url: ConstantHelper.getChallangeVideos,
        data: {'challenge_id': challangeId},
        quary: {'page': page});
  }

  Future<Response> challangeDetails({required int challangeId}) async {
    return await HandlingApis.postData(
        url: ConstantHelper.getChallangeDetails,
        data: {'challenge_id': challangeId});
  }

  Future<Response> addChallengeToMarked({required int challengeId}) async {
    return await HandlingApis.postData(url: ConstantHelper.toggleFavChallenge,
    data: {'challenge_id': challengeId},
    );
  }
}
