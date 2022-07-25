import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/models/challenge_models/challenge_model.dart';
import 'package:mimic/modules/home/widgets/black_opacity.dart';
import 'package:mimic/widgets/cached_network_image.dart';
import 'package:mimic/shared/dialogs.dart';
import 'package:mimic/widgets/play_video_icon.dart';
import 'package:mimic/widgets/video_statistic_item.dart';

class VideoOverview extends StatelessWidget {
  const VideoOverview(
      {Key? key,
      this.defaultIconColor,
      this.borderRadius,
      required this.challange})
      : super(key: key);
  final Challange challange;
  final Color? defaultIconColor;
  final double? borderRadius;
  @override
  Widget build(BuildContext context) {
    log('thumbnail :' + challange.videoCreator.thumNailUrl);
    return Container(
      height: 200.h,
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 6.r)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // const VideoPlayTest(),
          // Image.asset(
          //   getVideoImageRandom(),
          //   width: double.infinity,
          //   height: double.infinity,
          //   fit: BoxFit.fill,
          // ),
          cachedNetworkImage(
              imageUrl: challange.videoCreator.thumNailUrl,
              height: 200.h,
              width: double.maxFinite),
          const BlackOpacity(
            opacity: 0.37,
          ),
          PlayVideoIcon(size: 66.r),
          //  const Align(alignment: Alignment.topLeft, child: PersonDetails()),
          Align(
              alignment: AlignmentDirectional.bottomStart,
              child: _challengeActions(context, challange)),
        ],
      ),
    );
  }

  Widget _challengeActions(BuildContext context, Challange challange) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 10.w,
        children: [
          FavoriteIcon(
            count: challange.likesNumber.toString(),
          ),
          CommentIcon(
            count: challange.commentsNumber.toString(),
            onPressed: () {
              Dialogs.showCommentsDialog(context,3);
            },
          ),
          ViewIcon(
              count: challange.views.toString(), iconColor: defaultIconColor),
        ],
      ),
    );
  }
}
