import 'package:dio/dio.dart';
import 'package:mimic/shared/helpers/constants_helper.dart';
import 'package:mimic/shared/services/handling_apis.dart';

class WatchVideoChallangerRepository {
  Future<Response> watchVideoChallanger(int videoId) async {
    return await HandlingApis.postData(
        url: ConstantHelper.watchVideo, data: {'video_id': videoId});
  }
}
