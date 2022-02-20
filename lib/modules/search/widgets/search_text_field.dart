import 'package:flutter/material.dart';
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
    const border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(50)),
      borderSide: BorderSide.none,
    );
    return ShadowBox(
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
                    const Icon(Icons.search),
                    Text(
                      searchTextHint,
                      style: getRegularStyle(fontSize: FontSize.s16),
                    ),
                    VerticalDivider(
                      color: ColorManager.grey,
                      thickness: 1,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
