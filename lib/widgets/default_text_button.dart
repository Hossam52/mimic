import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';

Widget defaultTextButton(
    {required Function onPressed,
    required String text,
    Color? buttonColor,
    Color? textColor,
    Color? borderColor}) {
  return SizedBox(
    height: 48.h,
    child: TextButton(
      onPressed: () {
        onPressed();
      },
      child:Text(text,style: getSemiBoldStyle(),),
      style: TextButton.styleFrom(
          shadowColor: Color(0xff575757),
          backgroundColor: buttonColor ?? Color(0xffEFEFEF),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
              side: BorderSide(color: borderColor ?? Color(0xffDCDCDC)))),
    ),
  );
}