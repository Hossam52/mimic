import 'package:dio/dio.dart';
import 'package:mimic/shared/helpers/constants_helper.dart';
import 'package:mimic/shared/services/handling_apis.dart';

class DiscoveryRepository {
  Future<Response> getUsersByName({required String name}) async {
    return await HandlingApis.postData(
        url: ConstantHelper.discoverPeople, data: {'user_name': name});
  }
}
