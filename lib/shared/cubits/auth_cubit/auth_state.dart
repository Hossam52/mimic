part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthRegisterLoading extends AuthState {}

class AuthRegisterSuccess extends AuthState {}

class AuthRegisterError extends AuthState {
  final String message;
  AuthRegisterError(this.message);
}

class AuthActiviteLoading extends AuthState {}

class AuthActiviteSuccess extends AuthState {}

class AuthActiviteError extends AuthState {
  final String message;
  AuthActiviteError(this.message);
}

class AuthResendCodeLoading extends AuthState {}

class AuthResendCodeSuccess extends AuthState {
  final String message;
  AuthResendCodeSuccess(this.message);
}

class AuthResendCodeError extends AuthState {
  final String message;
  AuthResendCodeError(this.message);
}
class AuthLoginLoading extends AuthState {}

class AuthLoginSuccess extends AuthState 
{
  final String message;
  AuthLoginSuccess(this.message);
}

class AuthLoginError extends AuthState {
  final String message;
  AuthLoginError(this.message);
}
class AuthNavigateFillIntrestesState extends AuthState
{}
class AuthNavigateToVerifiyState extends AuthState
{}
//auth social google
class AuthLoginWithGoogleLoading extends AuthState {}

class AuthLoginWithGoogleSuccess extends AuthState 
{
  final String message;
  AuthLoginWithGoogleSuccess(this.message);
}

class AuthLoginWithGoogleError extends AuthState {
  final String message;
  AuthLoginWithGoogleError(this.message);
}
//auth social facebook
class AuthLoginWithFacebookLoading extends AuthState {}

class AuthLoginWithFacebookSuccess extends AuthState 
{
  final String message;
  AuthLoginWithFacebookSuccess(this.message);
}

class AuthLoginWithFacebookError extends AuthState {
  final String message;
  AuthLoginWithFacebookError(this.message);
}
//change password 
class AuthChangePasswordLoading extends AuthState {}

class AuthChangePasswordSuccess extends AuthState 
{
  final String message;
  AuthChangePasswordSuccess(this.message);
}

class AuthChangePasswordError extends AuthState {
  final String message;
  AuthChangePasswordError(this.message);
}
///forget password
class AuthForgetPasswordLoading extends AuthState {}

class AuthForgetPasswordSuccess extends AuthState 
{
  final String message;
  AuthForgetPasswordSuccess(this.message);
}

class AuthForgetPasswordError extends AuthState {
  final String message;
  AuthForgetPasswordError(this.message);
}
//reset password
class AuthResetPasswordLoading extends AuthState {}

class AuthResetPasswordSuccess extends AuthState 
{
  final String message;
  AuthResetPasswordSuccess(this.message);
}

class AuthResetPasswordError extends AuthState {
  final String message;
  AuthResetPasswordError(this.message);
}
