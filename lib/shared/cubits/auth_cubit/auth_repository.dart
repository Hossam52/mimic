import 'package:dio/dio.dart';
import 'package:mimic/shared/helpers/constants_helper.dart';
import 'package:mimic/shared/services/handling_apis.dart';

class AuthRepository {
  Future<Response> register({
    required String username,
    required String password,
    required String email,
    String? oldEmail,
  }) async {
    return await HandlingApis.postData(url: ConstantHelper.registerUrl, data: {
      'user_name': username,
      'password': password,
      'password_confirmation': password,
      'email': email,
      if (oldEmail != null) 'old_email': oldEmail,
    });
  }

  Future<Response> verifyAccount({required String code}) async {
    return await HandlingApis.postData(
        url: ConstantHelper.verifyAccount,
        data: {
          'token': code,
        });
  }

  Future<Response> resendCodeToAccount({required String email}) async {
    return await HandlingApis.postData(
        url: ConstantHelper.resendCodeToAccount,
        data: {
          'email': email,
        });
  }

  Future<Response> loginAccount(
          {required String email, required String password}) async =>
      await HandlingApis.postData(url: ConstantHelper.loginAccount,data: 
      {
        'email':email,
        'password':password,
      });
  Future<Response>loginWithGoogle(
    {required String socialId,
    required String username
  })async =>
    await HandlingApis.postData(
    url: ConstantHelper.authSocial,data: 
    {
      'user_name':username,
      'social_id':socialId,
    },);
  
}
