import 'package:dio/dio.dart';
import 'package:mimic/shared/helpers/constants_helper.dart';
import 'package:mimic/shared/services/handling_apis.dart';

class MarkedChallengesRepository {
  Future<Response> getMyFavChallenges({int page=1}) async {
    return await HandlingApis.getData(url: ConstantHelper.getFavChallenges,
    quary: {'page':page,},
    );
  }
}
