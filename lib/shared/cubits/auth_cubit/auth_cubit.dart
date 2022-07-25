import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mimic/enums/social_login.dart';
import 'package:mimic/presentation/resourses/values_manager.dart';
import 'package:mimic/shared/cubits/auth_cubit/auth_repository.dart';
import 'package:mimic/shared/network/locale/cache_helper.dart';
import 'package:mimic/shared/services/security_services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);
  AuthRepository authRepository = AuthRepository();
  String? email;
  String? forgetPasswordEmail;
  String? forgetPasswordCode;

  Future<void> registerAccount({
    required String username,
    required String email,
    required String password,
  }) async {
    emit(AuthRegisterLoading());
    Response response;
    try {
      response = await authRepository.register(
          username: username,
          password: password,
          email: email,
          oldEmail: this.email);
      if (response.data['status']) {
        //CacheHelper.saveDate(key: ValuesManager.tokenKey, value: ValuesManager.tokenValue);
        this.email = email;
        emit(AuthRegisterSuccess());
      } else {
        emit(AuthRegisterError(response.data['message'].toString()));
      }
    } catch (e) {
      emit(AuthRegisterError('Error ${e.toString()}'));
    }
  }

  Future<void> verifyAccount({required String code}) async {
    emit(AuthActiviteLoading());
    try {
      final response = await authRepository.verifyAccount(code: code);
      if (response.data['status']) {
        ValuesManager.tokenValue = response.data['RT'];
        ValuesManager.username =
            SecurityServices.decrypt(response.data['RC']['R1']);
        ValuesManager.email =
            SecurityServices.decrypt(response.data['RC']['R2']);
        ValuesManager.imageUrl =
            SecurityServices.decrypt(response.data['RC']['R5']);
        emit(AuthActiviteSuccess());
      } else {
        emit(AuthActiviteError(response.data['message']));
      }
    } catch (e) {
      emit(AuthActiviteError(e.toString()));
      return;
    }
  }

  Future<void> resendCodeToAccount() async {
    emit(AuthResendCodeLoading());
    try {
      final response = await authRepository.resendCodeToAccount(email: email!);
      // print(response.data);
      if (response.data['status']) {
        emit(AuthResendCodeSuccess(response.data['message']));
      } else {
        emit(AuthActiviteError(response.data['message']));
      }
    } catch (e) {
      emit(AuthResendCodeError('message'));
      return;
    }
  }

  Future<void> loginAccount(
      {required String email, required String password}) async {
    emit(AuthLoginLoading());
    try {
      final response =
          await authRepository.loginAccount(email: email, password: password);
      log(response.data.toString());
      if (response.data['status']) {
        this.email = email;
        if (response.data['type'] != 0) {
          ValuesManager.tokenValue = response.data['RT'];
          ValuesManager.username =
              SecurityServices.decrypt(response.data['RC']['R1']);
          ValuesManager.email =
              SecurityServices.decrypt(response.data['RC']['R2']);
          ValuesManager.imageUrl =
              SecurityServices.decrypt(response.data['RC']['R5']);
          CacheHelper.saveDate(
              key: ValuesManager.emailKey, value: ValuesManager.email);
          CacheHelper.saveDate(
              key: ValuesManager.imageKey, value: ValuesManager.imageUrl);
          CacheHelper.saveDate(
              key: ValuesManager.usernameKey, value: ValuesManager.username);
          CacheHelper.saveDate(
              key: ValuesManager.tokenKey, value: ValuesManager.tokenValue);
        }
        if (response.data['type'] == 2) {
          emit(AuthLoginSuccess(''));
        } else if (response.data['type'] == 1) {
          emit(AuthNavigateFillIntrestesState());
        } else {
          authRepository.resendCodeToAccount(email: email);
          emit(AuthNavigateToVerifiyState());
        }
      } else {
        emit(AuthLoginError(response.data['message'].toString()));
      }
    } catch (e) {
      emit(AuthLoginError(e.toString()));
      return;
    }
  }

  Future<void> logout() async {
    final socialLoged = CacheHelper.getDate(key: ValuesManager.socialKey);
    CacheHelper.removeData(key: ValuesManager.tokenKey);
    CacheHelper.removeData(key: ValuesManager.emailKey);
    CacheHelper.removeData(key: ValuesManager.usernameKey);
    CacheHelper.removeData(key: ValuesManager.imageKey);
    //
    CacheHelper.removeData(key: ValuesManager.socialKey);
    if (socialLoged != null) {
      if (socialLoged == SocialLogin.facebook.index) {
        await FacebookLogin().logOut();
      } else if (socialLoged == SocialLogin.google.index) {
        await GoogleSignIn().signOut();
      }
    }
    authRepository.logout();
  }
  //auth with social

  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    emit(AuthLoginWithGoogleLoading());
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final auth = await googleUser!.authentication;
      // print(auth.idToken);

      // print(googleUser.displayName);
      // print(googleUser.email);
      final response = await authRepository.loginWithSocial(
          socialId: googleUser.id, username: googleUser.displayName!);
      log(response.data.toString());
      if (response.data['status']) {
        CacheHelper.saveDate(
            key: ValuesManager.socialKey, value: SocialLogin.google.index);
        ValuesManager.tokenValue = response.data['RT'];
        ValuesManager.username =
            SecurityServices.decrypt(response.data['RC']['R1']);
        ValuesManager.email =
            SecurityServices.decrypt(response.data['RC']['R2']);
        ValuesManager.imageUrl =
            SecurityServices.decrypt(response.data['RC']['R5']);
        if (response.data['category'] == 0) {
          emit(AuthNavigateFillIntrestesState());
        } else {
          CacheHelper.saveDate(
              key: ValuesManager.emailKey, value: ValuesManager.email);
          CacheHelper.saveDate(
              key: ValuesManager.imageKey, value: ValuesManager.imageUrl);
          CacheHelper.saveDate(
              key: ValuesManager.usernameKey, value: ValuesManager.username);
          CacheHelper.saveDate(
              key: ValuesManager.tokenKey, value: ValuesManager.tokenValue);
          emit(AuthLoginWithGoogleSuccess(''));
        }
      } else {
        emit(AuthLoginWithGoogleError(response.data['message']));
      }
    } catch (e) {
      print(e.toString());
      emit(AuthLoginWithGoogleError(e.toString()));
      return;
    }
  }

  Future<void> signInWithFacebook() async {
    emit(AuthLoginWithFacebookLoading());
    try {
      final fb = FacebookLogin();
// Log in
      final res = await fb.logIn(permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email,
      ]);
// Check result status
      switch (res.status) {
        case FacebookLoginStatus.success:
          // Logged in

          // Send access token to server for validation and auth
          final FacebookAccessToken accessToken = res.accessToken!;
          // print('Access token: ${accessToken.token}');
          // print(res.accessToken!.userId);

          // Get profile data
          final profile = await fb.getUserProfile();
          // print('Hello, ${profile!.name}! You ID: ${profile.userId}');
          final response = await authRepository.loginWithSocial(
              socialId: profile!.userId, username: profile.name!);
          print(response.data);
          if (response.data['status']) {
            CacheHelper.saveDate(
                key: ValuesManager.socialKey,
                value: SocialLogin.facebook.index);
            ValuesManager.tokenValue = response.data['RT'];
            ValuesManager.username =
                SecurityServices.decrypt(response.data['RC']['R1']);
            ValuesManager.email =
                SecurityServices.decrypt(response.data['RC']['R2']);
            ValuesManager.imageUrl =
                SecurityServices.decrypt(response.data['RC']['R5']);
            if (response.data['category'] == 0) {
              emit(AuthNavigateFillIntrestesState());
            } else {
              CacheHelper.saveDate(
                  key: ValuesManager.emailKey, value: ValuesManager.email);
              CacheHelper.saveDate(
                  key: ValuesManager.imageKey, value: ValuesManager.imageUrl);
              CacheHelper.saveDate(
                  key: ValuesManager.usernameKey,
                  value: ValuesManager.username);
              CacheHelper.saveDate(
                  key: ValuesManager.tokenKey, value: ValuesManager.tokenValue);
              emit(AuthLoginWithFacebookSuccess('LoginSuccessfully'));
            }
          }
          // Get user profile image url
          // final imageUrl = await fb.getProfileImageUrl(width: 100);
          // print('Your profile image: $imageUrl');

          // // Get email (since we request email permission)
          // final email = await fb.getUserEmail();
          // // But user can decline permission
          // if (email != null) print('And your email is $email');

          break;
        case FacebookLoginStatus.cancel:
          emit(AuthLoginWithFacebookError(FacebookLoginStatus.cancel.name));
          // User cancel log in
          break;
        case FacebookLoginStatus.error:
          // Log in failed
          emit(AuthLoginWithFacebookError('Error Happen When Login'));
          print('Error while log in: ${res.error}');
          break;
      }
    } catch (e) {
      emit(AuthLoginWithFacebookError('Error Happen When Login'));
    }
  }

  Future<void> changePassword(
      {required String password, required String newPassword}) async {
    emit(AuthChangePasswordLoading());
    try {
      final response = await authRepository.changePassword(
          password: password, newPassword: newPassword);
      if (response.data['status']) {
        emit(AuthChangePasswordSuccess(response.data['message']));
      } else {
        emit(AuthChangePasswordError(response.data['message']));
      }
    } catch (e) {
      emit(AuthChangePasswordError(e.toString()));
      return;
    }
  }

  Future<void> sendCodeForgetPassword({required String email}) async {
    emit(AuthForgetPasswordLoading());
    try {
      final response = await authRepository.forgetPassword(email: email);
      if (response.data['status']) {
        forgetPasswordEmail = email;
        emit(AuthForgetPasswordSuccess(response.data['message']));
      } else {
        emit(AuthForgetPasswordError(response.data['message']));
      }
    } catch (e) {
      emit(AuthForgetPasswordError(e.toString()));
      return;
    }
  }

  Future<void> newPasswordAfterForget(
      {required String code, required String password}) async {
    emit(AuthResetPasswordLoading());
    try {
      final response =
          await authRepository.resetPassword(code: code, password: password);
      if (response.data['status']) {
        emit(AuthResetPasswordSuccess(response.data['message']));
      } else {
        emit(AuthResetPasswordError(response.data['message']));
      }
    } catch (e) {
      emit(AuthResetPasswordError(e.toString()));
      return;
    }
  }

  void setForgetPasswordCode({required String code}) {
    forgetPasswordCode = code;
  }
}
