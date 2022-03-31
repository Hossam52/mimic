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
      await HandlingApis.postData(url: ConstantHelper.loginAccount, data: {
        'email': email,
        'password': password,
      });
  Future<Response> loginWithSocial(
          {required String socialId, required String username}) async =>
      await HandlingApis.postData(
        url: ConstantHelper.authSocial,
        data: {
          'user_name': username,
          'social_id': socialId,
        },
      );

  Future<void> logout() async {
    await HandlingApis.postData(
      url: ConstantHelper.authLogout,
    );
  }

  Future<Response> changePassword(
          {required String password, required String newPassword}) async =>
      await HandlingApis.postData(url: ConstantHelper.changePasswordUrl, data: {
        'oldPassword': password,
        'password': newPassword,
        'password_confirmation': newPassword,
      });
  Future<Response> forgetPassword({required String email}) async =>
      await HandlingApis.postData(url: ConstantHelper.forgetPasswordUrl, data: {
        'email': email,
      });
  Future<Response> resetPassword(
          {required String code, required String password}) async =>
      await HandlingApis.postData(url: ConstantHelper.resetPasswordUrl, data: {
        'token': code,
        'password': password,
        'password_confirmation': password,
      });
}
