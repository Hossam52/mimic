import 'package:flutter/material.dart';
import 'package:mimic/modules/auth/login/login_screen.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoarding = "/onboarding";
  static const String login = "/login";
  static const String register = "/register";
  static const String main = "/main";
  static const String fogetPassword = "/forgetPassword";
}

class RouteGenerator {
  static Route<T> getRoute<T>(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

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
