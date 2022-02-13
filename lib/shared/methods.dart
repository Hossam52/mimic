import 'package:flutter/material.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';

MaterialStateProperty<T> getMaterialStateProperty<T>(T value) {
  return MaterialStateProperty.all(value);
}

Future<T?> navigateTo<T>(BuildContext context, String routeName) async {
  return Navigator.of(context).push<T>(
      RouteGenerator.getRoute<T>(const RouteSettings(name: Routes.login)));
}

Future<T?> navigateReplacement<T>(
    BuildContext context, String routeName) async {
  return Navigator.of(context).pushReplacement(
      RouteGenerator.getRoute<T>(const RouteSettings(name: Routes.login)));
}

double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}
