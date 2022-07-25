
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
import 'package:mimic/shared/helpers/error_handling/build_error_widget.dart';
import 'package:mimic/widgets/loading_brogress.dart';
import 'package:mimic/widgets/play_video_icon.dart';
import 'package:mimic/widgets/rounded_image.dart';

class ApprovedChallenges extends StatelessWidget {
  const ApprovedChallenges({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyChallengesCubit, MyChallengesStateState>(
      builder: (context, state) {
        if (state is ErrorMyChallengesCubit) {
          return BuildErrorWidget(state.error);
        } 
        else if (state is SuccessMyChallengesCubit) {
          return Padding(
            padding: EdgeInsets.only(top: AppPadding.p20.h),
            child: Column(
              children: [
                const AllCategoriesDropDown(),
                SizedBox(height: AppSize.s20.h),
                Expanded(
                    child: _requestsListView(
                        MyChallengesCubit.instance(context).challanges)),
              ],
            ),
          );
        } else {
          return const LoadingProgress();
        }
      },
    );
  }

  Widget _requestsListView(Set<Challange> challanges) {
    // log('length ${challanges.length}');
    return ListView.builder(
        itemCount: challanges.length,
        shrinkWrap: true,
        itemBuilder: (_, index) {
          return MyChallengeItem(
            displayBlackOpacity: index != 0,
            challange: challanges.elementAt(index),
          );
        });
  }
}

class _ApprovedItem extends StatelessWidget {
  const _ApprovedItem({Key? key, this.remaining = false}) : super(key: key);
  final bool remaining;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: SizedBox(
        height: 270.h,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s8.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(AppPadding.p10.r),
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
                Expanded(
                    child: _Video(
                  remaining: remaining,
                )),
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
  const _Video({Key? key, this.remaining = false}) : super(key: key);
  final bool remaining;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.symmetric(vertical: AppMargin.m10.h),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.r)),
      child: Stack(
        children: [
          Image.asset(
            ImageAssets.videoPreview,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
          if (remaining) const BlackOpacity(opacity: 0.4),
          Align(alignment: Alignment.topLeft, child: _challengeNameAndTime()),
          if (remaining)
            Align(alignment: Alignment.bottomLeft, child: _remainingTime()),
          Align(child: PlayVideoIcon(size: AppSize.largeIconSize))
        ],
      ),
    );
  }

  Widget _challengeNameAndTime() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: AppPadding.p8.h, horizontal: AppPadding.p4.w),
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
      padding: EdgeInsets.all(AppPadding.p8.r),
      child: Text(
        '2 days, 10 hours, 12 min',
        style: getBoldStyle(fontSize: FontSize.s14, color: ColorManager.white),
      ),
    );
  }
}
