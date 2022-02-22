import 'package:flutter/material.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/widgets/custom_drop_down.dart';
import 'package:mimic/widgets/shadow_box.dart';

class AllCategoriesDropDown extends StatefulWidget {
  const AllCategoriesDropDown({Key? key}) : super(key: key);

  @override
  _AllCategoriesDropDownState createState() => _AllCategoriesDropDownState();
}

class _AllCategoriesDropDownState extends State<AllCategoriesDropDown> {
  String? selectedVal;
  @override
  Widget build(BuildContext context) {
    return ShadowBox(
      shadow: 12,
      child: SizedBox(
        width: double.infinity,
        child: CustomDropDown(
          child: DropdownButton<String>(
            elevation: 10,
            iconEnabledColor: ColorManager.visibilityColor,
            icon: const Icon(Icons.keyboard_arrow_down),
            focusColor: ColorManager.white,
            value: selectedVal,
            hint: Text(
              'All Categories',
              style: getRegularStyle(),
            ),
            items: [
              DropdownMenuItem(
                value: '1',
                child: Text(
                  'Music',
                  style: getRegularStyle(fontSize: FontSize.s16),
                ),
              ),
              DropdownMenuItem(
                value: '2',
                child: Text(
                  'Music',
                  style: getRegularStyle(fontSize: FontSize.s16),
                ),
              ),
              DropdownMenuItem(
                value: '3',
                child: Text(
                  'Volley ball',
                  style: getRegularStyle(fontSize: FontSize.s16),
                ),
              ),
              DropdownMenuItem(
                value: '4',
                child: Text(
                  'Football',
                  style: getRegularStyle(fontSize: FontSize.s16),
                ),
              ),
            ],
            onChanged: (val) {
              setState(() {
                selectedVal = val;
              });
            },
          ),
        ),
      ),
    );
  }
}
