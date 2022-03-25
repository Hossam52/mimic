// import 'dart:convert';

// import 'package:dio/dio.dart';
// import 'package:mimic/shared/helpers/constants_helper.dart';

// class DioHelperNotifications {
//   static Dio? dio;

//   static init() {
//     dio = Dio(
//       BaseOptions(
//         baseUrl: ConstantHelper.baseUrl,
//         receiveDataWhenStatusError: true,
//         followRedirects: false,
//        validateStatus: (status) {
//           return status!=null &&status < 500;
//         },
//         headers: 
//         {
//           'Accept': 'application/json',
//           //CacheHelper.getDate(key: ConstantHelper.languageCode)??'ar',
//         },
//       ),
//     );
//   }

  

//   static Future<Response> postData({
//     required String url,
//     Map<String, dynamic>? query,
//     required dynamic data,
//     String? token='',
//   }) async {
//     dio!.options.headers = 
//     {
//       'Accept': 'application/json',
//       'Authorization': ConstantHelper.serverKey,
//     };
//     return dio!.post(
//       url,
//       queryParameters: query,
//       data: json.encode(data),
//     );
//   }
// }
