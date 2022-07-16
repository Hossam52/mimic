import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mimic/modules/search/widgets/search_text_field.dart';
import 'package:mimic/presentation/resourses/assets_manager.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/presentation/resourses/values.dart';
import 'package:mimic/widgets/custom_nested_scroll_view.dart';
import 'package:mimic/widgets/shadow_box.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/mimic_icons.dart';

class SearchPeople extends StatelessWidget {
  SearchPeople({Key? key}) : super(key: key);
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: AppPadding.p20.h),
      child: CustomNestedScrollView(
        headerWidgets: [
          Padding(
            padding: EdgeInsets.only(
                left: AppPadding.p16.w, right: AppPadding.p32.w),
            child: Row(
              children: [
                Expanded(
                  child: CustomSearchField(
                    searchTextHint: AppStrings.username,
                    controller: controller,
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(width: AppSize.s15.w),
                GestureDetector(
                    onTap: () {
                      navigateTo(context, Routes.scanQr);
                    },
                    child: SvgPicture.asset(
                      ImageAssets.qr,
                      width: AppSize.s30.w,
                      height: AppSize.s30.h,
                    )),
              ],
            ),
          ),
          SizedBox(height: AppSize.s25.h),
        ],
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.p28.w),
          child: _searchedPeople(),
        ),
      ),
    );
  }

  Widget _searchedPeople() {
    return GridView.builder(
        padding: EdgeInsets.zero,
        itemCount: 14,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: AppSize.s18.h,
          childAspectRatio: 140.w / 200.h,
          crossAxisSpacing: AppSize.s25.w,
        ),
        itemBuilder: (_, index) {
          return const _SearchedPersonItem();
        });
  }
}

class _SearchedPersonItem extends StatelessWidget {
  const _SearchedPersonItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(context, Routes.challengerProfile);
      },
      child: Card(
        elevation: 4,
        shadowColor: ColorManager.visibilityColor.withOpacity(0.6),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s12.r)),
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 6,
              child: SizedBox(
                  height: AppSize.s140.h,
                  child: Image.asset(
                    ImageAssets.avater,
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: double.infinity,
                  )),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.all(AppPadding.p8.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Maria Snow name',
                      style: getRegularStyle()
                          .copyWith(fontFamily: FontConstants.gibsonFamily),
                    ),
                    Expanded(
                      child: Center(
                        child: RatingBarIndicator(
                          itemBuilder: (_, index) {
                            return Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: AppSize.iconSize.r,
                            );
                          },
                          rating: 5,
                          itemCount: 5,
                          itemSize: AppSize.iconSize.r,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
