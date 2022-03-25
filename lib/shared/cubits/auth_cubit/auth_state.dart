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
