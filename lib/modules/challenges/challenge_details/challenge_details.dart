import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/modules/challenges/widgets/challenge_person_details.dart';
import 'package:mimic/modules/challenges/widgets/challenge_title_and_discription.dart';
import 'package:mimic/modules/challenges/widgets/challenges_grid_view.dart';
import 'package:mimic/modules/challenges/widgets/report_popup_menu_button.dart';
import 'package:mimic/modules/challenges/widgets/transparent_app_bar.dart';
import 'package:mimic/shared/dialogs.dart';
import 'package:mimic/widgets/hashtag_item.dart';
import 'package:mimic/widgets/person_details.dart';
import 'package:mimic/widgets/rounded_image.dart';
import 'package:mimic/widgets/video_statistic_item.dart';
import 'package:mimic/modules/comments/comments_screen.dart';
import 'package:mimic/modules/home/widgets/black_opacity.dart';
import 'package:mimic/modules/home/widgets/header_name.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/routes_manager.dart';
import 'package:mimic/presentation/resourses/strings_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/defulat_button.dart';
import 'package:mimic/widgets/mimic_icons.dart';
import 'package:mimic/widgets/play_video_icon.dart';

class ChallengeDetailsScreen extends StatelessWidget {
  const ChallengeDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TransparentAppBar(title: 'Challenge'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _VideoPlayer(),
                _statisticsAndJoinButton(context),
                SizedBox(height: 12.h),
                const ChallengeTitle(),
                SizedBox(height: 5.h),
                const ChallengeDescription(),
                const SizedBox(height: 4),
                _hashtags(),
                SizedBox(height: 13.h),
                _remainingTime(context),
                SizedBox(height: 15.h),
                _peopleJoined(context),
                SizedBox(height: 16.h),
                _headerChallenges(),
                _challenges(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _statisticsAndJoinButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 18.0.h, left: 8.w, right: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(child: _VideoStatistics()),
          SizedBox(
            width: screenWidth(context) * 0.31,
            child: DefaultButton(
              height: screenHeight(context) * 0.055,
              text: 'Join',
              onPressed: () {},
              trailing: const Icon(Icons.add),
              foregroundColor: ColorManager.white,
              backgroundColor: Theme.of(context).primaryColor,
              radius: 20.r,
            ),
          )
        ],
      ),
    );
  }

  Widget _hashtags() {
    return Wrap(
      spacing: 9.w,
      children: const [
        HashtagItem(title: 'Volleyball'),
        HashtagItem(title: 'Developer'),
        HashtagItem(title: 'Entertainment'),
      ],
    );
  }

  Widget _remainingTime(context) {
    return Wrap(
      spacing: 10.w,
      children: [
        Text(
          '2 days, 10 hours, 12 min',
          style: getBoldStyle(
              color: Theme.of(context).primaryColor, fontSize: FontSize.s12),
        ),
        Text(
          'Remaining',
          style: getRegularStyle(fontSize: FontSize.s8),
        ),
      ],
    );
  }

  Widget _peopleJoined(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '15 people joined',
          style: getBoldStyle(),
        ),
        Row(
          children: [
            Expanded(
              child: Wrap(
                spacing: 10,
                children: [
                  for (int i = 0; i < 4; i++)
                    RoundedImage(
                      imagePath: 'assets/images/static/avatar.png',
                      size: 28.r,
                    )
                ],
              ),
            ),
            TextButton(
                onPressed: () {
                  navigateTo(context, Routes.allChallengers);
                },
                child: Text(
                  'VIEW ALL',
                  style: getRegularStyle(fontSize: FontSize.s8)
                      .copyWith(decoration: TextDecoration.underline),
                ))
          ],
        ),
      ],
    );
  }

  Widget _headerChallenges() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const HeaderName(
          'TOP CHALLENGERS',
          fontSize: FontSize.s14,
          displaySelectedIndicator: false,
          selected: true,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Text(
            'By date',
            style: getRegularStyle(),
          ),
        )
      ],
    );
  }

  Widget _challenges(BuildContext context) {
    return Column(
      children: [
        const ChallengesGridView(itemCount: 4),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            onPressed: () {
              navigateTo(context, Routes.allChallengers);
            },
            child: Text(
              'VIEW ALL >>',
              style: getRegularStyle(
                      fontSize: FontSize.s8,
                      color: ColorManager.visibilityColor)
                  .copyWith(decoration: TextDecoration.underline),
            ),
          ),
        ),
      ],
    );
  }
}

class _VideoPlayer extends StatelessWidget {
  const _VideoPlayer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(context, Routes.challengerVideo);
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        height: screenHeight(context) * 0.43,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            Image.asset('assets/images/static/video_preview.png',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.fill),
            const BlackOpacity(opacity: 0.4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(child: PersonDetails()),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ReportPopupMenuButton(
                    iconColor: ColorManager.white,
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: Row(
                children: [
                  const Spacer(),
                  PlayVideoIcon(
                    size: 44.r,
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(
                          Icons.skip_next,
                          size: 30,
                          color: ColorManager.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _VideoStatistics extends StatelessWidget {
  const _VideoStatistics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(spacing: 10, children: [
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
      ShareIcon(count: '88', textColor: ColorManager.black),
    ]);
  }
}
