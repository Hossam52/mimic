import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/presentation/resourses/values.dart';
import 'package:mimic/widgets/shadow_box.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField(
      {Key? key, required this.searchTextHint, required this.controller,required this.onChanged})
      : super(key: key);
  final String searchTextHint;
  final TextEditingController controller;
  final Function onChanged;
  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(14.r)),
      borderSide: BorderSide.none,
    );
    return SizedBox(
      height: AppSize.s45.h,
      child: ShadowBox(
        child: Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: ColorManager.grey,
                ),
          ),
          child: TextField(
            controller: controller,
            onChanged: (value)
            {
              onChanged(value);
            },
            textAlignVertical: TextAlignVertical.center,
            style: getRegularStyle(fontSize: FontSize.s18),
            decoration: InputDecoration.collapsed(
                    hintText: '',
                    filled: true,
                    fillColor: ColorManager.white,
                    border: InputBorder.none)
                .copyWith(
              focusColor: Colors.blue,
              focusedBorder: border,
              border: border,
              enabledBorder: border,
              disabledBorder: border,
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPadding.p8.w),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.search,
                        size: AppSize.iconSize,
                      ),
                      SizedBox(width: AppSize.s10.w),
                      Text(
                        searchTextHint,
                        style: getRegularStyle(fontSize: FontSize.s10),
                      ),
                      SizedBox(width: 14.w),
                      VerticalDivider(
                        color: ColorManager.grey,
                        indent: AppSize.s8.h,
                        endIndent: AppSize.s8.h,
                        thickness: 1,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
