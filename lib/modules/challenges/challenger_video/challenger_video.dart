import 'package:flutter/material.dart';
import 'package:mimic/modules/challenges/widgets/challenge_person_details.dart';
import 'package:mimic/modules/challenges/widgets/challenge_title_and_discription.dart';
import 'package:mimic/modules/challenges/widgets/report_popup_menu_button.dart';
import 'package:mimic/modules/challenges/widgets/transparent_app_bar.dart';
import 'package:mimic/shared/dialogs.dart';
import 'package:mimic/widgets/video_statistic_item.dart';
import 'package:mimic/modules/home/widgets/black_opacity.dart';
import 'package:mimic/modules/home/widgets/person_details.dart';
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
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                      child: ChallengePersonDetails(
                    textColor: ColorManager.black,
                  )),
                  const ReportPopupMenuButton(),
                ],
              ),
              _video(context),
              const SizedBox(height: 10),
              _statistics(context),
              const SizedBox(height: 20),
              const ChallengeTitle(),
              const SizedBox(height: 10),
              const ChallengeDescription(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _video(BuildContext context) {
    return Container(
      height: screenHeight(context) * 0.5,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Stack(
        children: [
          Image.asset('assets/images/static/video_preview.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill),
          const BlackOpacity(opacity: 0.4),
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
    return Wrap(spacing: 10, children: [
      VideStatisticsItem(
        MimicIcons.favoriteFill,
        '15',
        filledColor: Theme.of(context).primaryColor,
      ),
      VideStatisticsItem(
        MimicIcons.comments,
        '12',
        onPressed: () {
          Dialogs.showCommentsDialog(context);
        },
      ),
      const VideStatisticsItem(Icons.visibility, '9'),
    ]);
  }
}
