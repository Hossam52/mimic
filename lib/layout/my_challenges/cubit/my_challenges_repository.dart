import 'package:dio/dio.dart';
import 'package:mimic/shared/helpers/constants_helper.dart';
import 'package:mimic/shared/services/handling_apis.dart';

class MyChallengesRepostiory {
  Future<Response> getMyChallangesFiltered({required String status}) async {
    return await HandlingApis.postData(url: ConstantHelper.getMyChallenges,data: {'status':status});
  }
}
