import 'package:flutter/material.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';

AppBar defaultAppbar({required String title, Color? backgroundColr}) {
  return AppBar(
    elevation: 0,
    title: Text(
      title,
      style: getBoldStyle(),
    ),
    backgroundColor: backgroundColr,
    iconTheme: IconThemeData(color: ColorManager.black),
  );
}
