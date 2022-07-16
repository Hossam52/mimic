import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/models/challenge_models/challenge_model.dart';
import 'package:mimic/modules/home/widgets/black_opacity.dart';
import 'package:mimic/modules/home/widgets/images_builder.dart';
import 'package:mimic/presentation/resourses/assets_manager.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/dialogs.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/mimic_icons.dart';
import 'package:mimic/widgets/play_video_icon.dart';
import 'package:mimic/widgets/video_item.dart';
import 'package:mimic/widgets/video_statistic_item.dart';

class ChallenegItem extends StatelessWidget {
  const ChallenegItem(
      {Key? key,
      this.onChallengeTapped,
      required this.onJoinTapped,
      required this.challange})
      : super(key: key);
  final VoidCallback? onChallengeTapped;
  final Challange challange;
  final VoidCallback onJoinTapped;
  @override
  Widget build(BuildContext context) {
    final double joinIconHeight = 50.r;
    final halfButtonSize = joinIconHeight / 2;
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            // height: 250.h,
            child: GestureDetector(
              onTap: onChallengeTapped,
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      VideoOverview(challange: challange),
                      SizedBox(height: halfButtonSize)
                    ],
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: SizedBox(
                        height: joinIconHeight,
                        child: _joinButton(joinIconHeight, onJoinTapped)),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  challange.challangeTitle,
                  style: getBoldStyle(fontSize: FontSize.s14),
                ),
                if (challange.peopleJoined.length > 1)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.h),
                      Text(
                        '${challange.peopleJoined.length} ${AppStrings.peopleJoined}',
                        style: getRegularStyle(),
                      ),
                    ],
                  ),
                SizedBox(height: 8.h),
                SizedBox(
                    height: 60.h,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: ImagesBuilder(users: challange.peopleJoined),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _joinButton(double height, VoidCallback? onJoinTapped) {
    return Builder(builder: (context) {
      return CircleAvatar(
        radius: height,
        backgroundColor: ColorManager.visibilityColor,
        child: InkWell(
          onTap: onJoinTapped,
          child: Text(
            AppStrings.join,
            style:
                getBoldStyle(fontSize: FontSize.s14, color: ColorManager.white),
          ),
        ),
      );
    });
  }
}

class _ChallenegePreview extends StatelessWidget {
  const _ChallenegePreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          ImageAssets.videoPreview,
          width: double.infinity,
          fit: BoxFit.fill,
        ),
        const BlackOpacity(),
        PlayVideoIcon(size: 66.r),
        Align(
            alignment: Alignment.bottomLeft, child: _challengeActions(context)),
      ],
    );
  }

  Widget _challengeActions(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.r),
      child: Wrap(
        spacing: 10.w,
        children: [
          const FavoriteIcon(
            count: '12',
          ),
          CommentIcon(
            count: '15',
            onPressed: () {
              Dialogs.showCommentsDialog(context, 3);
            },
          ),
          const ViewIcon(count: '112'),
        ],
      ),
    );
  }
}
