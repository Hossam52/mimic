import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mimic/layout/search/search_users_cubit/search_users_cubit.dart';
import 'package:mimic/models/user_model/user.dart';
import 'package:mimic/modules/search/widgets/search_text_field.dart';
import 'package:mimic/presentation/resourses/assets_manager.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/presentation/resourses/values.dart';
import 'package:mimic/shared/helpers/error_handling/build_error_widget.dart';
import 'package:mimic/widgets/cached_network_image.dart';
import 'package:mimic/widgets/custom_nested_scroll_view.dart';
import 'package:mimic/widgets/loading_brogress.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/methods.dart';

class SearchPeople extends StatelessWidget {
  SearchPeople({Key? key}) : super(key: key);
  final TextEditingController controller = TextEditingController();
  late SearchUsersCubit searchUsersCubit;
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
                    onChanged: (String value) {
                      log(MediaQuery.of(context).viewInsets.bottom.toString());
                      if (MediaQuery.of(context).viewInsets.bottom != 0 &&
                          value.isNotEmpty) {
                        SearchUsersCubit.get(context).clear();
                        SearchUsersCubit.get(context)
                            .getPeopleUsingName(name: value);
                      }
                    },
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
          child: BlocBuilder<SearchUsersCubit, SearchUsersState>(
            builder: (context, state) {
              if (state is SearchUsersLoading && state.isFirst) {
                return const LoadingProgressSearchUsers();
              } else if (state is SearchUsersError &&
                  SearchUsersCubit.get(context).allUsers.isEmpty) {
                return BuildErrorWidget(state.error);
              } else {
                searchUsersCubit = SearchUsersCubit.get(context);
                return Column(
                  children: [
                    Expanded(child: _searchedPeople(searchUsersCubit)),
                    if (state is SearchUsersLoading) const LoadingProgress(),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _searchedPeople(SearchUsersCubit searchUsersCubit) {
    return searchUsersCubit.allUsers.isEmpty
        ? const BuildErrorWidget('No users available with this name')
        : GridView.builder(
            padding: EdgeInsets.zero,
            itemCount: searchUsersCubit.allUsers.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: AppSize.s18.h,
              childAspectRatio: 140.w / 200.h,
              crossAxisSpacing: AppSize.s25.w,
            ),
            itemBuilder: (_, index) {
              return _SearchedPersonItem(
                  user: searchUsersCubit.allUsers[index]);
            });
  }
}

class _SearchedPersonItem extends StatelessWidget {
  const _SearchedPersonItem({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(context, Routes.challengerProfile, arguments: user.id);
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
                  child: cachedNetworkImage(
                      imageUrl: user.image,
                      height: double.maxFinite,
                      width: double.maxFinite)),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.all(AppPadding.p8.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
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
