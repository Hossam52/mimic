import 'package:flutter/material.dart';
import 'package:mimic/modules/auth/forgot_password/new_password_screen.dart';
import 'package:mimic/modules/auth/forgot_password/forgot_password.dart';
import 'package:mimic/modules/auth/login/login_screen.dart';
import 'package:mimic/modules/auth/register/interests/interests_screen.dart';
import 'package:mimic/modules/auth/register/register_screen.dart';
import 'package:mimic/modules/auth/register/register_virefy_email.dart';
import 'package:mimic/modules/auth/register/terms_conditions/privacy_policy_screen.dart';
import 'package:mimic/modules/home/home_screen.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoarding = "/onboarding";
  static const String login = "/login";
  static const String newPassword = "/new_password";
  static const String register = "/register";
  static const String registerVerifyEmail = "/register_verify_email";
  static const String interests = "/interests";
  static const String privacyPolicy = "/privacy_policy";
  static const String main = "/main";
  static const String forgetPassword = "/forget_password";
}

class RouteGenerator {
  static Route<T> getRoute<T>(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.forgetPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case Routes.newPassword:
        return MaterialPageRoute(builder: (_) => const NewPasswordScreen());
      case Routes.register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case Routes.registerVerifyEmail:
        return MaterialPageRoute(
            builder: (_) => const RegisterVerifyEmailScreen());
      case Routes.interests:
        return MaterialPageRoute(builder: (_) => const InterestsScreen());
      case Routes.privacyPolicy:
        return MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen());
      case Routes.main:
        return MaterialPageRoute(builder: (_) => HomeScreen());

      default:
        return unDefinedRoute();
    }
  }

  static Route<T> unDefinedRoute<T>() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.noRouteFound),
        ),
        body: const Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}
