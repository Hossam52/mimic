import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/values.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    // final border =
    return SizedBox(
      height: AppSize.s45.h,
      child: InputDecorator(
        decoration: const InputDecoration.collapsed(hintText: '').copyWith(
          fillColor: ColorManager.white,
          contentPadding:  EdgeInsets.symmetric(horizontal: AppPadding.p8.w),
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(AppSize.s10.r),
          ),
        ),
        child: DropdownButtonHideUnderline(child: child),
      ),
    );
  }
}
