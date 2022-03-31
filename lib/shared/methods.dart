import 'package:flutter/material.dart';
import 'package:mimic/modules/comments/comments_screen.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';

MaterialStateProperty<T> getMaterialStateProperty<T>(T value) {
  return MaterialStateProperty.all(value);
}

Future<T?> navigateTo<T>(BuildContext context, String? routeName,
    {Object? arguments}) async {
  return await Navigator.of(context).push<T>(RouteGenerator.getRoute<T>(
      RouteSettings(name: routeName, arguments: arguments)));
}
void navigateToWithoutNaming(BuildContext context,Widget screen)
{
  Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
}

Future<T?> navigateAndFinish<T>(BuildContext context, String? routeName,
    {Object? arguments}) async {
  return Navigator.of(context).pushAndRemoveUntil(
      RouteGenerator.getRoute<T>(
          RouteSettings(name: routeName, arguments: arguments)),
      (route) => false);
}

Future<T?> navigateReplacement<T>(
    BuildContext context, String? routeName) async {
  return Navigator.of(context).pushReplacement(
      RouteGenerator.getRoute<T>(RouteSettings(name: routeName)));
}

double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}
