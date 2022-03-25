import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mimic/shared/helpers/constants_helper.dart';
import 'package:mimic/shared/network/locale/cache_helper.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: ConstantHelper.baseUrl,
        receiveDataWhenStatusError: true,
        followRedirects: false,
        validateStatus: (status) {
          return status != null && status < 500;
        },
        headers: {
          'Accept': 'application/json',
          "Apipassword": 'mimic2022',
          'lang': CacheHelper.getDate(key: ConstantHelper.languageCode) ?? 'ar',
        },
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token = '',
  }) async {
    dio!.options.headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      "Apipassword": 'mimic2022',
      'lang': CacheHelper.getDate(key: ConstantHelper.languageCode) ?? 'ar',
    };

    return await dio!.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    @required dynamic data,
    String? token = '',
  }) async {
    dio!.options.headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      "Apipassword": 'mimic2022',
      'lang': CacheHelper.getDate(key: ConstantHelper.languageCode) ?? 'ar',
    };
    return dio!.post(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
