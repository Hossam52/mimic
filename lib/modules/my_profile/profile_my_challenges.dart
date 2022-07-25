import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/models/challenge_models/challenge_model.dart';
import 'package:mimic/modules/home/widgets/black_opacity.dart';
import 'package:mimic/presentation/resourses/assets_manager.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/values.dart';
import 'package:mimic/shared/dialogs.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/cached_network_image.dart';
import 'package:mimic/widgets/hashtag_item.dart';
import 'package:mimic/widgets/video_statistic_item.dart';

import 'profile_cubit/profile_cubit.dart';

class ProfileMyChallenges extends StatelessWidget {
  const ProfileMyChallenges({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileCubit profileCubit = ProfileCubit.get(context);
    return ListView.separated(
        separatorBuilder: (_, index) {
          return SizedBox(height: AppSize.s10.h);
        },
        shrinkWrap: true,
        itemCount: profileCubit.challengesModel.challenges.data.length,
        itemBuilder: (_, index) {
          return _MyChallengeItem(
            defaultIconColor: ColorManager.commentsColor,
            challange: profileCubit.challengesModel.challenges.data[index],
          );
        });
  }
}

class _MyChallengeItem extends StatelessWidget {
  const _MyChallengeItem(
      {Key? key, this.defaultIconColor, required this.challange})
      : super(key: key);
  final Color? defaultIconColor;
  final Challange challange;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          navigateTo(context, Routes.challengeDetails, arguments: challange.id),
      child: Container(
        height: 190.h,
        width: double.infinity,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(AppSize.s10.r)),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          alignment: Alignment.center,
          children: [
            cachedNetworkImage(
                imageUrl: challange.videoCreator.thumNailUrl,
                height: double.infinity,
                width: double.infinity),
            // Image.asset(
            //   ImageAssets.videoPreview,
            //   width: double.infinity,
            //   height: double.infinity,
            //   fit: BoxFit.fill,
            // ),
            const BlackOpacity(
              opacity: 0.37,
            ),
            Align(
                alignment: Alignment.bottomLeft,
                child: _challengeActions(context)),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 20.0.h, horizontal: 26.w),
                child: HashtagItem(
                  title: challange.category,
                  color: ColorManager.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _challengeActions(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppPadding.p8.r),
      child: Wrap(
        spacing: AppSize.s10.w,
        children: [
          FavoriteIcon(
            count: challange.likesNumber.toString(),
          ),
          CommentIcon(
            count: challange.commentsNumber.toString(),
            // onPressed: () {
            //   Dialogs.showCommentsDialog(context, 3);
            // },
          ),
          ViewIcon(
              count: challange.views.toString(), iconColor: defaultIconColor),
        ],
      ),
    );
  }
}
