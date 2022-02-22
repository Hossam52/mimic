import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mimic/modules/search/widgets/search_text_field.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/widgets/shadow_box.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/mimic_icons.dart';

class SearchPeople extends StatelessWidget {
  const SearchPeople({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 35.w, top: 18.h),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: CustomSearchField(
                  searchTextHint: 'User_name',
                ),
              ),
              SizedBox(width: 15.h),
              GestureDetector(
                  onTap: () {
                    navigateTo(context, Routes.scanQr);
                  },
                  child: SvgPicture.asset(
                    'assets/images/qr.svg',
                    width: 30.w,
                    height: 30.h,
                  )),
            ],
          ),
          SizedBox(height: 25.h),
          Expanded(child: _searchedPeople()),
        ],
      ),
    );
  }

  Widget _searchedPeople() {
    return GridView.builder(
        padding: const EdgeInsets.all(0),
        itemCount: 14,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 18.h,
          childAspectRatio: 108.w / 200.h,
          crossAxisSpacing: 30.w,
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
    return Card(
      elevation: 4,
      shadowColor: ColorManager.visibilityColor.withOpacity(0.6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              height: 190.h,
              child: Image.asset(
                'assets/images/static/avatar.png',
                fit: BoxFit.fill,
                width: double.infinity,
                height: double.infinity,
              )),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Maria Snow',
                    style: getRegularStyle()
                        .copyWith(fontFamily: FontConstants.gibsonFamily),
                  ),
                  Expanded(
                    child: Center(
                      child: RatingBarIndicator(
                        itemBuilder: (_, index) {
                          return const Icon(Icons.star, color: Colors.amber);
                        },
                        rating: 5,
                        itemCount: 5,
                        itemSize: 16,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
