import 'package:flutter/material.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/cubits/categories_cubit/categories_cubit.dart';
import 'package:mimic/widgets/custom_drop_down.dart';
import 'package:mimic/widgets/shadow_box.dart';

class AllCategoriesDropDown extends StatefulWidget {
  const AllCategoriesDropDown({Key? key, required this.onChange})
      : super(key: key);
  final Function onChange;

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
          child: DropdownButtonFormField<String>(
            elevation: 10,
            iconEnabledColor: ColorManager.visibilityColor,
            icon: const Icon(Icons.keyboard_arrow_down),
            focusColor: ColorManager.white,
            value: selectedVal,
            hint: Text(
              AppStrings.allCategories,
              style: getRegularStyle(),
            ),
            items: CategoriesCubit.get(context).categoriesModel == null
                ? []
                : CategoriesCubit.get(context)
                    .categoriesModel
                    .categories
                    .categories
                    .map((e) => DropdownMenuItem(
                          child: Text(
                            e.name,
                            style: getRegularStyle(),
                          ),
                          value: e.id,
                          onTap: () {},
                        ))
                    .toList(),
            onChanged: (val) {
              widget.onChange(val);
            },
          ),
        ),
      ),
    );
  }
}
