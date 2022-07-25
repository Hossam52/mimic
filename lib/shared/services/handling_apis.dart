import 'package:dio/dio.dart';
import 'package:mimic/presentation/resourses/values_manager.dart';
import 'package:mimic/shared/network/remote/dio_helper.dart';

class HandlingApis {
  static Future<Response> postData(
      {required String url, dynamic data, Map<String, dynamic>? quary,
      Function? onSendProgress}) async {
    return await DioHelper.postData(
        url: url, data: data, token:  ValuesManager.tokenValue, query: quary,
        progressSend: onSendProgress,
        );
  }

  static Future<Response> getData(
      {required String url, Map<String, dynamic>? quary}) async {
    return await DioHelper.getData(
        url: url, token: ValuesManager.tokenValue, query: quary);
  }
}
