
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/layout/search/search_challanges_cubit/search_challanges_cubit.dart';
import 'package:mimic/models/challenge_models/challenge_model.dart';
import 'package:mimic/models/enums/period_chllanges.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/presentation/resourses/values.dart';
import 'package:mimic/shared/cubits/categories_cubit/categories_cubit.dart';
import 'package:mimic/shared/extentions/translate_word.dart';
import 'package:mimic/shared/helpers/error_handling/build_error_widget.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/cached_network_image.dart';
import 'package:mimic/widgets/custom_drop_down.dart';
import 'package:mimic/widgets/custom_nested_scroll_view.dart';
import 'package:mimic/widgets/loading_brogress.dart';
import 'package:mimic/widgets/person_details.dart';
import 'package:mimic/widgets/shadow_box.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';

class SearchChallenges extends StatelessWidget {
  SearchChallenges({Key? key}) : super(key: key);
  late SearchChallangesCubit searchChallangesCubit;
  int? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppPadding.p16.h).copyWith(bottom: 0),
      child: BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state) {
          if (state is CategoriesLoading) {
            return const LoadingProgressSearchChallanges();
          } else if (state is CategoriesError) {
            return BuildErrorWidget(state.message);
          }

          return CustomNestedScrollView(
            headerWidgets: [
              //  CustomSearchField(
              //   searchTextHint: AppStrings.challangeTitle,
              // ),
              SizedBox(height: AppSize.s15.h),
              Row(
                children: [
                  Expanded(child: _CategoryDropDown(
                    onChange: (value) {
                      selectedValue = int.parse(value);
                      SearchChallangesCubit.get(context)
                          .setCategory(selectedValue!);
                      SearchChallangesCubit.get(context).searchOnChallanges();
                    },
                  )),
                  SizedBox(width: AppSize.s20.w),
                  Expanded(child: _CategoryDatePublished(
                    onChangePeriod: (int val) {
                      SearchChallangesCubit.get(context).setPeriod(val);
                      SearchChallangesCubit.get(context).searchOnChallanges();
                    },
                  )),
                ],
              ),
              SizedBox(height: AppSize.s60.h),
            ],
            body: BlocBuilder<SearchChallangesCubit, SearchChallangesState>(
              builder: (context, state) {
                if (state is SearchChallangesLoading && state.isFirst) {
                  return const LoadingProgressSearchChallanges();
                } else if (state is SearchChallangesError &&
                    SearchChallangesCubit.get(context).allChallanges.isEmpty) {
                  return BuildErrorWidget(state.error);
                } else {
                  searchChallangesCubit = SearchChallangesCubit.get(context);
                  return Column(
                    children: [
                      Expanded(
                          child: _searchedChallenges(searchChallangesCubit)),
                      if (state is SearchChallangesLoading)
                        const LoadingProgress(),
                    ],
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }

  Widget _searchedChallenges(SearchChallangesCubit searchChallangesCubit) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.p16.w),
      child: ShadowBox(
        radius: AppSize.s12.r,
        shadow: 0,
        child: GridView.builder(
            itemCount: searchChallangesCubit.allChallanges.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                // mainAxisExtent: 260.h,
                childAspectRatio: 140.w / 210.h,
                mainAxisSpacing: AppSize.s20.h,
                crossAxisSpacing: AppSize.s20.w),
            itemBuilder: (_, index) {
              return _SearchedChallengeItem(
                challange: searchChallangesCubit.allChallanges[index],
              );
            }),
      ),
    );
  }
}

class _CategoryDropDown extends StatelessWidget {
  const _CategoryDropDown({Key? key, required this.onChange}) : super(key: key);
  final Function onChange;
  @override
  Widget build(BuildContext context) {
    return ShadowBox(
      child: CustomDropDown(
        child: DropdownButtonFormField<String>(
          // ignore: prefer_null_aware_operators
          value: SearchChallangesCubit.get(context).selectedCategoryId == null
              ? null
              : SearchChallangesCubit.get(context)
                  .selectedCategoryId
                  .toString(),
          dropdownColor: ColorManager.white,
          decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: ColorManager.white,
          ),
          icon: Icon(Icons.keyboard_arrow_down,
              size: AppSize.iconSize, color: ColorManager.commentsColor),
          hint: Text(
            AppStrings.category.translateString(context),
            style: getRegularStyle(),
          ),
          items: CategoriesCubit.get(context)
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
            onChange(val);
          },
        ),
      ),
    );
  }
}

class _CategoryDatePublished extends StatelessWidget {
  const _CategoryDatePublished({Key? key, required this.onChangePeriod})
      : super(key: key);
  final Function onChangePeriod;
  @override
  Widget build(BuildContext context) {
    return ShadowBox(
      child: CustomDropDown(
        child: DropdownButtonFormField<int>(
          icon: Icon(Icons.keyboard_arrow_down,
              size: AppSize.iconSize.r, color: ColorManager.commentsColor),
          hint: Text(
            AppStrings.datePublished.translateString(context),
            style: getRegularStyle(),
          ),
          items: PeriodChallanges.values
              .map(
                (e) => DropdownMenuItem(
                  value: e.index,
                  child: Text(
                    e.name.translateString(context),
                    style: getRegularStyle(),
                  ),
                ),
              )
              .toList(),
          value: SearchChallangesCubit.get(context).selectedPeriod,
          onChanged: (val) {
            onChangePeriod(val);
          },
        ),
      ),
    );
  }
}

class _SearchedChallengeItem extends StatelessWidget {
  const _SearchedChallengeItem({Key? key, required this.challange})
      : super(key: key);
  final Challange challange;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12.r)),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          navigateTo(context, Routes.challengeDetails, arguments: challange.id);
        },
        child: Column(
          children: [
            PersonNameAndImageCreator(
              textColor: ColorManager.black,
              nameSize: FontSize.s10,
              image: challange.creator.image,
              name: challange.creator.name,
            ),
            Expanded(
              child: cachedNetworkImage(
                imageUrl: challange.videoCreator.thumNailUrl,
                height: double.maxFinite,
                width: double.maxFinite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final _paths = [
  'assets/images/static/discover/discover_challenge_person1.png',
  'assets/images/static/discover/discover_challenge_person2.png',
];
