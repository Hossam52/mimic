import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/layout/my_challenges/cubit/my_challenges_cubit.dart';
import 'package:mimic/layout/my_challenges/cubit/my_challenges_states.dart';
import 'package:mimic/models/challenge_models/challenge_model.dart';
import 'package:mimic/modules/home/widgets/black_opacity.dart';
import 'package:mimic/modules/my_challenges/widgets/all_categories_drop_down.dart';
import 'package:mimic/modules/my_challenges/widgets/my_challenge_item.dart';
import 'package:mimic/presentation/resourses/assets_manager.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/presentation/resourses/values.dart';
import 'package:mimic/shared/cubits/categories_cubit/categories_cubit.dart';
import 'package:mimic/shared/helpers/error_handling/build_error_widget.dart';
import 'package:mimic/widgets/loading_brogress.dart';
import 'package:mimic/widgets/play_video_icon.dart';
import 'package:mimic/widgets/rounded_image.dart';

class NewChallengeRequests extends StatelessWidget {
  NewChallengeRequests({Key? key}) : super(key: key);
  int? selectedCategory;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: AppPadding.p20.h),
      child: BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state) {
          if (state is CategoriesLoading) {
            return const LoadingProgress();
          } else if (state is CategoriesSuccess) {
            return Column(
              children: [
                AllCategoriesDropDown(
                  onChange: (value) {
                    selectedCategory = int.parse(value);
                    MyChallengesCubit.instance(context)
                        .getMyChallengesFilterd(categoryId: int.parse(value));
                  },
                ),
                SizedBox(height: AppSize.s20.h),
                Expanded(child:
                    BlocBuilder<MyChallengesCubit, MyChallengesStateState>(
                  builder: (context, state) {
                    if (state is ErrorMyChallengesCubit) {
                      return BuildErrorWidget(state.error);
                    } else if (state is SuccessMyChallengesCubit) {
                      return _requestsListView(
                          MyChallengesCubit.instance(context).challanges,
                          onRefresh: () {
                        selectedCategory = null;
                        //CategoriesCubit.get(context).rebuildUI();
                        MyChallengesCubit.instance(context)
                            .getMyChallengesFilterd();
                      });
                    } else {
                      return const LoadingProgress();
                    }
                  },
                )),
              ],
            );
          } else if (state is CategoriesError) {
            return BuildErrorWidget(state.message);
          }
          return const LoadingProgress();
        },
      ),
    );
  }

  Widget _requestsListView(Set<Challange> challanges,
      {required Function onRefresh}) {
    return RefreshIndicator(
      onRefresh: () async {
        onRefresh();
      },
      child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: challanges.length,
          shrinkWrap: true,
          itemBuilder: (_, index) {
            return MyChallengeItem(
                challange: challanges.elementAt(index),
                stackItems: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.all(8.r),
                      child: Text(
                        '2 days, 10 hours, 12 min',
                        style: getBoldStyle(
                            fontSize: FontSize.s12, color: ColorManager.white),
                      ),
                    ),
                  ),
                ]);
          }),
    );
  }
}

class _RequestItem extends StatelessWidget {
  const _RequestItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: SizedBox(
        height: 270.h,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(10.r),
            child: Column(
              children: [
                Row(
                  children: [
                    const Center(child: _ChallengePerson()),
                    const Spacer(),
                    Text(
                      '#Music',
                      style: getBoldStyle(
                        color: ColorManager.visibilityColor,
                      ),
                    )
                  ],
                ),
                const Expanded(child: _Video()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ChallengePerson extends StatelessWidget {
  const _ChallengePerson({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RoundedImage(imagePath: ImageAssets.avater, size: 27.w),
        SizedBox(width: 10.w),
        Text(
          'Rahma Ahmed',
          style: getBoldStyle(fontSize: FontSize.s14),
        )
      ],
    );
  }
}

class _Video extends StatelessWidget {
  const _Video({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.r)),
      child: Stack(
        children: [
          Image.asset(
            ImageAssets.videoPreview,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
          const BlackOpacity(opacity: 0.4),
          Align(alignment: Alignment.topLeft, child: _challengeNameAndTime()),
          Align(alignment: Alignment.bottomLeft, child: _remainingTime()),
          Align(
            child: PlayVideoIcon(
              size: 40.w,
            ),
          )
        ],
      ),
    );
  }

  Widget _challengeNameAndTime() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppStrings.challangeTitle,
              style: getSemiBoldStyle(color: ColorManager.white),
            ),
            Text(
              '2Min Ago',
              style: getRegularStyle(color: ColorManager.timeAgo),
            )
          ]),
    );
  }

  Widget _remainingTime() {
    return Padding(
      padding: EdgeInsets.all(8.0.r),
      child: Text(
        '2 days, 10 hours, 12 min',
        style: getBoldStyle(fontSize: FontSize.s14, color: ColorManager.white),
      ),
    );
  }
}
