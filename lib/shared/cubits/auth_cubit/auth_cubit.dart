import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mimic/presentation/resourses/values_manager.dart';
import 'package:mimic/shared/cubits/auth_cubit/auth_repository.dart';
import 'package:mimic/shared/network/locale/cache_helper.dart';
import 'package:mimic/shared/services/security_services.dart';
import 'package:google_sign_in/google_sign_in.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);
  AuthRepository authRepository = AuthRepository();
  String? email;
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
        emit(AuthRegisterError(response.data['message']));
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
        ValuesManager.imageUrl =
            SecurityServices.decrypt(response.data['RC']['R5']);
        ValuesManager.username =
            SecurityServices.decrypt(response.data['RC']['R1']);
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
      if (response.data['status']) {
        ValuesManager.tokenValue =
            response.data['RT'];
        ValuesManager.username = response.data['RC']['R1'];
        ValuesManager.imageUrl = response.data['RC']['R5'];
        CacheHelper.saveDate(
            key: ValuesManager.imageKey, value: ValuesManager.imageUrl);
        CacheHelper.saveDate(
            key: ValuesManager.usernameKey, value: ValuesManager.username);
        CacheHelper.saveDate(
            key: ValuesManager.tokenKey, value: ValuesManager.tokenValue);
        emit(AuthLoginSuccess(''));
      } else {
        emit(AuthLoginError(response.data['message']));
      }
    } catch (e) {
      emit(AuthLoginError(e.toString()));
      return;
    }
  }
  //auth with social

  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    emit(AuthLoginWithGoogleLoading());
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn(
      ).signIn(

      );
      print(googleUser!.id);
      print(googleUser.displayName);
      print(googleUser.email);
      final response = await authRepository.loginWithGoogle(
          socialId: googleUser.id, username: googleUser.displayName!);
      print(response.data);
      if (response.data['status']) {
        emit(AuthLoginWithGoogleSuccess(''));
      } else {
        emit(AuthLoginWithGoogleError(response.data['message']));
      }
    } catch (e) {
      print(e.toString());
      emit(AuthLoginWithGoogleError(e.toString()));
      return;
    }
  }
}
