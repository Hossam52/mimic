import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/models/challenge_models/challenge_model.dart';
import 'package:mimic/models/user_model/user.dart';
import 'package:mimic/modules/home/widgets/black_opacity.dart';
import 'package:mimic/shared/video_players_widgets/video_play_test.dart';
import 'package:mimic/presentation/resourses/assets_manager.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/presentation/resourses/values.dart';
import 'package:mimic/widgets/hashtag_item.dart';
import 'package:mimic/widgets/play_video_icon.dart';

class MyChallengeItem extends StatelessWidget {
  const MyChallengeItem(
      {Key? key,
      this.stackItems = const [],
      this.displayBlackOpacity = true,
      required this.challange})
      : super(key: key);
  final List<Widget> stackItems;
  final bool displayBlackOpacity;
  final Challange challange;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: AppPadding.p20.h),
      child: SizedBox(
        height: 300.h,
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s8.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(AppPadding.p10.r),
            child: Column(
              children: [
                Row(
                  children: [
                    Center(child: _ChallengePerson(user: challange.creator)),
                    const Spacer(),
                    HashtagItem(title: challange.category),
                  ],
                ),
                SizedBox(
                  height: AppSize.s10.h,
                ),
                Expanded(
                    child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppSize.s8.r),
                  child: VideoItemPlayer(
                      video: challange.videoCreator,
                      controller: challange.videos),
                )
                    //  _Video(
                    //     stackItems: stackItems,
                    //     displayBlackOpacity: displayBlackOpacity)
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ChallengePerson extends StatelessWidget {
  const _ChallengePerson({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //  RoundedImage(imagePath: ImageAssets.avater, size: 27.w),
        CircleAvatar(
          backgroundImage: CachedNetworkImageProvider(user.image),
          radius: 23.w,
        ),
        SizedBox(width: 10.w),
        Text(
          user.name,
          style: getBoldStyle(fontSize: FontSize.s12),
        )
      ],
    );
  }
}

class _Video extends StatelessWidget {
  const _Video(
      {Key? key, required this.stackItems, required this.displayBlackOpacity})
      : super(key: key);
  final List<Widget> stackItems;
  final bool displayBlackOpacity;
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
          if (displayBlackOpacity) const BlackOpacity(opacity: 0.4),
          Align(alignment: Alignment.topLeft, child: _challengeNameAndTime()),
          ...stackItems,
          Align(
            child: PlayVideoIcon(size: AppSize.largeIconSize),
          )
        ],
      ),
    );
  }

  Widget _challengeNameAndTime() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: AppPadding.p10.h, horizontal: AppPadding.p4.w),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppStrings.challangeTitle,
              style: getSemiBoldStyle(
                  color: ColorManager.white, fontSize: FontSize.s10),
            ),
            Text(
              '2Min Ago',
              style: getRegularStyle(
                  color: ColorManager.timeAgo, fontSize: FontSize.s8),
            )
          ]),
    );
  }
}
