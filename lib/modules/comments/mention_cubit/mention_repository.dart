import 'package:dio/dio.dart';
import 'package:mimic/shared/helpers/constants_helper.dart';
import 'package:mimic/shared/services/handling_apis.dart';

class MentionRepository {
  Future<Response> getMentionList({required String username}) async {
    return await HandlingApis.postData(url: ConstantHelper.searchByUsername,
    data: {'user_name':username,});
  }
}
