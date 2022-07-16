import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/modules/my_profile/profile_settings.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';

Widget defaultDropdownButton({
  required String title,
  String? value,
  required Function onChanged,
  required Function validator,
  required List<DropdownMenuItem<String>> items,
}) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(
      title,
      style: getSemiBoldStyle(),
    ),
    SizedBox(
      height: 4.h,
    ),
    Container(
      // height: 60.h,
      //padding: EdgeInsetsDirectional.only(start: 10.w, end: 5.w, bottom: 5.h),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        // border: Border.all(color: ColorManager.grey),
      ),
      constraints: BoxConstraints(minHeight: 60.h, maxHeight: 90.h),
      child: DropdownButtonFormField<String>(
          isExpanded: true,
          iconEnabledColor: Colors.black,
          decoration: const InputDecoration(),
          value: value,
          validator: (value) {
            return validator(value);
          },
          onChanged: (value) {
            onChanged(value);
          },
          hint: Text(
            title,
            style: getSemiBoldStyle(),
          ),

          //underline: const SizedBox(),
          items: items),
    )
  ]);
}

///
Widget defaultDropdownButtonWithIcon({
  required String title,
  String? value,
  required Function onChanged,
  required Function validator,
  required String imagePath,
  required List<DropdownMenuItem<String>> items,
}) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(
      title,
      style: getSemiBoldStyle(),
    ),
    SizedBox(
      height: 4.h,
    ),
    Container(
      // height: 60.h,
      //padding: EdgeInsetsDirectional.only(start: 10.w, end: 5.w, bottom: 5.h),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        // border: Border.all(color: ColorManager.grey),
      ),
      constraints: BoxConstraints(minHeight: 60.h, maxHeight: 90.h),
      child: DropdownButtonFormField<String>(
          isExpanded: true,
          iconEnabledColor: Colors.black,
          alignment: Alignment.centerLeft,
          icon: Icon(
            Icons.keyboard_arrow_right,
            size: 25.r,
          ),
          decoration: InputDecoration(
              labelText: title,
              labelStyle: getSemiBoldStyle(),
              prefixIcon: PrefixIconImage(svgImagePath: imagePath)),
          value: value,
          validator: (value) {
            return validator(value);
          },
          onChanged: (value) {
            onChanged(value);
          },
          // hint: Text(
          //   title,
          //   style: getSemiBoldStyle(),
          // ),

          //underline: const SizedBox(),
          items: items),
    )
  ]);
}
