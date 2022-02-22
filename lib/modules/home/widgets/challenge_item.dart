import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/modules/home/widgets/black_opacity.dart';
import 'package:mimic/modules/home/widgets/images_builder.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/dialogs.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/mimic_icons.dart';
import 'package:mimic/widgets/play_video_icon.dart';
import 'package:mimic/widgets/video_item.dart';
import 'package:mimic/widgets/video_statistic_item.dart';

class ChallenegItem extends StatelessWidget {
  const ChallenegItem(
      {Key? key, this.onChallengeTapped, required this.onJoinTapped})
      : super(key: key);
  final VoidCallback? onChallengeTapped;
  final VoidCallback onJoinTapped;
  @override
  Widget build(BuildContext context) {
    final double joinIconHeight = 50;
    final halfButtonSize = joinIconHeight / 2;
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            // height: 220.h,
            child: GestureDetector(
              onTap: onChallengeTapped,
              child: Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      VideoOverview(),
                      SizedBox(height: halfButtonSize)
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
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
                  'Sports challenge details',
                  style: getBoldStyle(fontSize: FontSize.s14),
                ),
                SizedBox(height: 8.h),
                Text(
                  '12 People joined',
                  style: getRegularStyle(),
                ),
                SizedBox(height: 8.h),
                SizedBox(
                    height: 60.h,
                    child: const Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: ImagesBuilder(imagesCount: 7),
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
            'Join',
            style:
                getBoldStyle(fontSize: FontSize.s18, color: ColorManager.white),
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
          'assets/images/static/video_preview.png',
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
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 10,
        children: [
          const FavoriteIcon(
            count: '12',
          ),
          CommentIcon(
            count: '15',
            onPressed: () {
              Dialogs.showCommentsDialog(context);
            },
          ),
          const ViewIcon(count: '112'),
        ],
      ),
    );
  }
}
