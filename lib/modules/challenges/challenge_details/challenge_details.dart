import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/modules/challenges/widgets/challenge_person_details.dart';
import 'package:mimic/modules/challenges/widgets/challenge_title_and_discription.dart';
import 'package:mimic/modules/challenges/widgets/challenges_grid_view.dart';
import 'package:mimic/modules/challenges/widgets/report_popup_menu_button.dart';
import 'package:mimic/modules/challenges/widgets/transparent_app_bar.dart';
import 'package:mimic/shared/dialogs.dart';
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
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _VideoPlayer(),
                _statisticsAndJoinButton(context),
                const SizedBox(height: 5),
                const ChallengeTitle(),
                const SizedBox(height: 5),
                const ChallengeDescription(),
                const SizedBox(height: 10),
                _hashtags(),
                const SizedBox(height: 10),
                const SizedBox(height: 10),
                _remainingTime(context),
                const SizedBox(height: 10),
                _peopleJoined(context),
                const SizedBox(height: 10),
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
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(child: _VideoStatistics()),
          DefaultButton(
            width: screenWidth(context) * 0.31,
            height: screenHeight(context) * 0.055,
            text: 'Join',
            onPressed: () {},
            trailing: const Icon(Icons.add),
            foregroundColor: ColorManager.white,
            backgroundColor: Theme.of(context).primaryColor,
            radius: 20.r,
          )
        ],
      ),
    );
  }

  Widget _hashtags() {
    return Wrap(
      spacing: 10,
      children: const [
        _HashtagBuilder(title: 'Volleyball'),
        _HashtagBuilder(title: 'Developer'),
        _HashtagBuilder(title: 'Entertainment'),
      ],
    );
  }

  Widget _remainingTime(context) {
    return Wrap(
      spacing: 10,
      children: [
        Text(
          '2 days, 10 hours, 12 min',
          style: getBoldStyle(
              color: Theme.of(context).primaryColor, fontSize: FontSize.s14),
        ),
        Text(
          'Remaining',
          style: getRegularStyle(fontSize: FontSize.s10),
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
                  style: getRegularStyle()
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
        Text(
          'By date',
          style: getRegularStyle(),
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
              style: getBoldStyle(
                      fontSize: FontSize.s10,
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
        showDialog(context: context, builder: (_) => const _VideoPopup());
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
                const Expanded(child: ChallengePersonDetails()),
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
                  const PlayVideoIcon(),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(
                          Icons.skip_next,
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
      ViewIcon(count: '112', textColor: ColorManager.black),
      ShareIcon(count: '88', textColor: ColorManager.black),
    ]);
  }
}

class _HashtagBuilder extends StatelessWidget {
  const _HashtagBuilder({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      '#$title',
      style: getBoldStyle(color: ColorManager.hashtagColor),
    );
  }
}

class _VideoPopup extends StatelessWidget {
  const _VideoPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _video(context),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
            child: _statistics(context),
          ),
        ],
      ),
    );
  }

  Widget _video(context) {
    return SizedBox(
      height: screenHeight(context) * 0.4,
      child: Stack(
        children: [
          Image.asset('assets/images/static/video_preview.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill),
          const Center(
              child: PlayVideoIcon(
            size: 50,
          )),
          Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.volume_off_outlined,
                  color: ColorManager.white,
                ),
              )),
        ],
      ),
    );
  }

  Widget _statistics(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: [
        FavoriteIcon(count: '12', textColor: ColorManager.black),
        CommentIcon(
          count: '19',
          textColor: ColorManager.black,
          onPressed: () {
            Dialogs.showCommentsDialog(context);
          },
        ),
        ViewIcon(count: '112', textColor: ColorManager.black),
      ],
    );
  }
}
