import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mimic/main.dart';
import 'package:mimic/modules/challenges/widgets/challenge_person_details.dart';
import 'package:mimic/modules/challenges/widgets/challenge_title_and_discription.dart';
import 'package:mimic/modules/challenges/widgets/report_popup_menu_button.dart';
import 'package:mimic/modules/challenges/widgets/transparent_app_bar.dart';
import 'package:mimic/shared/dialogs.dart';
import 'package:mimic/widgets/video_statistic_item.dart';
import 'package:mimic/modules/home/widgets/black_opacity.dart';
import 'package:mimic/widgets/person_details.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/mimic_icons.dart';
import 'package:mimic/widgets/play_video_icon.dart';

class ChallengerVideo extends StatelessWidget {
  const ChallengerVideo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TransparentAppBar(title: 'Challenge'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Expanded(
                  //     child: PersonDetails(
                  //   imageRadius: 30,
                  //   textColor: ColorManager.black,
                  // )),
                  const ReportPopupMenuButton(),
                ],
              ),
              SizedBox(height: 10.h),
              _video(context),
              SizedBox(height: 15.h),
              _statistics(context),
              SizedBox(height: 13.h),
            //  const ChallengeTitle(),
              SizedBox(height: 10.h),
              //const ChallengeDescription(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _video(BuildContext context) {
    return Container(
      height: 410.h,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(48.r)),
      child: Stack(
        children: [
          Image.asset(getVideoImageRandom(),
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill),
          const BlackOpacity(opacity: 0.35),
          Align(
            alignment: Alignment.center,
            child: Row(
              children: [
                const Spacer(),
                const PlayVideoIcon(size: 40),
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
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.volume_mute,
                  color: ColorManager.white,
                ),
              )),
        ],
      ),
    );
  }

  Widget _statistics(BuildContext context) {
    return Wrap(spacing: 10.w, children: [
      FavoriteIcon(count: '12', textColor: ColorManager.black),
      CommentIcon(
        count: '12',
        textColor: ColorManager.black,
        onPressed: () {
          Dialogs.showCommentsDialog(context,3);
        },
      ),
      ViewIcon(
          count: '12',
          iconColor: ColorManager.commentsColor,
          textColor: ColorManager.black),
    ]);
  }
}
