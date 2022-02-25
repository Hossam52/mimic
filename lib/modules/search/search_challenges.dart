import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/modules/search/widgets/search_text_field.dart';
import 'package:mimic/widgets/custom_drop_down.dart';
import 'package:mimic/widgets/custom_nested_scroll_view.dart';
import 'package:mimic/widgets/person_details.dart';
import 'package:mimic/widgets/shadow_box.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/widgets/rounded_image.dart';

class SearchChallenges extends StatelessWidget {
  const SearchChallenges({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0.h).copyWith(bottom: 0),
      child: CustomNestedScrollView(
        headerWidgets: [
          const CustomSearchField(
            searchTextHint: 'Challenge title',
          ),
          SizedBox(height: 15.h),
          Row(
            children: [
              const Expanded(child: _CategoryDropDown()),
              SizedBox(width: 20.w),
              const Expanded(child: _CategoryDatePublished()),
            ],
          ),
          SizedBox(height: 60.h),
        ],
        body: _searchedChallenges(),
      ),
    );
  }

  Widget _searchedChallenges() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: ShadowBox(
        radius: 12.r,
        shadow: 0,
        child: GridView.builder(
            itemCount: 14,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                // mainAxisExtent: 260.h,
                childAspectRatio: 140.w / 210.h,
                mainAxisSpacing: 20.h,
                crossAxisSpacing: 20.w),
            itemBuilder: (_, index) {
              return const _SearchedChallengeItem();
            }),
      ),
    );
  }
}

class _CategoryDropDown extends StatelessWidget {
  const _CategoryDropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShadowBox(
      child: CustomDropDown(
        child: DropdownButton<String>(
          icon: Icon(Icons.keyboard_arrow_down,
              size: 25.r, color: ColorManager.commentsColor),
          hint: Text(
            'Category',
            style: getRegularStyle(),
          ),
          items: [
            DropdownMenuItem(
              value: '1',
              child: Text(
                'Category1',
                style: getRegularStyle(),
              ),
            ),
            DropdownMenuItem(
              value: '2',
              child: Text(
                'Category2',
                style: getRegularStyle(),
              ),
            ),
          ],
          onChanged: (val) {},
        ),
      ),
    );
  }
}

class _CategoryDatePublished extends StatelessWidget {
  const _CategoryDatePublished({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShadowBox(
      child: CustomDropDown(
        child: DropdownButton<String>(
          icon: Icon(Icons.keyboard_arrow_down,
              size: 25.r, color: ColorManager.commentsColor),
          hint: Text(
            'Date published',
            style: getRegularStyle(),
          ),
          items: [
            DropdownMenuItem(
              value: '1',
              child: Text(
                '2022',
                style: getRegularStyle(),
              ),
            ),
            DropdownMenuItem(
              value: '2',
              child: Text(
                '2021',
                style: getRegularStyle(),
              ),
            ),
          ],
          onChanged: (val) {},
        ),
      ),
    );
  }
}

class _SearchedChallengeItem extends StatelessWidget {
  const _SearchedChallengeItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          PersonNameAndImage(
            textColor: ColorManager.black,
            nameSize: FontSize.s10,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.h),
              child: Image.asset(
                _paths[Random.secure().nextInt(_paths.length)],
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final _paths = [
  'assets/images/static/discover/discover_challenge_person1.png',
  'assets/images/static/discover/discover_challenge_person2.png',
];
