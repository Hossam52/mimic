import 'package:flutter/material.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';

Center buildTextError(String error) {
  return Center(
    child: Text(
      error,
      style: getMediumStyle(color: ColorManager.error),
    ),
  );
}
