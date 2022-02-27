import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/main.dart';
import 'package:mimic/modules/challenges/widgets/challenge_person_details.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/shared/dialogs.dart';
import 'package:mimic/widgets/person_details.dart';
import 'package:mimic/widgets/video_statistic_item.dart';
import 'package:mimic/modules/home/widgets/black_opacity.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/mimic_icons.dart';
import 'package:mimic/widgets/play_video_icon.dart';

class ChallengesGridView extends StatelessWidget {
  const ChallengesGridView(
      {Key? key,
      this.crossAxisCount = 2,
      required this.itemCount,
      this.showPlayIcon = true})
      : super(key: key);
  final bool showPlayIcon;
  final int crossAxisCount;
  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        primary: false,
        shrinkWrap: true,
        itemCount: itemCount,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20.w,
          crossAxisSpacing: 20.h,
          mainAxisExtent: 290.h,
        ),
        itemBuilder: (_, index) {
          return _ChallengeItemPreview(
            showPlayIcon: showPlayIcon,
          );
        });
  }
}

class _ChallengeItemPreview extends StatelessWidget {
  const _ChallengeItemPreview({Key? key, this.showPlayIcon = true})
      : super(key: key);
  final bool showPlayIcon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(context: context, builder: (_) => const _VideoPopup());
      },
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Image.asset(
                    getVideoImageRandom(),
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  const PersonDetails(),
                  if (showPlayIcon) const BlackOpacity(opacity: 0.4),
                  if (showPlayIcon) const Center(child: PlayVideoIcon()),
                ],
              ),
            ),
            _videoStatistics(context)
          ],
        ),
      ),
    );
  }

  Widget _videoStatistics(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Wrap(
        spacing: 10,
        children: [
          FavoriteIcon(
            count: '12',
            textColor: ColorManager.black,
          ),
          CommentIcon(
            count: '12',
            textColor: ColorManager.black,
            onPressed: () {
              Dialogs.showCommentsDialog(context);
            },
          ),
          ViewIcon(
            count: '12',
            iconColor: ColorManager.commentsColor,
            textColor: ColorManager.black,
          ),
        ],
      ),
    );
  }
}

class _VideoPopup extends StatelessWidget {
  const _VideoPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(16.w),
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(21.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _video(context),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 14.0.h, horizontal: 10.w),
            child: _statistics(context),
          ),
        ],
      ),
    );
  }

  Widget _video(context) {
    return SizedBox(
      height: 250.h,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Image.asset(getVideoImageRandom(),
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill),
          Center(
              child: PlayVideoIcon(
            size: 50.r,
          )),
          Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.volume_off_outlined,
                  color: ColorManager.white,
                  size: 25.r,
                ),
              )),
        ],
      ),
    );
  }

  Widget _statistics(BuildContext context) {
    return Wrap(
      spacing: 10.w,
      children: [
        FavoriteIcon(count: '12', textColor: ColorManager.black),
        CommentIcon(
          count: '19',
          textColor: ColorManager.black,
          onPressed: () {
            Dialogs.showCommentsDialog(context);
          },
        ),
        ViewIcon(
          count: '112',
          textColor: ColorManager.black,
          iconColor: ColorManager.commentsColor,
        ),
      ],
    );
  }
}
