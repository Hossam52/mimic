import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/widgets/shadow_box.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({Key? key, required this.searchTextHint})
      : super(key: key);
  final String searchTextHint;
  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(14.r)),
      borderSide: BorderSide.none,
    );
    return SizedBox(
      height: 45.h,
      child: ShadowBox(
        child: Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: ColorManager.grey,
                ),
          ),
          child: TextField(
            controller: TextEditingController(),
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
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.search,
                        size: 24.r,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        searchTextHint,
                        style: getRegularStyle(fontSize: FontSize.s10),
                      ),
                      SizedBox(width: 14.w),
                      VerticalDivider(
                        color: ColorManager.grey,
                        indent: 8.h,
                        endIndent: 8.h,
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
