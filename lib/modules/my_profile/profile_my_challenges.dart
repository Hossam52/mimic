import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/modules/home/widgets/black_opacity.dart';
import 'package:mimic/presentation/resourses/assets_manager.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/values.dart';
import 'package:mimic/shared/dialogs.dart';
import 'package:mimic/widgets/hashtag_item.dart';
import 'package:mimic/widgets/video_item.dart';
import 'package:mimic/widgets/video_statistic_item.dart';

class ProfileMyChallenges extends StatelessWidget {
  const ProfileMyChallenges({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (_, index) {
          return SizedBox(height: AppSize.s10.h);
        },
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (_, index) {
          return _MyChallengeItem(
            defaultIconColor: ColorManager.commentsColor,
          );
        });
  }
}

class _MyChallengeItem extends StatelessWidget {
  const _MyChallengeItem({Key? key, this.defaultIconColor}) : super(key: key);
  final Color? defaultIconColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190.h,
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(AppSize.s10.r)),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            ImageAssets.videoPreview,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
          const BlackOpacity(
            opacity: 0.37,
          ),
          Align(
              alignment: Alignment.bottomLeft,
              child: _challengeActions(context)),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0.h, horizontal: 26.w),
              child: HashtagItem(
                title: 'Volleyball',
                color: ColorManager.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _challengeActions(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(AppPadding.p8.r),
      child: Wrap(
        spacing: AppSize.s10.w,
        children: [
          const FavoriteIcon(
            count: '12',
          ),
          CommentIcon(
            count: '15',
            onPressed: () {
              Dialogs.showCommentsDialog(context,3);
            },
          ),
          ViewIcon(count: '112', iconColor: defaultIconColor),
        ],
      ),
    );
  }
}
