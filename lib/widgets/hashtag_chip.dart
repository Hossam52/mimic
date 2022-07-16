import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';

class HashtagChip extends StatelessWidget {
  const HashtagChip(
      {Key? key,
      required this.hashTagTitle,
      required this.selected,
      required this.onPressed})
      : super(key: key);
  final String hashTagTitle;
  final bool selected;
  final Function onPressed;
  //final Function onDeleted;

  @override
  Widget build(BuildContext context) {
    return RawChip(
      backgroundColor: ColorManager.white,
      selectedColor: ColorManager.primary,
      labelStyle: getBoldStyle(
          color: selected ? ColorManager.white : ColorManager.blue,
          fontSize: FontSize.s16),
      label: Text(
        '#' + hashTagTitle,
      ),
      selected: selected,
      onPressed: () {
        log('press');
        onPressed();
      },
      deleteIcon: const SizedBox(),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
      side: BorderSide(
        color: ColorManager.primary,
      ),
    );
  }
}
